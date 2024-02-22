<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="Pages_Login" %>


<!DOCTYPE html>

<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8" />
    <!-- Fontawesome CDN Link -->
    <link
        rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script>
        function showSuccessAlert() {
            var successAlert = document.getElementById('successAlert');
            successAlert.style.display = 'flex';
            setTimeout(function () {
                dismissAlert('successAlert', successAlert.querySelector('.okBtn'));
            }, 3000);
        }

        function showErrorAlert() {
            var errorAlert = document.getElementById('errorAlert');
            errorAlert.style.display = 'flex';
            setTimeout(function () {
                dismissAlert('errorAlert', errorAlert.querySelector('.okBtn'));
            }, 3000);
        }

        function dismissAlert(alertId, button) {
            var alertElement = document.getElementById(alertId);
            alertElement.style.display = 'none';
            button.disabled = true;
        }
        function Toggle(visibleId, notVisible1Id, notVisible2Id) {
            var visible = document.getElementById(visibleId);
            var notVisible1 = document.getElementById(notVisible1Id);
            var notVisible2 = document.getElementById(notVisible2Id);

            visible.style.display = 'block';

            notVisible1.style.display = 'none';
            notVisible2.style.display = 'none';
        }
    </script>
</head>

<body>
    <form id="form1" runat="server">
        <asp:UpdatePanel runat="server">
            <ContentTemplate runat="server">
                <asp:ScriptManager runat="server"></asp:ScriptManager>
                <div class="alert" id="successAlert" runat="server" style="display: none;">
                    <div class="alertBox alert-success">
                        <label for="">
                            &nbsp
                            <label for="" runat="server" id="alertS">Message sent successfully</label>
                            &nbsp
                <i class="fas fa-times" onclick="dismissAlert('successAlert', this)"></i>&nbsp

                        </label>
                    </div>
                </div>

                <div class="alert" id="errorAlert" runat="server" style="display: none;">
                    <div class="alertBox alert-danger">
                        <label for="">
                            &nbsp
                            <label runat="server" id="alertE">Error sending message</label>
                            &nbsp
                    <i class="fas fa-times" onclick="dismissAlert('errorAlert', this)"></i>&nbsp
                        </label>

                    </div>
                </div>
                <div class="container">
                    <asp:TextBox runat="server" type="checkbox" ID="flip" />

                    <div class="forms">
                        <div class="form-content">
                            <div class="login-form" id="DivLogin" runat="server">
                                <div class="title">Login</div>
                                <div class="input-boxes">
                                    <div class="input-box">
                                        <i class="fas fa-envelope"></i>
                                        <asp:TextBox runat="server" type="text" placeholder="Enter your email" ID="txtLoginEmail"/>
                                    </div>
                                    <div class="input-box">
                                        <i class="fas fa-lock"></i>
                                        <asp:TextBox runat="server" type="password" placeholder="Enter your password" ID="txtLoginPassword" />
                                    </div>
                                    <div class="text">
                                        <asp:Button runat="server" ID="btnForgotPasswordToggle" Visible="false" Text="Forgot Passowrd" CssClass="button_change" />
                                    </div>
                                    <div class="button input-box">
                                        <asp:Button runat="server" Text="Submit" ID="btnLogin" />
                                    </div>
                                    <div class="text sign-up-text">
                                        Don't have an account?
                                        <asp:Button runat="server" Text="Signup now" ID="btnSignInToggle" CssClass="button_change" />
                                    </div>
                                </div>
                            </div>
                            <div class="signup-form" id="DivSignIn" runat="server" visible="false">
                                <div class="title">Signup</div>
                                <div class="input-boxes">
                                    <div class="input-box">
                                        <i class="fas fa-user"></i>
                                        <asp:TextBox runat="server" type="text" placeholder="Enter your name" ID="txtName" />
                                    </div>
                                    <div class="input-box">
                                        <i class="fas fa-envelope"></i>
                                        <asp:TextBox runat="server" type="text" placeholder="Enter your email" ID="txtEmail" />
                                    </div>
                                    <div class="input-box">
                                        <i class="fas fa-lock"></i>
                                        <asp:TextBox runat="server" type="password" placeholder="Enter your password" ID="txtPassword" />
                                    </div>
                                    <div class="input-box" style="height: auto">
                                        <p>
                                            Password must be at least 8 characters long.<br />
                                            1 lowercase letter.<br />
                                            1 uppercase letter.<br />
                                            1 Number.<br />
                                            1 special character.<br />
                                        </p>
                                    </div>
                                    <div class="button input-box">
                                        <asp:Button runat="server" Text="Submit" ID="btnSignup" />
                                    </div>
                                    <div class="text sign-up-text">
                                        Already have an account?
                                        <asp:Button runat="server" ID="btnLoginToggle" Text="Login now" CssClass="button_change" />
                                    </div>
                                </div>
                            </div>
                            <div class="signup-form" id="DivReset" runat="server" visible="false">
                                <div class="title">Reset Password</div>
                                <div class="input-boxes">
                                    <div class="input-box">
                                        <i class="fas fa-envelope"></i>
                                        <asp:TextBox runat="server" type="text" placeholder="Enter your email" AutoPostBack="true" ID="txtEmailF" />
                                    </div>
                                    <div class="input-box">
                                        <i class="fas fa-code"></i>
                                        <asp:TextBox runat="server" type="text" placeholder="Enter confirmation code" AutoPostBack="true" ID="txtCodeF" />
                                    </div>
                                    <div class="input-box">
                                        <asp:TextBox runat="server" type="password" placeholder="Enter new password" ID="txtPasswordF" AutoPostBack="true" />
                                    </div>
                                    <div class="input-box" style="height: auto">
                                        <p>
                                            Password must be at least 8 characters long.<br />
                                            1 lowercase letter.<br />
                                            1 uppercase letter.<br />
                                            1 Number.<br />
                                            1 special character.<br />
                                        </p>
                                    </div>
                                    <div class="button input-box">
                                        <asp:Button runat="server" Text="Submit" ID="Button1" />
                                    </div>
                                    <div class="text sign-up-text">
                                        Remember password?
                                        <asp:Button runat="server" ID="btnLoginToggleF" Text="Login now" CssClass="button_change" />
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>

