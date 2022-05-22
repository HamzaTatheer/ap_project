function time_check()
{
    var start = document.getElementById('start_box').value;
    var end = document.getElementById('end_box').value;
    var flag = true;

    var temp = start.slice(0,2);
    
    if (parseInt(temp) >= 8 && parseInt(temp) <= 22) {
        if (start[2] != ':') {
            flag = false;
        }
        if (start[4] != '0')
            flag = false;


            if (start[3] == '3' || start[3] == '0')
                "sss";
            else
                flag = false;

    }
    else {
        flag = false;
    }
    if (flag == false) {
        document.getElementById('start_box').value = "";
        document.getElementById('start_box').style.backgroundColor = "#fe4747";
    }
    else
        document.getElementById('start_box').style.backgroundColor = "#eee";

    var flag1 = true;
     temp = end.slice(0, 2);

    if (parseInt(temp) >= 8 && parseInt(temp) <= 22) {
        if (end[2] != ':')
            flag1 = false;
        if (end[4] != '0')
            flag1 = false;


        if (end[3] == '3' || end[3] == '0')
            "sss";
        else
            flag1=false;

    }
    else {
        flag1 = false;
    }
    if (flag1 == false) {
        document.getElementById('end_box').value = "";
        document.getElementById('end_box').style.backgroundColor = "#fe4747";
    }
        else
        document.getElementById('end_box').style.backgroundColor = "#eee";

    if (flag1 == false || flag == false)
        return false;
    else
        return true;
}