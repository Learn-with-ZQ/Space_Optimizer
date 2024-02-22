Imports Telerik.Web.UI
Imports System.Data
Imports System.Net.Http
Imports Newtonsoft.Json

Partial Class Pages_Optimize
    Inherits System.Web.UI.Page
    Dim model As Model
    Dim _adminObj As New SessionObject.AdminObj
#Region "Page Event"
    Private Sub Pages_Optimizer_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Session.Item("AdminObj") IsNot Nothing Then
            _adminObj = CType(Session.Item("AdminObj"), SessionObject.AdminObj)
            model = _adminObj.model
            If Not IsPostBack Then
                Fill_Container()
            End If
        Else
            Response.Redirect("~/Pages/Login.aspx")
        End If
    End Sub
#End Region

#Region "Data Event"
    Private Sub Fill_Container()
        Dim ht As Hashtable = New Hashtable
        ht.Add("UserDetailID_fk", _adminObj.UserID)
        Dim dt = model.ExecuteSP("SP_User_Shape_Setup", ht).Tables(0)
        model.FillCombo(dt, cmbContainer)
    End Sub

    Private Sub Fill_Shape()
        cmbObjects.Items.Clear()
        Dim ht As Hashtable = New Hashtable
        ht.Add("UserDetailID_fk", _adminObj.UserID)
        ht.Add("Index", 1)
        ht.Add("ObjectID_Pk", cmbContainer.SelectedValue)
        Dim dt = model.ExecuteSP("SP_User_Shape_Setup", ht).Tables(0)
        model.FillCombo(dt, cmbObjects)
        For Each item As RadComboBoxItem In cmbObjects.Items
            item.Checked = True
        Next
    End Sub
#End Region

#Region "Button Optimize"
    Private Sub btnOptimize_Click(sender As Object, e As EventArgs) Handles btnOptimize.Click
        Dim ht As Hashtable = New Hashtable
        Dim id = ""
        If cmbContainer.SelectedValue = "" Or cmbContainer.SelectedValue = 0 Then
            alertE.InnerText = "Select Container first"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
            Exit Sub
        End If
        If cmbObjects.CheckedItems.Count = 0 Then
            alertE.InnerText = "Select Container first"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
            Exit Sub
        End If
        For Each item As RadComboBoxItem In cmbObjects.Items
            If item.Checked Then
                id += item.Value + " "
            End If
        Next
        ht.Add("UserDetailID_fk", _adminObj.UserID)
        ht.Add("Index", 1)
        ht.Add("IDs", id)
        ht.Add("ContainerID", cmbContainer.SelectedValue)
        Dim ds = model.ExecuteSP("SP_User_Shape_Query", ht)
        Dim shapeArray(1) As Integer
        shapeArray(0) = Convert.ToInt32(ds.Tables(1).Rows(0)("ShapeLength"))
        shapeArray(1) = Convert.ToInt32(ds.Tables(1).Rows(0)("ShapeWidth"))
        Try
            Dim client As New HttpClient()
            'client.Timeout = TimeSpan.FromMinutes(60)
            Dim apiUrl As String = "http://localhost:5000/optimize" ' Update the URL with the correct address and port

            ' Prepare the data to be sent
            Dim requestData As New With {
            .dataList = ds.Tables(0), ' Replace dataList with your actual data
            .shapeArray = shapeArray, ' Replace shapeArray with your actual data
            .userID = _adminObj.UserName + "_" + CType(_adminObj.UserID, String)
        }

            ' Serialize the data to JSON
            Dim jsonRequestData As String = JsonConvert.SerializeObject(requestData)

            ' Set up the request headers
            client.DefaultRequestHeaders.Accept.Add(New Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"))

            ' Send the POST request
            Dim response = client.PostAsync(apiUrl, New StringContent(jsonRequestData, Text.Encoding.UTF8, "application/json")).Result

            ' Check if the request was successful
            If response.IsSuccessStatusCode Then
                ' Parse the JSON response
                Dim jsonResponse = response.Content.ReadAsStringAsync().Result
                Dim result = JsonConvert.DeserializeObject(Of Dictionary(Of String, Object))(jsonResponse)

                ' Access the results
                Dim filename As String = result("filename").ToString()
                Dim wasted_area As Integer = Convert.ToInt32(result("wasted_area"))
                Dim selected_shapes = result("selected_shapes")
                imgOutput.Src = "~" + filename
                txtOutput.Text = $"Wasted Area = {wasted_area}ft{Environment.NewLine}Shape Selected:{Environment.NewLine}{selected_shapes}"
                divOutput.Visible = True
            Else
                alertE.InnerText = $"Error: {response.StatusCode}"
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
            End If
        Catch ex As Exception
            alertE.InnerText = $"Error: {ex.Message}"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showErrorAlert", "showErrorAlert();", True)
        End Try
    End Sub
#End Region

#Region "Combo"
    Private Sub cmbContainer_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cmbContainer.SelectedIndexChanged
        Fill_Shape()
    End Sub

    Private Sub cmbObjects_ItemChecked(sender As Object, e As RadComboBoxItemEventArgs) Handles cmbObjects.ItemChecked
        Dim checkedItemsCount As Integer = 0

        ' Iterate through the items and count the checked ones
        For Each item As RadComboBoxItem In cmbObjects.Items
            If item.Checked Then
                checkedItemsCount += 1
            End If
        Next

        cmbObjects.Text = $"{checkedItemsCount} Item selected"
    End Sub
#End Region
End Class