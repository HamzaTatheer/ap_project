<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.ap_project.models.UserAuth" %>
<%@ page import="com.example.ap_project.models.Patient" %>


<% ArrayList<UserAuth> authentications = (ArrayList<UserAuth>) request.getAttribute("Allauthentications");
    String username = (String) request.getAttribute("session");
    String profile = (String) request.getAttribute("profile");
    String pic = (String) request.getAttribute("pic");
    ArrayList <Patient> patients = (ArrayList<Patient>) request.getAttribute("patients"); %>

<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        * {
            box-sizing: border-box;
        }



        table {
            border: 3px solid black;
            border-collapse: collapse;
            background: linear-gradient(to right,rgba(0,0,0,0.22),#808080);
            width: 100%;
            position: center;
            color:white;
            margin-left: 10px;
            margin-right: 30px;
        }

        th, td {
            text-align: left;
            padding: 15px;
        }

        .title {
            color: white;
            padding-top: 5px;
            padding-bottom: 10px;
            height: 70px;
            font-size: 40px;
            text-align: center;
            text-shadow: 0 10px 14px 0 rgba(0,0,0,0.24);
        }
        .home {
            Background-attachment: fixed;
            background-size: cover;
            background-image: url('/resources/imgs/operating-room blur.jpg');
            display: block;
            width: 100%;
            height: 100%;
            padding:0px 0 100px 0;
            position: relative;
            text-align:center;
        }


        .icon1 {
            background: #fff;
            border-radius: 100%;
            width: 100px;
            height: 100px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: solid #39b49b 3px;
            margin-left: 48%;
            margin-right: 48%;
            margin-top: 5%;
            margin-bottom: 2%;
        }
        .icon1 img {
            width: 60px;
            margin-top: 2px;
        }



        .messege-box {
            overflow: hidden;
            height: 100px;
            padding-top: 10px;
        }
        .messege {
            color: #121111;
            font-weight: 500;
            font-size: 60px;
            padding: 0 10px;
            height: 45px;
            margin-bottom: 45px;
            display: block;
        }


        .flip2 {
            animation: flip2 6s cubic-bezier(0.23, 1, 0.32, 1.2) infinite;
        }

        .flip3 {
            animation: flip3 8s cubic-bezier(0.23, 1, 0.32, 1.2) infinite;
        }

        .flip4 {
            animation: flip4 10s cubic-bezier(0.23, 1, 0.32, 1.2) infinite;
        }

        @keyframes flip2 {
            0% {
                margin-top: -180px;
            }

            5% {
                margin-top: -90px;
            }

            50% {
                margin-top: -90px;
            }

            55% {
                margin-top: 0px;
            }

            99.99% {
                margin-top: 0px;
            }

            100% {
                margin-top: -270px;
            }
        }

        @keyframes flip3 {
            0% {
                margin-top: -270px;
            }

            5% {
                margin-top: -180px;
            }

            33% {
                margin-top: -180px;
            }

            38% {
                margin-top: -90px;
            }

            66% {
                margin-top: -90px;
            }

            71% {
                margin-top: 0px;
            }

            99.99% {
                margin-top: 0px;
            }

            100% {
                margin-top: -270px;
            }
        }

        @keyframes flip4 {
            0% {
                margin-top: -360px;
            }

            5% {
                margin-top: -270px;
            }

            25% {
                margin-top: -270px;
            }

            30% {
                margin-top: -180px;
            }

            50% {
                margin-top: -180px;
            }

            55% {
                margin-top: -90px;
            }

            75% {
                margin-top: -90px;
            }

            80% {
                margin-top: 0px;
            }

            99.99% {
                margin-top: 0px;
            }

            100% {
                margin-top: -270px;
            }
        }

        .wrapper {
            /*background-image: url('imgs/white.jpg');*/
            background-image: url('/resources/imgs/bg-testimonial.png');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            height: 120vh;
        }

        .highlights{
            display:flex;
            margin-left: 10%;
            margin-right: 10%;
            margin-top: 100px;
        }

        .section {
            box-shadow: 10px 10px 5px grey;
            text-align: center;
            width: 27%;
            float: left;
            margin-left: 5%;
            color:white;
        }
        .section:nth-child(1) {
            background: #008bff;
        }

        .section:nth-child(2) {
            background: #0066ff;
        }

        .section:nth-child(3){
            background: #0047ff;
        }
        .head{
            padding-top:10%;
            font-size:22px;
        }
        .section:hover {
            background: #1ed4af;
            transform: scale(1.1);
            transition: 0.3s ease-in-out;
        }
        .section img {
            width: 30%;
            height: 30%;
        }
        .section p{
            font-size:18px;
            text-align:center;
            padding:0 10%;
        }
        .section hr {
            text-align: center;
            width: 50%;
            height: 1px;
            border: none;
            border-top: 2px dotted #0066ff;
            background-color: white;
        }
    </style>
    <style>

        * {
            box-sizing: border-box;
        }


        body {
            background: linear-gradient(to bottom, #0795ff,#30FFB7);
            color: #999;
            font-size: 15px;
            font-family: 'Source Sans Pro', sans-serif;
            line-height: 1.60857;
            margin: 0;
        }

        header {
        }

        .header-top {
            background-color: white;
            padding-top: 5vh;
            padding-left: 2vw;
            padding-bottom: 5vh;
        }

        .navbar-brand {
            width: 270px;
            height: 60px;
        }

        .session-info {
        }

        #profile_link {
            background-size: cover;
            background-position:center;
            height: 60px;
            width: 60px;
            outline: none;
            margin-top:-25%;
            border-radius: 100%;
            cursor: pointer;
        }

        #profile_link:hover {
            box-shadow: 0 10px 14px 0 rgba(0,0,0,0.24), 0 15px 48px 0 rgba(0,0,0,0.19);
            transition: all 0.3s ease-in-out;
            transform: scale(1.1);
        }
        .profileinfo {
        }
        .userinfo {
            font-size: 20px;
            color: #121111;
            position: absolute;
            margin-top: 1.5%;
        }

        .header-bottom {
            position: sticky;
            width: 100%;
            background: linear-gradient(to right, #0795ff,#30FFB7);
            box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
            list-style-type: none;
            overflow: hidden;
        }

        .navbar {
            margin-top: 0;
            padding-left: 120px;
        }

        header a {
            float: left;
            margin-bottom: 5px;
            display: block;
            color: white;
            text-align: center;
            padding: 18px;
            font-size: 20px;
            text-decoration: none !important;
            outline: none !important;
            -webkit-transition: all .3s ease-in-out;
            -moz-transition: all .3s ease-in-out;
            -o-transition: all .3s ease-in-out;
            transition: all .3s ease-in-out;
        }

        .navbar > a:hover, .navbar > a:focus, .navbar > .active {
            color: #fff;
            background: #14d897;
            box-shadow: 5px 5px 0 0px #fff;
        }


        .header-bottom .login-container {
            float: right;
            margin-right: 60px;
            margin-top: 10px;
        }

        .login-container button {
            border-radius: 40px;
            background-color: #0795ff;
            color: #FFFFFF;
            border-color:aliceblue;
            outline:none;
            font-size: 18px;
            font-weight: bold;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: transform 80ms ease-in;
            cursor: pointer;
            -webkit-transition-duration: 0.4s;
            transition-duration: 0.4s;
            padding: 12px 40px;
        }

        .login-container button:active {
            transform: scale(0.95);
        }

        .login-container button:hover {
            transition: 0.3s ease-in-out;
            background: #14d897;
        }

    </style>
</head>
<body>

<header>

    <jsp:include page="ProfileHeader.jsp"/>

    <div class="header-bottom">
        <div class="navbar">

            <%if (profile == null || profile.length() == 0){%>
            <a class="active" href="Home" target="_self">Home</a>
            <a href="Doctors" target="_self">Doctors</a>
            <a href="Reviews">Reviews</a>
            <a data-scroll href="#footer-distributed">Contact</a>
            <a href="About">About us</a>
            <%
            }
                else if (profile.charAt(0) == 'D')
            {%>
            <a class="active" href="Home" target="_self">Home</a>
            <a href="DoctorAppointments" target="_self">My Appointments</a>
            <a href="Doctors" target="_self">Doctors</a>
            <a href="All_Patients">Patients</a>
            <a href="LabReports" target="_self">Lab Reports</a>
            <a href="Forum" target="_self">Forum</a>
            <%}
            else if (profile.charAt(0) == 'P')
            {%>
            <a class="active" href="Home" target="_self">Home</a>
            <a href="Booked_Appointments">Booked Appointments</a>
            <a href="Doctors" target="_self">Doctors</a>
            <a href="LabReports" target="_self">Lab Reports</a>
            <a href="Forum" target="_self">Forum</a>

            <%}%>
        </div>

        <div class="login-container">
            <%if(username == null || username.length() == 0)
            {%>
            <form method="get" action="authentication">
                <button type="submit">Login</button>
            </form>
            <%}
            else
            {%>
            <form method="post" action="Logout">
                <button type="submit">Logout</button>
            </form>
            <%}%>
        </div>
    </div>
</header>
<div class="home">
        <span class="icon1">
            <img src="${pageContext.request.contextPath}/resources/imgs/icon-logo.png" alt="#" />
        </span>

         <li class="messege">Welcome to HealthStreet</li>
    <p style="color:#000000;font-family:'Comic Sans MS';text-decoration:wavy">Not just better healthcare, but a better healthcare experience</p>

    </div>

</div>
<section class="wrapper">

    <div class="highlights">
        <div class="section">
                <div class="head">
                    <img src="${pageContext.request.contextPath}/resources/imgs/emergency.png" />
                    <h3>Emergency No.</h3>
                </div>
            <p>0900-78601</p><hr /><p>0900-78601</p><hr /><p>0900-78601</p>
        </div>
        <div class="section">
                <div class="head">
                    <img src="${pageContext.request.contextPath}/resources/imgs/clock (2).png" />
                    <h3>Working Hours</h3>
                </div>

            <p>Monday-Friday 8:00-20:00</p><hr /><p>Saturday 8:00-18:00</p><hr /><p>Sunday 10:00-18:00</p>
        </div>
        <div class="section">
                <div class="head">

                    <img src="${pageContext.request.contextPath}/resources/imgs/service-icon2.png" />
                    <h3>Our Service</h3>
                </div>

            <p>We have a team of highly qualified, trained and experienced doctors and administrative staff is equipped to provide compassionate care, diagnosis and treatment for all our patients.</p>
        </div>
    </div>
</section>
<script>
    $(document).ready(function () {
        // Add smooth scrolling to all links
        $("a").on('click', function (event) {

            // Make sure this.hash has a value before overriding default behavior
            if (this.hash !== "") {
                // Prevent default anchor click behavior
                event.preventDefault();

                // Store hash
                var hash = this.hash;

                // Using jQuery's animate() method to add smooth page scroll
                // The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
                $('html, body').animate({
                    scrollTop: $(hash).offset().top
                }, 800, function () {

                    // Add hash (#) to URL when done scrolling (default click behavior)
                    window.location.hash = hash;
                });
            } // End if
        });
    });
</script>
</body>
</html>