Imports Telerik.Web.UI

Partial Class Pages_AddShapes
    Inherits System.Web.UI.Page
    Dim model As Model
    Dim _adminObj As SessionObject.AdminObj

#Region "Pages Event"
    Private Sub Pages_AddShapes_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Session.Item("AdminObj") IsNot Nothing Then
            _adminObj = CType(Session.Item("AdminObj"), SessionObject.AdminObj)
            model = _adminObj.model
            If Not IsPostBack Then
                TgridObjects.Rebind()
            End If
        Else
            Response.Redirect("~/Pages/Login.aspx")
        End If
    End Sub
#End Region

#Region "Insert button"
    Private Sub btnInsert_Click(sender As Object, e As EventArgs) Handles btnInsert.Click
        If cmbType.SelectedValue = "" Or cmbType.SelectedValue = -1 Then
            alertE.InnerText = "Select Container first"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
            Exit Sub
        End If
        If cmbShapeType.SelectedValue = "" Or cmbShapeType.SelectedValue = 0 Then
            alertE.InnerText = "Select Shape first"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
            Exit Sub
        End If
        If txtName.Text = "" Then
            alertE.InnerText = "Enter Name"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
            Exit Sub
        End If
        If NumTxtQuantity.Text = "" Or NumTxtQuantity.Text = 0 Then
            alertE.InnerText = "Enter Quantity"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
            Exit Sub
        End If
        If NumTxtLength.Text = "" Or NumTxtLength.Text = 0 Then
            alertE.InnerText = "Enter Length"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
            Exit Sub
        End If
        If NumTxtWidth.Text = "" Or NumTxtWidth.Text = 0 Then
            alertE.InnerText = "Enter Width"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
            Exit Sub
        End If
        Dim ht As Hashtable = New Hashtable
        ht.Add("ShapeName", txtName.Text)
        ht.Add("ShapeTypeID_fk", cmbShapeType.SelectedValue)
        If NumTxtWidth.Enabled = False Then
            NumTxtWidth.Text = NumTxtLength.Text
        End If
        ht.Add("ShapeWidth", NumTxtWidth.Text)
        ht.Add("ShapeLength", NumTxtLength.Text)
        ht.Add("Quantity", NumTxtQuantity.Text)
        ht.Add("IsContainer", cmbType.SelectedValue)
        ht.Add("UserDetailID_fk", _adminObj.UserID)
        If cmbShapeType.SelectedValue = 1 Or cmbShapeType.SelectedValue = 2 Then
            ht.Add("ActualWidth", NumTxtWidth.Text)
            ht.Add("ActualLength", NumTxtLength.Text)
        ElseIf cmbShapeType.SelectedValue = 3 Then
            ht.Add("ActualWidth", NumTxtWidth.Text)
            ht.Add("ActualLength", CType(NumTxtLength.Text, Integer) + CType(NumTxtWidth.Text, Integer) - 1)
        ElseIf cmbShapeType.SelectedValue = 4 Then
            ht.Add("ActualWidth", NumTxtWidth.Text * 2 - 1)
            ht.Add("ActualLength", NumTxtLength.Text + NumTxtWidth.Text - 1)
        ElseIf cmbShapeType.SelectedValue = 5 Then
            ht.Add("ActualWidth", NumTxtWidth.Text)
            ht.Add("ActualLength", NumTxtLength.Text * 2 - 1)
        ElseIf cmbShapeType.SelectedValue = 6 Then
            ht.Add("ActualWidth", NumTxtWidth.Text * 3 - 2)
            ht.Add("ActualLength", NumTxtLength.Text * 2 - 1)
        End If
        Dim id = model.ExecuteSP("SP_User_Shape_Insert", ht).Tables(0).Rows(0)(0)
        If id > 0 Then
            alertS.InnerText = "Insert Successfully"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showSuccessAlert", "showSuccessAlert();", True)
            ClearFields()
        Else
            alertS.InnerText = "Insert Fails"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
        End If
        TgridObjects.Rebind()
    End Sub

#End Region

