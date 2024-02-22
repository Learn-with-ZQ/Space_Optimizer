<%@ Page Title="" Language="VB" MasterPageFile="~/Master_pages/Main.master" AutoEventWireup="false" CodeFile="Home.aspx.vb" Inherits="Pages_Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate runat="server">
            <asp:ScriptManager runat="server"></asp:ScriptManager>
    <section>
      <div class="m-img-size"></div>
    </section>

    <!-- our services -->
    <section class="py-5">
      <div class="container">
        <h2 class="text-center">
          The services we provide <br />
          for our customers
        </h2>
      </div>

      <section class="container py-4">
        <div
          class="row justify-content-center flex-column-reverse flex-lg-row gap-5 gap-lg-0 custom-height"
        >
          <div
            class="col-12 col-lg-6 d-flex flex-column align-items-center align-items-lg-start"
          >
            <h4 class="font-light mb-4 underline">Product arrangement</h4>
            <p class="font-light text-center text-lg-start">
              Our project involves the creation of a web-based 2D packing
              optimization tool. It enables users to efficiently organize
              rectangular boxes within a 2D container, ensuring optimal space
              utilization while taking weight constraints into account.
            </p>
            <button
              class="btn btn-sm rounded-4 py-2 px-3 btn-yellow fw-semibold"
            >
              Explore
            </button>
          </div>
          <div
            class="col-12 col-lg-6 d-flex justify-content-center justify-content-lg-end"
          >
            <img src="../images/Rectangle15.png" alt="" class="img-size" />
          </div>
        </div>
      </section>
    </section>
    <style>
        .m-img-size {
      width: 100%;
      height: 90vh;
      background-image: url("../images/Rectangle3.png");
      background-position: center;
      background-size: cover;
      background-repeat: no-repeat;
    }
    .img-size {
      height: 200px;
    }
    @media (min-width: 1024px) {
      .img-size {
        height: 250px;
      }
    }
    </style>
            </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>

