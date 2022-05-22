function checkbox() {
    var radio1 = document.getElementById('radio_btm');
    var radio2 = document.getElementById('radio_btf');
    var x = "Male";
    var y = "Female";
    if (radio1.checked)
        radio_btm.value=x;
    else if (radio2.checked)
    {
        radio_btm.value = y;
    }
}


function basic_checks() {
    var name = document.getElementById('reg_name_bt').value;
    var city = document.getElementById('reg_city_bt').value;
    var phone = document.getElementById('reg_phone_bt').value;
    var flag = true;
    var count = 0;


    //checking for correct name
    for (var i = 0; i < name.length; i++) {
        if (name[i] >= 'a' && name[i] <= 'z')
            count++;
        else if (name[i] >= 'A' && name[i] <= 'Z')
            count++;
        else if (name[i] == ' ')
            count++;
    }
    if (count != name.length) {
        flag = false;
        document.getElementById('reg_name_bt').value = "";
        document.getElementById('reg_name_bt').style.backgroundColor = "#fe4747";
    }
    else {
        document.getElementById('reg_name_bt').style.backgroundColor = "#eee";
    }


    count = 0;
    for (var i = 0; i < city.length; i++) {
        if (city[i] >= 'a' && city[i] <= 'z')
            count++;
        else if (city[i] >= 'A' && city[i] <= 'Z')
            count++;
    }
    if (city.length != count) {
        flag = false;
        document.getElementById('reg_city_bt').value = "";
        document.getElementById('reg_city_bt').style.backgroundColor = "#fe4747"
    } else {
        document.getElementById('reg_city_bt').style.backgroundColor = "#eee"
    }


    if (phone.length != 11) {
        flag = false;
        document.getElementById('reg_phone_bt').value = "";
        document.getElementById('reg_phone_bt').style.backgroundColor = "#fe4747";
    }
    else {
        document.getElementById('reg_phone_bt').style.backgroundColor = "#eee";
    }

    return flag;
}