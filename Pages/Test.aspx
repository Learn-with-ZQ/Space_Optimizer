<%@ Page Title="" Language="VB" MasterPageFile="~/Master_pages/Main.master" AutoEventWireup="false" CodeFile="Test.aspx.vb" Inherits="Pages_Test" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap");

        .image {
            height: -webkit-fill-available;
            width: -webkit-fill-available;
        }

        .right-col {
            background: #fcfdfd;
            width: 100%;
            padding: 3rem;
        }

        h1,
        label {
            font-family: "Jost", sans-serif;
            font-weight: 400;
            letter-spacing: 0.1rem;
        }

        h1 {
            color: var(--h1-color);
            text-transform: uppercase;
            font-size: 2.5rem;
            letter-spacing: 0.5rem;
            font-weight: 300;
        }

        label {
            color: var(--secondary-color);
            text-transform: uppercase;
            font-size: 0.65rem;
            width: 40vw;
            color: #818386;
            display: block;
        }

        .riTextBox{
            border-color: #8e8e8e #b8b8b8 #b8b8b8 #8e8e8e !important;
        }

        #textarea,
        .input {
            width: 40vw !important;
            display: block !important;
            font-family: "Helvetica Neue", sans-serif !important;
            color: black !important;
            font-weight: 500 !important;
            background: #fcfdfd !important;
            border: none !important;
            border-bottom: 1px solid #818386 !important;
            padding: 0.5rem 0 !important;
            margin-bottom: 1rem !important;
            outline: none !important;
            padding-left: 5px !important;
            font-size:large !important;
        }

        textarea:hover,input:hover {
            opacity: 0.5;
        }
        textarea:checked + .slider,
        input:checked + .slider {
            background-color: black
        }
        textarea:checked + .slider:before,
            input:checked + .slider:before {
                transform: translateX(26px);
            }
    </style>
    <script src="../Scripts/Alert.js"></script>
    <asp:UpdatePanel runat="server">
        <ContentTemplate runat="server">

            <asp:ScriptManager runat="server"></asp:ScriptManager>
            <section class="container mb-5">
                <div class="row justify-content-center contact gap-5 gap-lg-0">
                    <div class="col-12 col-md-12 d-flex position-relative shadow mt-5 h-custom" style="height: fit-content;">
                        <div class="col-4">
                            <img src="../images/about.jpg" runat="server" alt="Output image" class="image" />
                        </div>
                        <div class="col-8 right-col">
                            <h1>Contact us</h1>
                            <section id="contact-form formPage">
                                <div class="col-12">
                                    <label for="name">Full name</label>
                                    <telerik:RadTextBox runat="server" ID="txtName" placeholder="Your Full Name" CssClass="border input" />
                                </div>
                                <div class="col-12">
                                    <label for="name">Full name</label>
                                    <telerik:RadTextBox runat="server" ID="txtEmail" placeholder="Your Email Address" CssClass="border input" />
                                </div>
                                <div class="col-12">
                                    <label for="name">Full name</label>
                                    <asp:TextBox runat="server" ID="txtMessage" SkinID="" TextMode="MultiLine" placeholder="Your Message" CssClass="border input" />
                                </div>
                                <div class="col-12">
                                    <div class="col-2">
                                        <asp:Button ID="btnSend" runat="server" CssClass="btn btn-sm btn-yellow rounded-4 fw-semibold py-2 px-5 my-2" Text="Send" />
                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>
                </div>
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
