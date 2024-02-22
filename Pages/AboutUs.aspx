<%@ Page Title="" Language="VB" MasterPageFile="~/Master_pages/Main.master" AutoEventWireup="false" CodeFile="AboutUs.aspx.vb" Inherits="Pages_AboutUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate runat="server">
            <asp:ScriptManager runat="server"></asp:ScriptManager>
        <section class="py-5">
      <div class="container">
        <h2 class="text-center">About Us</h2>
      </div>

      <section class="container py-4">
        <div
          class="row justify-content-center flex-column-reverse flex-lg-row gap-5 gap-lg-0 custom-height"
        >
          <div
            class="col-12 col-lg-6 d-flex flex-column align-items-center align-items-lg-start"
          >
            <p class="font-light text-center text-lg-start">
              We are a team of four dedicated final-year students passionate
              about technology and innovation. Our collective expertise and
              vision have culminated in the creation of this project. With a
              shared commitment to solving real-world problems, we've undertaken
              the challenge of developing a web-based 2D packing optimization
              tool. Our project represents a culmination of our education and
              the skills we've honed during our academic journey. We're excited
              to share our solution, which is aimed at improving the efficiency
              of packing rectangular boxes within a 2D space, benefiting
              logistics and storage management. As we embark on this journey, we
              are committed to delivering a user-friendly and practical tool
              that optimizes space utilization while considering weight
              constraints." Feel free to customize and expand upon this
              paragraph to provide more details about your team and your
              motivations for the project
            </p>
          </div>
          <div
            class="col-12 col-lg-6 d-flex justify-content-center justify-content-lg-end align-items-center"
          >
            <img src="../images/about.jpg" alt="" class="img-size" />
          </div>
        </div>
      </section>
    </section>
            </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>


