<%@ Page Title="" Language="VB" MasterPageFile="~/Master_pages/Main.master" AutoEventWireup="false" CodeFile="ContactUs.aspx.vb" Inherits="Pages_ContactUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate runat="server">
            <asp:ScriptManager runat="server"></asp:ScriptManager>
    <section>
        <div class="contact-container">
      <div class="left-col d-none d-md-block"></div>
      <div class="right-col">
        <h1>Contact us</h1>

        <section id="contact-form formPage" method="post">
          <label for="name">Full name</label>
          <input
            type="text"
            id="name"
            name="name"
            placeholder="Your Full Name"
            required
          />
          <label for="email">Email Address</label>
          <input
            type="email"
            id="email"
            name="email"
            placeholder="Your Email Address"
            required
          />
          <label for="message">Message</label>
          <textarea
            rows="6"
            placeholder="Your Message"
            id="message"
            name="message"
            required
          ></textarea>
          <!--<a href="javascript:void(0)">--><button
            type="submit"
            id="submit"
            name="submit"
          >
            Send</button
          ><!--</a>-->
        </section>
        <div id="error"></div>
        <div id="success-msg"></div>
      </div>
    </div>
    </section>
    <style>
        :root {
      --primary-color: #010712;
      --secondary-color: #818386;
      --bg-color: #fcfdfd;
      --button-color: #3b3636;
      --h1-color: #3f444c;
    }

    [data-theme="dark"] {
      --primary-color: #fcfdfd;
      --secondary-color: #818386;
      --bg-color: #010712;
      --button-color: #818386;
      --h1-color: #fcfdfd;
    }

    * {
      margin: 0;
      box-sizing: border-box;
      transition: all 0.3s ease-in-out;
    }

    .contact-container {
      display: flex;
      width: 100vw;
      height: 100vh;
      background: var(--bg-color);
    }

    .left-col {
      width: 45vw;
      height: 100%;
      background-image: url("../images/about.jpg");
      background-size: cover;
      background-repeat: no-repeat;
    }

    .logo {
      width: 10rem;
      padding: 1.5rem;
    }

    .right-col {
      background: var(--bg-color);
      width: 100%;
      height: 100vh;
      padding: 3rem;
    }

    h1,
    label,
    button,
    .description {
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

    p {
      color: var(--secondary-color);
      font-size: 0.9rem;
      letter-spacing: 0.01rem;
      width: 40vw;
      margin: 0.25rem 0;
    }

    label,
    .description {
      color: var(--secondary-color);
      text-transform: uppercase;
      font-size: 0.625rem;
    }

    #formPage {
      max-width: 31.25rem;
      position: relative;
      margin-top: 2rem;
      padding: 1rem 0;
    }

    input,
    textarea,
    label {
      width: 40vw;
      display: block;
    }

    p,
    placeholder,
    input,
    textarea {
      font-family: "Helvetica Neue", sans-serif;
    }

    input::placeholder,
    textarea::placeholder {
      color: var(--primary-color);
    }

    input,
    textarea {
      color: var(--primary-color);
      font-weight: 500;
      background: var(--bg-color);
      border: none;
      border-bottom: 1px solid var(--secondary-color);
      padding: 0.5rem 0;
      margin-bottom: 1rem;
      outline: none;
    }

    textarea {
      resize: none;
    }

    button {
      text-transform: uppercase;
      font-weight: 300;
      background: var(--button-color);
      color: var(--bg-color);
      width: 10rem;
      height: 2.25rem;
      border: none;
      border-radius: 2px;
      outline: none;
      cursor: pointer;
    }

    input:hover,
    textarea:hover,
    button:hover {
      opacity: 0.5;
    }

    button:active {
      opacity: 0.8;
    }

    /* Toggle Switch */

    .description {
      margin-left: 1.25rem;
    }

    .theme-switch {
      display: inline-block;
      height: 34px;
      position: relative;
      width: 60px;
    }

    .theme-switch input {
      display: none;
    }

    .slider {
      background-color: #ccc;
      bottom: 0;
      cursor: pointer;
      left: 0;
      position: absolute;
      right: 0;
      top: 0;
      transition: 0.4s;
    }

    .slider:before {
      background-color: #fff;
      bottom: 0.25rem;
      content: "";
      width: 26px;
      height: 26px;
      left: 0.25rem;
      position: absolute;
      transition: 0.4s;
    }

    input:checked + .slider {
      background-color: var(--button-color);
    }

    input:checked + .slider:before {
      transform: translateX(26px);
    }

    .slider.round {
      border-radius: 34px;
    }

    .slider.round:before {
      border-radius: 50%;
    }

    #error,
    #success-msg {
      width: 40vw;
      margin: 0.125rem 0;
      font-size: 0.75rem;
      text-transform: uppercase;
      font-family: "Jost";
      color: var(--secondary-color);
    }

    #success-msg {
      transition-delay: 3s;
    }

    @media only screen and (max-width: 950px) {
      .logo {
        width: 8rem;
      }
      h1 {
        font-size: 1.75rem;
      }
      p {
        font-size: 0.7rem;
      }
      input,
      textarea,
      button {
        font-size: 0.65rem;
      }
      .description {
        font-size: 0.3rem;
        margin-left: 0.4rem;
      }
      button {
        width: 7rem;
      }

      .slider:before {
        background-color: #fff;
        bottom: 0.25rem;
        content: "";
        width: 20px;
        height: 20px;
        left: 0.25rem;
        position: absolute;
        transition: 0.4s;
      }
      input:checked + .slider:before {
        transform: translateX(16px);
      }

      .slider.round {
        border-radius: 15px;
      }

      .slider.round:before {
        border-radius: 50%;
      }
    }
    </style>
            </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>