<style>
    /* Google Font Link */
    @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap");

    .button_change {
        color: #ffbb00e1;
        cursor: pointer;
        border: none;
        background: none;
        font-weight: bold;
    }

    .alert {
        display: flex;
        justify-content: center;
        position: static;
        z-index: 100;
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

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Poppins", sans-serif;
    }

    body {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        background: #ffbb0060;
        padding: 30px;
    }

    .container {
        position: relative;
        max-width: 850px;
        width: 100%;
        background: #fff;
        padding: 40px 30px;
        box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
        perspective: 2700px;
    }

        .container .cover {
            position: absolute;
            top: 0;
            left: 50%;
            height: 100%;
            width: 50%;
            z-index: 98;
            transition: all 1s ease;
            transform-origin: left;
            transform-style: preserve-3d;
        }

        .container #flip:checked ~ .cover {
            transform: rotateY(-180deg);
        }

        .container .cover .front,
        .container .cover .back {
            position: absolute;
            top: 0;
            left: 0;
            height: 100%;
            width: 100%;
        }

    .cover .back {
        transform: rotateY(180deg);
        backface-visibility: hidden;
    }

    .container .cover::before,
    .container .cover::after {
        content: "";
        position: absolute;
        height: 100%;
        width: 100%;
        background: #ffbb00a1;
        opacity: 0.5;
        z-index: 12;
    }

    .container .cover::after {
        opacity: 0.3;
        transform: rotateY(180deg);
        backface-visibility: hidden;
    }

    .container .cover img {
        position: absolute;
        height: 100%;
        width: 100%;
        object-fit: cover;
        z-index: 10;
    }

    .container .cover .text {
        position: absolute;
        z-index: 130;
        height: 100%;
        width: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }

    .cover .text .text-1,
    .cover .text .text-2 {
        font-size: 26px;
        font-weight: 600;
        color: #fff;
        text-align: center;
    }

    .cover .text .text-2 {
        font-size: 15px;
        font-weight: 500;
    }

    .container .forms {
        height: 100%;
        width: 100%;
        background: #fff;
    }

    .container .form-content {
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-direction: column;
        gap: 5px;
    }



    .forms .form-content .title {
        position: relative;
        font-size: 24px;
        font-weight: 500;
        color: #333;
    }

        .forms .form-content .title:before {
            content: "";
            position: absolute;
            left: 0;
            bottom: 0;
            height: 3px;
            width: 25px;
            background: #ffbb00b4;
        }

    .forms .signup-form .title:before {
        width: 20px;
    }

    .forms .form-content .input-boxes {
        margin-top: 30px;
    }

    .forms .form-content .input-box {
        display: flex;
        align-items: center;
        height: 50px;
        width: 100%;
        margin: 10px 0;
        position: relative;
    }

    .form-content .input-box input {
        height: 100%;
        width: 100%;
        outline: none;
        border: none;
        padding: 0 30px;
        font-size: 16px;
        font-weight: 500;
        border-bottom: 2px solid rgba(0, 0, 0, 0.2);
        transition: all 0.3s ease;
    }

        .form-content .input-box input:focus,
        .form-content .input-box input:valid {
            border-color: #ffbb00e1;
        }

    .form-content .input-box i {
        position: absolute;
        color: #ffbb00e1;
        font-size: 17px;
    }

    .forms .form-content .text {
        font-size: 14px;
        font-weight: 500;
        color: #333;
    }

        .forms .form-content .text a {
            text-decoration: none;
        }

            .forms .form-content .text a:hover {
                text-decoration: underline;
            }

    .forms .form-content .button {
        color: #fff;
        margin-top: 40px;
    }

        .forms .form-content .button input {
            color: #fff;
            background: #ffbb00e1;
            border-radius: 6px;
            padding: 0;
            cursor: pointer;
            transition: all 0.4s ease;
        }

            .forms .form-content .button input:hover {
                background: #ffbb00a2;
            }

    .forms .form-content label {
        color: #ffbb00e1;
        cursor: pointer;
    }

        .forms .form-content label:hover {
            text-decoration: underline;
        }

    .forms .form-content .login-text,
    .forms .form-content .sign-up-text {
        text-align: center;
        margin-top: 25px;
    }

    .container #flip {
        display: none;
    }

    @media (max-width: 730px) {
        .container .cover {
            display: none;
        }

        .form-content .login-form,
        .form-content .signup-form {
            width: 100%;
        }

        .form-content .signup-form {
            display: none;
        }

        .container #flip:checked ~ .forms .signup-form {
            display: block;
        }

        .container #flip:checked ~ .forms .login-form {
            display: none;
        }
    }
</style>
</html>
