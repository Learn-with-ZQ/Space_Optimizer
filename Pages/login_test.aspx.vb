Imports System.Text.RegularExpressions
Imports System.Data

Partial Class Pages_login_test
    Inherits System.Web.UI.Page
    Dim model As New Model

#Region "Page Events"
    Private Sub Pages_Login_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Session.RemoveAll()
            ClearFields()
        End If
    End Sub

    Public Sub ClearFields()
        txtEmail.Text = ""
        txtLoginEmail.Text = ""
        txtLoginPassword.Text = ""
        txtName.Text = ""
        txtPassword.Text = ""
        txtPasswordF.Text = ""
        txtEmailF.Text = ""
        txtCodeF.Text = ""
    End Sub
#End Region

    Sub VerifyLogin()
        Dim ht As Hashtable = New Hashtable
        ht.Clear()
        ht.Add("UserName", txtLoginEmail.Text)
        ht.Add("Password", model.Encrypt(txtLoginPassword.Text))
        Dim dt = model.ExecuteSP("SP_User_verify", ht).Tables(0)
        If dt.Rows.Count > 0 Then
            If dt.Rows(0)("Active").ToString().Trim() = 1 Then
                Dim _adminObj As New SessionObject.AdminObj
                _adminObj = CType(Session.Item("AdminObj"), SessionObject.AdminObj)
                _adminObj.UserName = dt.Rows(0)("Username").ToString().Trim()
                _adminObj.UserID = dt.Rows(0)("UserID_pk").ToString().Trim()
                _adminObj.model = model
                _adminObj.SessionID = Session.SessionID
                Session("AdminObj") = _adminObj
                Response.Redirect("~/Pages/AddShapes.aspx")
            Else
                ht.Clear()
                ht.Add("Index", 1)
                ht.Add("UserName", txtLoginEmail.Text)
                dt = model.ExecuteSP("SP_User_Update", ht).Tables(0)
                hdnotp.Value = dt.Rows(0)("otp")
                hdnMail.Value = dt.Rows(0)("UserEmail")
                model.SendEmail(txtEmail.Text, "signup", hdnotp.Value)
                divLoginOtp.Visible = True
            End If
        Else
            alertE.InnerText = "Invalid Email or Password"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
        End If
    End Sub

#Region "button Login"
    Private Sub btnLogin_Click(sender As Object, e As EventArgs) Handles btnLogin.Click
        Dim ht As Hashtable = New Hashtable
        If divLoginOtp.Visible Then
            If hdnotp.Value = txtLoginOtp.Text Then
                ht.Clear()
                ht.Add("Index", 2)
                ht.Add("UserName", txtLoginEmail.Text)
                hdnotp.Value = model.ExecuteSP("SP_User_Update", ht).Tables(0).Rows(0)(0)
                VerifyLogin()
            End If
        Else
            VerifyLogin()
        End If
    End Sub

    Private Sub btnForgotPasswordToggle_Click(sender As Object, e As EventArgs) Handles btnForgotPasswordToggle.Click
        DivReset.Visible = True
        DivLogin.Visible = False
        DivSignIn.Visible = False
        ClearFields()
    End Sub

    Private Sub btnSignInToggle_Click(sender As Object, e As EventArgs) Handles btnSignInToggle.Click
        DivReset.Visible = False
        DivLogin.Visible = False
        DivSignIn.Visible = True
        ClearFields()
    End Sub
#End Region

#Region "button Signup"
    Function ValidatePassword(ByVal pwd As String,
        Optional ByVal minLength As Integer = 8,
        Optional ByVal numUpper As Integer = 1,
        Optional ByVal numLower As Integer = 1,
        Optional ByVal numNumbers As Integer = 1,
        Optional ByVal numSpecial As Integer = 1) As Boolean

        ' Replace [A-Z] with \p{Lu}, to allow for Unicode uppercase letters.
        Dim upper As New System.Text.RegularExpressions.Regex("[A-Z]")
        Dim lower As New System.Text.RegularExpressions.Regex("[a-z]")
        Dim number As New System.Text.RegularExpressions.Regex("[0-9]")
        ' Special is "none of the above".
        Dim special As New System.Text.RegularExpressions.Regex("[^a-zA-Z0-9]")

        ' Check the length.
        If Len(pwd) < minLength Then Return False
        ' Check for minimum number of occurrences.
        If upper.Matches(pwd).Count < numUpper Then Return False
        If lower.Matches(pwd).Count < numLower Then Return False
        If number.Matches(pwd).Count < numNumbers Then Return False
        If special.Matches(pwd).Count < numSpecial Then Return False

        ' Passed all checks.
        Return True
    End Function
    Private Sub btnSignup_Click(sender As Object, e As EventArgs) Handles btnSignup.Click
        Dim ht As Hashtable = New Hashtable
        If txtName.Text = "" Then
            alertE.InnerText = "Enter Name"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
        ElseIf Not Regex.IsMatch(txtEmail.Text, "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$") Then
            alertE.InnerText = "Enter a Valid Email Address"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
            Exit Sub
        ElseIf Not ValidatePassword(txtPassword.Text) Then
            alertE.InnerText = "Enter Strong Password"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
            Exit Sub
        Else
            ht.Add("Index", 1)
            ht.Add("Name", txtName.Text)
            Dim ds = model.ExecuteSP("SP_User_insert", ht)
            If ds.Tables(0).Rows(0)(0) <> 0 Then
                alertE.InnerText = "UserName Already found"
                txtName.Text = ""
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
                Exit Sub
            End If
            ht.Clear()
            ht.Add("Index", 2)
            ht.Add("Email", txtEmail.Text)
            ds = model.ExecuteSP("SP_User_insert", ht)
            If ds.Tables(0).Rows(0)(0) <> 0 Then
                alertE.InnerText = "UserEmail Already found"
                txtEmail.Text = ""
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
                Exit Sub
            End If
            ht.Clear()
            ht.Add("Name", txtName.Text)
            ht.Add("Email", txtEmail.Text)
            ht.Add("Password", model.Encrypt(txtPassword.Text))
            ds = model.ExecuteSP("SP_User_insert", ht)
            If ds.Tables(0).Rows(0)(0) <> 0 Then
                alertS.InnerText = "Account Created Successfully"
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showSuccessAlert", "showSuccessAlert();", True)
            Else
                alertS.InnerText = "Account not Created"
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
            End If
        End If
        ClearFields()
    End Sub

    Private Sub btnLoginToggle_Click(sender As Object, e As EventArgs) Handles btnLoginToggle.Click
        DivReset.Visible = False
        DivLogin.Visible = True
        DivSignIn.Visible = False
        ClearFields()
    End Sub
#End Region

#Region "Forgot Password"
    Private Sub btnLoginToggleF_Click(sender As Object, e As EventArgs) Handles btnLoginToggleF.Click
        DivReset.Visible = False
        DivLogin.Visible = True
        DivSignIn.Visible = False
        ClearFields()
    End Sub
#End Region
End Class
