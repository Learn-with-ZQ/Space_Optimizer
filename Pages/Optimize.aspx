<%@ Page Title="" Language="VB" MasterPageFile="~/Master_pages/Main.master" AutoEventWireup="false" CodeFile="~/Pages/Optimize.aspx.vb" Inherits="Pages_Optimize" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
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
                        <h4 class="font-light mb-4 underline">Optimize Solution</h4>
                        <div class="col-12 row">
                            <div class="col-1"></div>
                            <div class="col-10">
                                <div class="col-12 row">
                                    <div class="col-6">
                                        <div class="col-12 row">
                                            <div class="col-3">
                                                <label style="font-size: 15px; padding-top: 16px;">Container: </label>
                                            </div>
                                            <div class="col-9">
                                                <telerik:RadComboBox runat="server" ID="cmbContainer" Width="100%" CssClass="rounded-4 border py-2 px-5 my-2" Skin="Outlook" Filter="Contains" MaxHeight="110" AutoPostBack="true">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="--Select--" Value="0" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="col-12 row">
                                            <div class="col-3">
                                                <label style="font-size: 15px; padding-top: 16px;">Object: </label>
                                            </div>
                                            <div class="col-9">
                                                <telerik:RadComboBox runat="server" ID="cmbObjects" Width="100%" CssClass="rounded-4 border py-2 px-5 my-2" Skin="Outlook" Filter="Contains" AutoPostBack="true" MaxHeight="110" CheckBoxes="true" EnableCheckAllItemsCheckBox="true">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="--Select--" Value="0" Checked="true" />
                                                    </Items>
                                                </telerik:RadComboBox>
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
                                <asp:Button ID="btnOptimize" runat="server" Text="Optimize"
                                    class="btn btn-sm btn-yellow rounded-4 fw-semibold py-2 px-5 my-2" />
                            </div>
                            <div class="col-5"></div>
                        </div>
                        <div class="col-12 row" runat="server" id="divOutput" visible="false">
                            <div class="col-2"></div>
                            <div class="col-8">
                                <div class="col-12 row">
                                    <div class="col-4"></div>
                                    <div class="col-4">
                                        <telerik:RadTextBox runat="server" ID="txtOutput" type="text" TextMode="MultiLine" Text="Wasted Area = 32ft" CssClass="rounded-4 border" Height="55px" Width="100%" />
                                    </div>
                                </div>
                                <div class="col-12 row">
                                    <img class="img_class" alt="Output image" src="D:\FYP\ASP\Output_images\userDec25_3_image_2024-01-01_21-02-42" id="imgOutput" runat="server" />
                                </div>
                                <%--<asp:Image runat="server" ID="img_output" ImageUrl="D:\FYP\ASP\Output_images\image_2023-12-18_21-13-18.png"></asp:Image>--%>
                            </div>
                            <div class="col-2"></div>
                        </div>
                    </div>
                </div>
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
