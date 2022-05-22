<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title> .::Login::.  </title>
    <style>
        @import url('https://fonts.googleapis.com/css?family=Montserrat:400,800');

        *{
            box-sizing: border-box;
        }

        .Error{
            position:relative;
            font-size:20px;
            text-align:center;
            color:red;
            font-weight:100;
            z-index:500;
            margin-top:20px;
        }

        body {
            background-image: url('/imgs/service-bg.png');
            background-position: center;
            background-size: cover;
            font-family: 'Source Sans Pro', sans-serif;
            margin: 0;
        }


        h1 {
            font-weight: bold;
            margin: 0;
        }

        h2 {
            text-align: center;
        }

        #logo{
            line-height:100px;
            height:100%;
        }
        #logo img {
            margin-top:40px;
            width: 350px;
            height: 70px;
        }

        p {
            font-size: 14px;
            font-weight: 100;
            line-height: 20px;
            letter-spacing: 0.5px;
            margin: 20px 0 30px;
        }

        .container a{
            font-size: 18px;
        }

        .container a {
            color: #333;
            font-size: 14px;
            text-decoration: none;
            margin: 15px 0;
        }

        button {
            border-radius: 25px;
            border: 1px solid #FF4B2B;
            background-color: #FF4B2B;
            color: #FFFFFF;
            font-size: 18px;
            font-weight: bold;
            padding: 12px 45px;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: transform 80ms ease-in;
            cursor: pointer;
            -webkit-transition-duration: 0.4s;
            transition-duration: 0.4s;
        }

        button:active {
            transform: scale(0.95);
        }

        button:focus {
            outline: none;
        }

        button.ghost {
            background-color: transparent;
            border-color: #FFFFFF;
        }

        button:hover {
            box-shadow: 0 10px 14px 0 rgba(0,0,0,0.24), 0 15px 48px 0 rgba(0,0,0,0.19);
            transition: box-shadow 0.3s ease-in-out;
        }

        form {
            background-color: #FFFFFF;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding: 0 50px;
            height: 100%;
            text-align: center;
            font-family:Calibri;
        }

        input {
            background-color: #eee;
            border: thin;
            border-radius: 20px;
            padding: 12px 15px;
            box-shadow: 0 2px 0 2px rgba(0,0,0,0.22);
            margin: 8px 0;
            width: 100%;
        }

        input:focus {
            box-shadow: 0 0 5px rgb(45, 103, 191);
            background-color: #ebf0fd;
            outline: none;
        }

        .container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
            position: relative;
            overflow: hidden;
            width: 50%;
            min-height: 550px;
            margin-left: 25%;
            margin-right: 25%;
            margin-bottom:50px;
        }


        .form-container {
            position: absolute;
            top: 0;
            height: 100%;
            transition: all 0.6s ease-in-out;
        }

        .sign-in-container {
            left: 0;
            width: 50%;
            z-index: 2;

        }

        .container.right-panel-active .sign-in-container {
            transform: translateX(100%);
        }

        .sign-up-container {
            left: 0;
            width: 50%;
            opacity: 0;
            z-index: 1;
        }

        .container.right-panel-active .sign-up-container {
            transform: translateX(100%);
            opacity: 1;
            z-index: 5;
            animation: show 0.6s;
        }

        @keyframes show {
            0%, 49.99% {
                opacity: 0;
                z-index: 1;
            }

            50%, 100% {
                opacity: 1;
                z-index: 5;
            }
        }

        .overlay-container {
            position: absolute;
            top: 0;
            left: 50%;
            width: 50%;
            height: 100%;
            overflow: hidden;
            transition: transform 0.6s ease-in-out;
            z-index: 100;
        }

        .container.right-panel-active .overlay-container {
            transform: translateX(-100%);
        }

        .overlay {
            /*background: linear-gradient(to right,#30FFB7, #0795ff);*/
            background: linear-gradient(to right, #0795ff,#30FFB7);
            background-repeat: no-repeat;
            background-size: cover;
            background-position: 0 0;
            color: #FFFFFF;
            position: relative;
            left: -100%;
            height: 100%;
            width: 200%;
            transform: translateX(0);
            transition: transform 0.6s ease-in-out;
        }

        .container.right-panel-active .overlay {
            transform: translateX(50%);
        }

        .overlay-panel {
            position: absolute;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding: 0 40px;
            text-align: center;
            top: 0;
            height: 100%;
            width: 50%;
            transform: translateX(0);
            transition: transform 0.6s ease-in-out;
        }

        .overlay-left {
            transform: translateX(-20%);
        }

        .container.right-panel-active .overlay-left {
            transform: translateX(0);
        }

        .overlay-right {
            right: 0;
            transform: translateX(0);
        }

        .container.right-panel-active .overlay-right {
            transform: translateX(20%);
        }

        .social-container {
            margin: 20px 0;
        }

        .social-container a {
            border: 1px solid #DDDDDD;
            border-radius: 50%;
            display: inline-flex;
            justify-content: center;
            align-items: center;
            margin: 0 5px;
            height: 40px;
            width: 40px;
        }


    </style>
</head>

<body>
<center>
    <a id="logo" href="Home" target="_self">
        <img src="${pageContext.request.contextPath}/resources/imgs/logo_black.png" alt="image" />
    </a>
</center>
<div class="container" id="container">
    <div class="form-container sign-up-container">
        <form action="authenticateSignup" method="post">
            <h1>Create Account</h1>
            <span>Use your email for registration</span>

            <input type="email" placeholder="Email" name="signup_mail_bt" id="signup_mail_bt" maxlength="30" required />
            <input type="password" placeholder="Password" name="signup_pass_bt" id="signup_pass_bt" required />

            <br />
            <button onclick="checkForEmptyFields_signup()" id="newSignup">Sign Up</button>
        </form>
    </div>

    <div class="form-container sign-in-container">
        <form method="post" action="authenticateSignIn">
            <h1>Sign in</h1>
            <input type="email" placeholder="Email" id="signin_mail_bt" name="_email" required />
            <input type="password" placeholder="Password" id="signin_pass_bt" name="_password" required />
            <a class="forget "href="#">Forgot your password?</a>
            <button onclick="checkForEmptyFields_signin()" id="newSignIn">Sign In</button>
        </form>

    </div>
    <div class="overlay-container">
        <div class="overlay">
            <div class="overlay-panel overlay-left">
                <h1>Welcome Back!</h1>
                <p>We Are Here For You</p>
                <button class="ghost" id="signIn">Sign In</button>
            </div>
            <div class="overlay-panel overlay-right">
                <h1>No Account?</h1>
                <p>Improve Your Health Now By Joining Us</p>
                <button class="ghost" id="signUp">Sign Up</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
<script>

    const signUpButton = document.getElementById('signUp');
    const signInButton = document.getElementById('signIn');
    const container = document.getElementById('container');

    signUpButton.addEventListener('click', () => {
        container.classList.add("right-panel-active");
    });

    signInButton.addEventListener('click', () => {
        container.classList.remove("right-panel-active");
    });
    function checkForEmptyFields_signup() {
        var email_bar = document.getElementById('signup_mail_bt').value;
        var password_bar = document.getElementById('signup_pass_bt').value;
        var utype = "";
        utype=$("input[type='radio'][name='radio']:checked");
        if (utype.length == 0) {

        }
        if (email_bar == "") {

        }
        if (password_bar == "") {

        }
    }
    function checkForEmptyFields_signin() {
        var email_bar = document.getElementById('signin_mail_bt').value;
        var password_bar = document.getElementById('signin_pass_bt').value;
        if (email_bar == "") {

        }
        if (password_bar == "") {

        }
    }
</script>
