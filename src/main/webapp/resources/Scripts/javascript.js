// <reference path="modernizr-2.5.3.js" />


//////////////////////////////////////////////////////////
const signUpButton = document.getElementById('signUp');
const signInButton = document.getElementById('signIn');
const container = document.getElementById('container');

signUpButton.addEventListener('click', () => {
    container.classList.add("right-panel-active");
});

signInButton.addEventListener('click', () => {
    container.classList.remove("right-panel-active");
});

/*
function checkForEmptyFields_signin() {
    var email_bar = document.getElementById('signin_mail_bt').value;
    var password_bar = document.getElementById('signin_pass_bt').value;
    if (email_bar == "") {
        
    }
    if (password_bar == "") {

    }
}

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
*/

/*
function checkbox() {
    var utype1 = document.getElementById("utype1");
    var utype2 = document.getElementById("utype2");
    if (utype.length > 0) {

        if (utype1.checked == true) {

        }
    }
}*/