#Region "Grid Data"
    Private Sub TgridObjects_NeedDataSource(sender As Object, e As GridNeedDataSourceEventArgs) Handles TgridObjects.NeedDataSource
        Dim ht As Hashtable = New Hashtable
        ht.Add("UserDetailID_fk", _adminObj.UserID)
        Dim dt = model.ExecuteSP("SP_User_Shape_Query", ht).Tables(0)
        TgridObjects.DataSource = dt
    End Sub

#End Region

#Region "Grid Event"
    Private Sub TgridObjects_ItemDataBound(sender As Object, e As GridItemEventArgs) Handles TgridObjects.ItemDataBound
        If TypeOf e.Item Is GridDataItem Then
            Dim cmbShapeType = CType(e.Item.FindControl("cmbShapeType_grid"), RadComboBox)
            Dim NumTxtWidth = CType(e.Item.FindControl("NumTxtWidth_grid"), RadNumericTextBox)
            If cmbShapeType.SelectedValue = 2 Or cmbShapeType.SelectedValue = 4 Or cmbShapeType.SelectedValue = 5 Or cmbShapeType.SelectedValue = 6 Then
                NumTxtWidth.Enabled = False
            Else
                NumTxtWidth.Enabled = True
            End If
        End If
    End Sub

    Protected Sub cmbType_grid_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)
        Dim cmbType = CType(sender, RadComboBox)
        Dim cmbShapeType = CType(cmbType.NamingContainer.FindControl("cmbShapeType_grid"), RadComboBox)
        Dim NumTxtQuantity_grid = CType(cmbType.NamingContainer.FindControl("NumTxtQuantity_grid"), RadNumericTextBox)
        If cmbType.SelectedValue = 1 Then
            cmbShapeType.SelectedValue = 1
            cmbShapeType.Enabled = False
            NumTxtQuantity.Text = 1
            NumTxtQuantity.Enabled = False
        Else
            cmbShapeType.SelectedValue = Nothing
            cmbShapeType.Enabled = True
            NumTxtQuantity.Text = Nothing
            NumTxtQuantity.Enabled = True
        End If
    End Sub

    Protected Sub cmbShapeType_grid_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)
        Dim cmbShapeType = CType(sender, RadComboBox)
        Dim NumTxtWidth = CType(cmbShapeType.NamingContainer.FindControl("NumTxtWidth_grid"), RadNumericTextBox)
        Dim NumTxtLength = CType(cmbShapeType.NamingContainer.FindControl("NumTxtLength_grid"), RadNumericTextBox)
        If cmbShapeType.SelectedValue = 2 Or cmbShapeType.SelectedValue = 4 Or cmbShapeType.SelectedValue = 5 Or cmbShapeType.SelectedValue = 6 Then
            NumTxtWidth.Enabled = False
            NumTxtWidth.Text = NumTxtLength.Text
        Else
            NumTxtWidth.Enabled = True
            NumTxtWidth.Text = 1
        End If
    End Sub

    Protected Sub NumTxtLength_grid_TextChanged(sender As Object, e As EventArgs)
        Dim NumTxtLength = CType(sender, RadNumericTextBox)
        Dim cmbShapeType = CType(NumTxtLength.NamingContainer.FindControl("cmbShapeType_grid"), RadComboBox)
        Dim NumTxtWidth = CType(NumTxtLength.NamingContainer.FindControl("NumTxtWidth_grid"), RadNumericTextBox)
        Dim NumTxtActLength = CType(NumTxtLength.NamingContainer.FindControl("NumTxtActLength_grid"), RadNumericTextBox)
        Dim NumTxtActWidth = CType(NumTxtLength.NamingContainer.FindControl("NumTxtActWidth_grid"), RadNumericTextBox)
        If cmbShapeType.SelectedValue = 1 Or cmbShapeType.SelectedValue = 2 Then
            If cmbShapeType.SelectedValue = 2 Then
                NumTxtWidth.Text = NumTxtLength.Text
            End If
            NumTxtActWidth.Text = NumTxtWidth.Text
            NumTxtActLength.Text = NumTxtLength.Text
        ElseIf cmbShapeType.SelectedValue = 3 Then
            NumTxtActWidth.Text = NumTxtWidth.Text
            NumTxtActLength.Text = CType(NumTxtLength.Text, Integer) + CType(NumTxtWidth.Text, Integer) - 1
        ElseIf cmbShapeType.SelectedValue = 4 Then
            NumTxtWidth.Text = NumTxtLength.Text
            NumTxtActWidth.Text = NumTxtWidth.Text * 2 - 1
            NumTxtActLength.Text = NumTxtLength.Text + NumTxtWidth.Text - 1
        ElseIf cmbShapeType.SelectedValue = 5 Then
            NumTxtWidth.Text = NumTxtLength.Text
            NumTxtActWidth.Text = NumTxtWidth.Text
            NumTxtActLength.Text = NumTxtLength.Text * 2 - 1
        ElseIf cmbShapeType.SelectedValue = 6 Then
            NumTxtWidth.Text = NumTxtLength.Text
            NumTxtActWidth.Text = NumTxtWidth.Text * 3 - 2
            NumTxtActLength.Text = NumTxtLength.Text * 2 - 1
        End If
    End Sub

    Protected Sub NumTxtWidth_grid_TextChanged(sender As Object, e As EventArgs)
        Dim NumTxtWidth = CType(sender, RadNumericTextBox)
        Dim NumTxtLength = CType(NumTxtWidth.NamingContainer.FindControl("NumTxtLength_grid"), RadNumericTextBox)
        Dim cmbShapeType = CType(NumTxtWidth.NamingContainer.FindControl("cmbShapeType_grid"), RadComboBox)
        Dim NumTxtActLength = CType(NumTxtWidth.NamingContainer.FindControl("NumTxtActLength_grid"), RadNumericTextBox)
        Dim NumTxtActWidth = CType(NumTxtWidth.NamingContainer.FindControl("NumTxtActWidth_grid"), RadNumericTextBox)
        If cmbShapeType.SelectedValue = 1 Or cmbShapeType.SelectedValue = 2 Then
            NumTxtLength.Text = NumTxtWidth.Text
            NumTxtActWidth.Text = NumTxtWidth.Text
            NumTxtActLength.Text = NumTxtLength.Text
        ElseIf cmbShapeType.SelectedValue = 3 Then
            NumTxtActWidth.Text = NumTxtWidth.Text
            NumTxtActLength.Text = CType(NumTxtLength.Text, Integer) + CType(NumTxtWidth.Text, Integer) - 1
        ElseIf cmbShapeType.SelectedValue = 4 Then
            NumTxtWidth.Text = NumTxtLength.Text
            NumTxtActWidth.Text = NumTxtWidth.Text * 2 - 1
            NumTxtActLength.Text = NumTxtLength.Text + NumTxtWidth.Text - 1
        ElseIf cmbShapeType.SelectedValue = 5 Then
            NumTxtWidth.Text = NumTxtLength.Text
            NumTxtActWidth.Text = NumTxtWidth.Text
            NumTxtActLength.Text = NumTxtLength.Text * 2 - 1
        ElseIf cmbShapeType.SelectedValue = 6 Then
            NumTxtWidth.Text = NumTxtLength.Text
            NumTxtActWidth.Text = NumTxtWidth.Text * 3 - 2
            NumTxtActLength.Text = NumTxtLength.Text * 2 - 1
        End If
    End Sub

    Private Sub TgridObjects_ItemCommand(sender As Object, e As GridCommandEventArgs) Handles TgridObjects.ItemCommand
        Dim NumTxtActLength = CType(NumTxtLength.NamingContainer.FindControl("NumTxtLength_grid"), RadNumericTextBox)
        Dim NumTxtActWidth = CType(NumTxtLength.NamingContainer.FindControl("NumTxtActWidth_grid"), RadNumericTextBox)
        Dim ht As New Hashtable
        If e.CommandName = "btnEdit" Then
            ht.Add("ShapeID_pk", CType(e.Item.FindControl("lblShapeID_pk"), Label).Text)
            ht.Add("ShapeName", CType(e.Item.FindControl("txtName_grid"), RadTextBox).Text)
            ht.Add("ShapeTypeID_fk", CType(e.Item.FindControl("cmbShapeType_grid"), RadComboBox).SelectedValue)
            ht.Add("ShapeWidth", CType(e.Item.FindControl("NumTxtWidth_grid"), RadNumericTextBox).Text)
            ht.Add("ShapeLength", CType(e.Item.FindControl("NumTxtLength_grid"), RadNumericTextBox).Text)
            ht.Add("ActualWidth", CType(e.Item.FindControl("NumTxtActWidth_grid"), RadNumericTextBox).Text)
            ht.Add("ActualLength", CType(e.Item.FindControl("NumTxtActLength_grid"), RadNumericTextBox).Text)
            ht.Add("Quantity", CType(e.Item.FindControl("NumTxtQuantity_grid"), RadNumericTextBox).Text)
            ht.Add("IsContainer", CType(e.Item.FindControl("cmbType_grid"), RadComboBox).SelectedValue)
            ht.Add("UserDetailID_fk", _adminObj.UserID)
            Dim id = model.ExecuteSP("SP_User_Shape_Update", ht).Tables(0).Rows(0)(0)
            If id > 0 Then
                alertS.InnerText = "Updated Successfully"
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showSuccessAlert", "showSuccessAlert();", True)
                ClearFields()
            Else
                alertS.InnerText = "Update Fails"
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
            End If
            TgridObjects.Rebind()
        ElseIf e.CommandName = "btnDelete" Then
            ht.Add("ShapeID_pk", CType(e.Item.FindControl("lblShapeID_pk"), Label).Text)
            Dim id = model.ExecuteSP("SP_User_Shape_Delete", ht).Tables(0).Rows(0)(0)
            If id > 0 Then
                alertS.InnerText = "Deleted Successfully"
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showSuccessAlert", "showSuccessAlert();", True)
                ClearFields()
            Else
                alertS.InnerText = "Delete Fails"
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
            End If
            TgridObjects.Rebind()
        End If
    End Sub
