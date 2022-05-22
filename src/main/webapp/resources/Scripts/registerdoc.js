
window.scroll({
    top: 2500,
    left: 0,
    behavior: 'smooth'
});

function basic_checks() {
    var name = document.getElementById('doc_name_bt').value;
    var city = document.getElementById('doc_city_bt').value;
    var phone = document.getElementById('doc_phone_bt').value;
    var specialization = document.getElementById('doc_specialization_bt').value;
    var fee = document.getElementById('doc_fee_bt').value;



    var flag = true;
    var count = 0;

    if (fee % 1 === 0) {
        document.getElementById('doc_fee_bt').style.backgroundColor = "#eee";
    } else {
        flag = false;
        document.getElementById('doc_fee_bt').style.backgroundColor = "#fe4747";
    }


    //checking specialization
    for (var i = 0; i < specialization.length; i++) {
        if (specialization[i] >= 'a' && specialization[i] <= 'z')
            count++;
        else if (specialization[i] >= 'A' && specialization[i] <= 'Z')
            count++;
        else if (specialization[i] == ' ')
            count++;
        else if (specialization[i] == ',')
            count++;
    }
    if (count != specialization.length) {
        flag = false;
        document.getElementById('doc_specialization_bt').style.backgroundColor = "#fe4747";
    }
    else {
        document.getElementById('doc_specialization_bt').style.backgroundColor = "#eee";
    }

    count = 0;
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
        document.getElementById('doc_name_bt').style.backgroundColor = "#fe4747";
    }
    else {
        document.getElementById('doc_name_bt').style.backgroundColor = "#eee";
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
        document.getElementById('doc_city_bt').style.backgroundColor = "#fe4747"
    } else {
        document.getElementById('doc_city_bt').style.backgroundColor = "#eee"
    }


    if (phone.length != 11) {
        flag = false;
        document.getElementById('doc_phone_bt').style.backgroundColor = "#fe4747";
    }
    else {
        document.getElementById('doc_phone_bt').style.backgroundColor = "#eee";
    }

    return flag;
}