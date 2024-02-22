<%@ Page Title="" Language="VB" MasterPageFile="~/Master_pages/Main.master" AutoEventWireup="false" CodeFile="AddShapes.aspx.vb" Inherits="Pages_AddShapes" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .RadGrid_Outlook .rgAltRow td {
            border-color: #98acbf;
        }

        .RadGrid_Outlook .rgRow td {
            border-color: #98acbf;
        }

        .btn {
            background-repeat: no-repeat;
            padding: inherit
        }

        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap");

        .img_class {
            width: -webkit-fill-available !important
        }

        .alert {
            display: flex;
            justify-content: center;
            position: fixed;
            z-index: 100;
            top: 80px
        }

        .alertBox {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: auto;
            height: auto;
            border: 1px solid black;
            border-radius: 5px;
            background-color: rgba(255, 255, 255, 0.836);
        }

        .okBtn {
            width: 50px;
            height: 30px;
            background-color: rgba(20, 179, 219, 0.726);
            border: 0;
            border-radius: 5px;
        }

        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }

        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
    </style>
    <script src="../Scripts/Alert.js"></script>
    <asp:UpdatePanel runat="server">
        <ContentTemplate runat="server">
            <asp:ScriptManager runat="server"></asp:ScriptManager>
            <section class="container mb-5">
                <div class="row justify-content-center contact gap-5 gap-lg-0">
                    <div class="col-8 col-md-12 pt-5 d-flex flex-column align-items-center position-relative shadow mt-5 h-custom" style="height: fit-content;">

                        <div class="alert" id="successAlert" runat="server" style="display: none;">
                            <div class="alertBox alert-success">
                                <label for="">
                                    &nbsp
                            <label for="" runat="server" id="alertS">Message sent successfully</label>
                                    &nbsp
                <i class="fas fa-times" onclick="dismissAlert('ContentPlaceHolder1_successAlert', this)"></i>&nbsp

                                </label>
                            </div>
                        </div>

                        <div class="alert" id="errorAlert" runat="server" style="display: none;">
                            <div class="alertBox alert-danger">
                                <label for="">
                                    &nbsp
                            <label runat="server" id="alertE">Error sending message</label>
                                    &nbsp
                    <i class="fas fa-times" onclick="dismissAlert('ContentPlaceHolder1_errorAlert', this)"></i>&nbsp
                                </label>

                            </div>
                        </div>
                        <h4 class="font-light mb-4 underline">Setup Shapes</h4>
                        <div class="col-12 row">
                            <div class="col-1"></div>
                            <div class="col-10">
                                <div class="col-12 row">
                                    <div class="col-6">
                                        <div class="col-12 row">
                                            <div class="col-3">
                                                <label style="font-size: 15px; padding-top: 16px;">Object Type: </label>
                                            </div>
                                            <div class="col-9">
                                                <telerik:RadComboBox runat="server" ID="cmbType" Width="100%" AutoPostBack="true" CssClass="rounded-4 border py-2 px-5 my-2" Skin="Outlook" Filter="Contains" MaxHeight="110">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="--Select--" Value="-1" />
                                                        <telerik:RadComboBoxItem Text="Objects" Value="0" />
                                                        <telerik:RadComboBoxItem Text="Container" Value="1" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="col-12 row">
                                            <div class="col-3">
                                                <label style="font-size: 15px; padding-top: 16px;">Shape Type: </label>
                                            </div>
                                            <div class="col-9">
                                                <telerik:RadComboBox runat="server" ID="cmbShapeType" AutoPostBack="true" Width="100%" CssClass="rounded-4 border py-2 px-5 my-2" Skin="Outlook" Filter="Contains" MaxHeight="110">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="--Select--" Value="0" />
                                                        <telerik:RadComboBoxItem Text="Rectangle" Value="1" />
                                                        <telerik:RadComboBoxItem Text="Square" Value="2" />
                                                        <telerik:RadComboBoxItem Text="Parallelogram" Value="3" />
                                                        <telerik:RadComboBoxItem Text="Rombous" Value="4" />
                                                        <telerik:RadComboBoxItem Text="Triangle" Value="5" />
                                                        <telerik:RadComboBoxItem Text="Hexagon" Value="6" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-12 row">
                                    <div class="col-6">
                                        <div class="col-12 row">
                                            <div class="col-3">
                                                <label style="font-size: 15px; padding-top: 16px;">Name: </label>
                                            </div>
                                            <div class="col-9">
                                                <telerik:RadTextBox runat="server" ID="txtName" type="text" CssClass="rounded-4 border" Height="40px" Width="100%" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="col-12 row">
                                            <div class="col-3">
                                                <label style="font-size: 15px; padding-top: 16px;">Quantity: </label>
                                            </div>
                                            <div class="col-9">
                                                <telerik:RadNumericTextBox runat="server" ID="NumTxtQuantity" CssClass="rounded-4 border" MinValue="1" Type="Number" Height="40px" Width="100%">
                                                    <NumberFormat DecimalDigits="0" />
                                                </telerik:RadNumericTextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div style="height: 10px"></div>

                                <div class="col-12 row">
                                    <div class="col-6">
                                        <div class="col-12 row">
                                            <div class="col-3">
                                                <label style="font-size: 15px; padding-top: 16px;">Length: </label>
                                            </div>
                                            <div class="col-9">
                                                <telerik:RadNumericTextBox runat="server" ID="NumTxtLength" AutoPostBack="true" CssClass="rounded-4 border" MinValue="1" Type="Number" Height="40px" Width="100%">
                                                    <NumberFormat DecimalDigits="0" />
                                                </telerik:RadNumericTextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6" id="divWidth" runat="server">
                                        <div class="col-12 row">
                                            <div class="col-3">
                                                <label style="font-size: 15px; padding-top: 16px;">Width: </label>
                                            </div>
                                            <div class="col-9">
                                                <telerik:RadNumericTextBox runat="server" ID="NumTxtWidth" CssClass="rounded-4 border" MinValue="1" Type="Number" Height="40px" Width="100%">
                                                    <NumberFormat DecimalDigits="0" />
                                                </telerik:RadNumericTextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-1"></div>
                        </div>
                        <div class="col-12 row">
                            <div class="col-5"></div>
                            <div class="col-2">
                                <asp:Button ID="btnInsert" runat="server"
                                    CssClass="btn btn-sm btn-yellow rounded-4 fw-semibold py-2 px-5 my-2" Text="Insert" />
                            </div>
                            <div class="col-5"></div>
                        </div>

                        <div class="col-12">
                            <telerik:RadGrid ID="TgridObjects" GroupingEnabled="true" AllowFilteringByColumn="true" ShowFooter="true" ShowFilterIcon="False" GroupingSettings-CaseSensitive="false" CurrentFilterFunction="Contains" runat="server" PagerStyle-AlwaysVisible="True" AutoGenerateColumns="False" AllowPaging="true" AllowSorting="true" HeaderStyle-Font-Bold="true" CssClass="grid GridBorder" GridLines="None" Skin="Outlook">
                                <MasterTableView AllowPaging="true" AllowSorting="true" AllowFilteringByColumn="true" GridLines="None" ShowFooter="True" TableLayout="Auto" Width="100%">
                                    <Columns>
                                        <telerik:GridTemplateColumn FilterControlWidth="100%" AllowSorting="true" ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderText="ShapeID_pk" UniqueName="ShapeID_pk" DataField="ShapeID_pk" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblShapeID_pk" runat="server" Visible="false" HeaderText="ShapeID_pk" Text='<%# Eval("ShapeID_pk")%>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlWidth="85%" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderText="Object Type" UniqueName="Object_Type" DataField="Object_Type">
                                            <ItemTemplate>
                                                <telerik:RadComboBox runat="server" ID="cmbType_grid" SelectedValue='<%# Eval("IsContainer")%>' AutoPostBack="true" OnSelectedIndexChanged="cmbType_grid_SelectedIndexChanged" Width="100%" CssClass="rounded-4 border py-2 px-5 my-2" Skin="Outlook" Filter="Contains" MaxHeight="110">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="--Select--" Value="-1" />
                                                        <telerik:RadComboBoxItem Text="Objects" Value="0" />
                                                        <telerik:RadComboBoxItem Text="Container" Value="1" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlWidth="85%" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderText="Shape Type" UniqueName="Shape_Type" DataField="Shape_Type">
                                            <ItemTemplate>
                                                <telerik:RadComboBox runat="server" ID="cmbShapeType_grid" OnSelectedIndexChanged="cmbShapeType_grid_SelectedIndexChanged" AutoPostBack="true" SelectedValue='<%# Eval("ShapeTypeID_fk")%>' Width="100%" CssClass="rounded-4 border py-2 px-5 my-2" Skin="Outlook" Filter="Contains" MaxHeight="110">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="--Select--" Value="0" />
                                                        <telerik:RadComboBoxItem Text="Rectangle" Value="1" />
                                                        <telerik:RadComboBoxItem Text="Square" Value="2" />
                                                        <telerik:RadComboBoxItem Text="Parallelogram" Value="3" />
                                                        <telerik:RadComboBoxItem Text="Rombous" Value="4" />
                                                        <telerik:RadComboBoxItem Text="Triangle" Value="5" />
                                                        <telerik:RadComboBoxItem Text="Hexagon" Value="6" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlWidth="75%" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderText="Shape Name" UniqueName="ShapeName" DataField="ShapeName">
                                            <ItemTemplate>
                                                <telerik:RadTextBox runat="server" ID="txtName_grid" type="text" CssClass="rounded-4 border" Height="40px" Width="100%" Text='<%#Eval("ShapeName")%>' />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlWidth="75%" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderText="Quantity" UniqueName="Quantity" DataField="Quantity">
                                            <ItemTemplate>
                                                <telerik:RadNumericTextBox runat="server" ID="NumTxtQuantity_grid" AutoPostBack="true" CssClass="rounded-4 border" MinValue="1" Type="Number" Height="40px" Width="100%" Text='<%#Eval("Quantity")%>'>
                                                    <NumberFormat DecimalDigits="0" />
                                                </telerik:RadNumericTextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlWidth="75%" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderText="Shape Length" UniqueName="ShapeLength" DataField="ShapeLength">
                                            <ItemTemplate>
                                                <telerik:RadNumericTextBox runat="server" ID="NumTxtLength_grid" OnTextChanged="NumTxtLength_grid_TextChanged" AutoPostBack="true" CssClass="rounded-4 border" MinValue="1" Type="Number" Height="40px" Width="100%" Text='<%#Eval("ShapeLength")%>'>
                                                    <NumberFormat DecimalDigits="0" />
                                                </telerik:RadNumericTextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlWidth="75%" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderText="Shape Width" UniqueName="ShapeWidth" DataField="ShapeWidth">
                                            <ItemTemplate>
                                                <telerik:RadNumericTextBox runat="server" ID="NumTxtWidth_grid" AutoPostBack="true" OnTextChanged="NumTxtWidth_grid_TextChanged" CssClass="rounded-4 border" MinValue="1" Type="Number" Height="40px" Width="100%" Text='<%#Eval("ShapeWidth")%>'>
                                                    <NumberFormat DecimalDigits="0" />
                                                </telerik:RadNumericTextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlWidth="75%" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderText="Actual Length" UniqueName="ActualLength" DataField="ActualLength">
                                            <ItemTemplate>
                                                <telerik:RadNumericTextBox runat="server" ID="NumTxtActLength_grid" CssClass="rounded-4 border" Enabled="false" MinValue="1" Type="Number" Height="40px" Width="100%" Text='<%#Eval("ActualLength")%>'>
                                                    <NumberFormat DecimalDigits="0" />
                                                </telerik:RadNumericTextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlWidth="75%" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderText="Actual Width" UniqueName="ActualWidth" DataField="ActualWidth">
                                            <ItemTemplate>
                                                <telerik:RadNumericTextBox runat="server" ID="NumTxtActWidth_grid" CssClass="rounded-4 border" Enabled="false" MinValue="1" Type="Number" Height="40px" Width="100%" Text='<%#Eval("ActualWidth")%>'>
                                                    <NumberFormat DecimalDigits="0" />
                                                </telerik:RadNumericTextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Update" ShowFilterIcon="false" AllowFiltering="false" UniqueName="btnedit" FooterStyle-CssClass="hideColumn" FilterControlWidth="0px" HeaderStyle-CssClass="hideColumn" ItemStyle-CssClass="hideColumn">
                                            <ItemTemplate>
                                                <telerik:RadButton ID="btnEdit" runat="server" CssClass="GridImgbtn" ButtonType="StandardButton" UseSubmitBehavior="false" CommandName="btnEdit" Text="Edit" Height="24px" Width="24px">
                                                    <Image ImageUrl="../images/Save.png" />
                                                </telerik:RadButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Delete" ShowFilterIcon="false" AllowFiltering="false" UniqueName="DeleteColumn" FooterStyle-CssClass="hideColumn" FilterControlWidth="0px" HeaderStyle-CssClass="hideColumn" ItemStyle-CssClass="hideColumn">
                                            <ItemTemplate>
                                                <telerik:RadButton ID="BtnDelete" runat="server" CssClass="GridImgbtn btn" ButtonType="StandardButton" UseSubmitBehavior="false" CommandName="btnDelete" Text="Delete" Height="24px" Width="20px">
                                                    <Image ImageUrl="../images/Delete.png" />
                                                </telerik:RadButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </div>
                </div>
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