#End Region

    Private Sub cmbShapeType_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cmbShapeType.SelectedIndexChanged
        If cmbShapeType.SelectedValue = 2 Or cmbShapeType.SelectedValue = 4 Or cmbShapeType.SelectedValue = 5 Or cmbShapeType.SelectedValue = 6 Then
            NumTxtWidth.Text = NumTxtLength.Text
            NumTxtWidth.Enabled = False
        Else
            NumTxtWidth.Text = NumTxtLength.Text
            NumTxtWidth.Enabled = True
        End If
    End Sub

    Protected Sub cmbType_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cmbType.SelectedIndexChanged
        If cmbType.SelectedValue = 1 Then
            cmbShapeType.SelectedValue = 1
            cmbShapeType.Enabled = False
            NumTxtQuantity.Text = 1
            NumTxtQuantity.Enabled = False
        Else
            cmbShapeType.SelectedValue = Nothing
            cmbShapeType.Enabled = True
            NumTxtQuantity.Text = Nothing
            NumTxtQuantity.Enabled = True
        End If
    End Sub

    Private Sub NumTxtLength_TextChanged(sender As Object, e As EventArgs) Handles NumTxtLength.TextChanged
        If cmbShapeType.SelectedValue = 2 Or cmbShapeType.SelectedValue = 4 Or cmbShapeType.SelectedValue = 5 Or cmbShapeType.SelectedValue = 6 Then
            NumTxtWidth.Text = NumTxtLength.Text
        Else
            NumTxtWidth.Text = 1
        End If
    End Sub

    Sub ClearFields()
        txtName.Text = Nothing
        cmbShapeType.SelectedValue = Nothing
        NumTxtWidth.Text = Nothing
        NumTxtWidth.Text = Nothing
        NumTxtLength.Text = Nothing
        NumTxtQuantity.Text = Nothing
    End Sub
End Class
