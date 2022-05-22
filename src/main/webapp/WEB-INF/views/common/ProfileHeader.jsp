<%@ page import="com.example.ap_project.models.UserAuth" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.ap_project.models.Patient" %>


<% ArrayList<UserAuth> authentications = (ArrayList<UserAuth>) request.getAttribute("Allauthentications");
    String username = (String) request.getAttribute("session");
    String profile = (String) request.getAttribute("profile");
    String pic = (String) request.getAttribute("pic");
    ArrayList <Patient> patients = (ArrayList<Patient>) request.getAttribute("patients");
    String url = "";
%>

<%if (profile != null && profile.charAt(0) == 'P')
{
    url = pageContext.getRequest().getServletContext().getContextPath() + "/upload/Patient_pics/";
}
else if (profile != null && profile.charAt(0) == 'D'){
    url = pageContext.getRequest().getServletContext().getContextPath() + "/upload/Doctor_pics/";
}
%>



<%if (username != null && username.length() != 0)
{%>
<div style="display:flex;justify-content: space-between;align-items: center;padding: 20px 50px;background: white;">

    <div>
        <img class="navbar-brand" src="${pageContext.request.contextPath}/resources/imgs/logo_black.png" alt="image" />

    </div>


    <div style="display: flex;align-items: center">

        <div>
            Patient:
        </div>

        <a href="PatientProfile" style="margin: 0px !important;padding: 0px !important;">
        <img style="height: 60px;border-radius: 50%;width: 60px;margin-left: 20px;margin-right: 20px;"  src="<%=url+pic%>" >
        </a>
        <div style="font-size: 20px;margin:0px;padding: 0px">Hamza</div>
    </div>


</div>
<% }%>





