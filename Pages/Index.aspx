<%@ Page Title="" Language="VB" MasterPageFile="~/Master_pages/Main.master" AutoEventWireup="false" CodeFile="Index.aspx.vb" Inherits="Pages_Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <style>
    /* Google Font Link */
    @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap");

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
    }

    .form-content .login-form,
    .form-content .signup-form {
      width: calc(100% / 2 - 25px);
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

  <script>
    function signup() {
      var Name = document.getElementById("Name");
      var email = document.getElementById("email");
      var password = document.getElementById("password");

      var userObj = {
        name: Name.value,
        email: email.value,
        pass: password.value,
      };

      var localObj = localStorage.getItem("userObj");
      var flag = false;

      if (localObj != null) {
        localObj = JSON.parse(localObj);
        console.log("1", localObj);

        for (i = 0; i < localObj.length; i++) {
          if (userObj.email == localObj[i].email) {
            flag = true;
            alert("Email already exists");
          }
        }

        if (flag == false) {
          localObj.push(userObj);
          localStorage.setItem("userObj", JSON.stringify(localObj));
          var flipCheckbox = document.getElementById("flip");
          flipCheckbox.checked = !flipCheckbox.checked; // Toggle the state

          var cover = document.querySelector(".container .cover");
          var rotation = flipCheckbox.checked ? -180 : 0;

          cover.style.transform = `rotateY(${rotation}deg)`;
        }
      } else {
        localStorage.setItem("userObj", JSON.stringify([userObj]));
        var flipCheckbox = document.getElementById("flip");
        flipCheckbox.checked = !flipCheckbox.checked; // Toggle the state

        var cover = document.querySelector(".container .cover");
        var rotation = flipCheckbox.checked ? -180 : 0;

        cover.style.transform = `rotateY(${rotation}deg)`;
      }
    }

    function login() {
      var emailLogin = document.getElementById("emailLogin");
      var passwordLogin = document.getElementById("passwordLogin");
      var loginPage = document.getElementById("loginPage");
      var userObj = window.localStorage.getItem("userObj");
      userObj = JSON.parse(userObj);
      var flag = false;
      if (userObj != null) {
        for (i = 0; i < userObj.length; i++) {
          if (userObj[i].email == emailLogin.value) {
            flag = true;
            if (userObj[i].pass == passwordLogin.value) {
              alert("Logged in successfully");
              window.location.href = "./home.html";
            } else if (userObj[i].pass != passwordLogin.value) {
              alert("Please enter correct password");
            }
          }
        }
      }
      if (!flag) {
        alert("No user found");
      }
    }
  </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
      <input type="checkbox" id="flip" />
      <div class="cover">
        <div class="front">
          <img src="../images/frontImg.jpg" alt="" />
          <div class="text">
            <span class="text-1">Let's manage your load </span>
            <span class="text-2">Get connected with us</span>
          </div>
        </div>
        <div class="back">
          <img class="backImg" src="../images/backImg.jpg" alt="" />
          <div class="text">
            <span class="text-1"
              >Complete miles of journey <br />with one step</span
            >
            <span class="text-2">Let's get started</span>
          </div>
        </div>
      </div>
      <div class="forms">
        <div class="form-content">
          <div class="login-form">
            <div class="title">Login</div>
            <div class="input-boxes">
              <div class="input-box">
                <i class="fas fa-envelope"></i>
                <input
                  type="text"
                  placeholder="Enter your email"
                  id="emailLogin"
                  required
                />
              </div>
              <div class="input-box">
                <i class="fas fa-lock"></i>
                <input
                  type="password"
                  placeholder="Enter your password"
                  id="passwordLogin"
                  required
                />
              </div>
              <div class="text"><a href="#">Forgot password?</a></div>
              <div class="button input-box">
                <input type="submit" value="Login" onclick="login()" />
              </div>
              <div class="text sign-up-text">
                Don't have an account? <label for="flip">Signup now</label>
              </div>
            </div>
          </div>
          <div class="signup-form">
            <div class="title">Signup</div>
            <div class="input-boxes">
              <div class="input-box">
                <i class="fas fa-user"></i>
                <input
                  type="text"
                  placeholder="Enter your name"
                  id="Name"
                  required
                />
              </div>
              <div class="input-box">
                <i class="fas fa-envelope"></i>
                <input
                  type="text"
                  placeholder="Enter your email"
                  id="email"
                  required
                />
              </div>
              <div class="input-box">
                <i class="fas fa-lock"></i>
                <input
                  type="password"
                  placeholder="Enter your password"
                  id="password"
                  required
                />
              </div>
              <div class="button input-box">
                <input type="submit" value="Sign-up" onclick="signup()" />
              </div>
              <div class="text sign-up-text">
                Already have an account? <label for="flip">Login now</label>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
</asp:Content>

