package com.example.ap_project.models;

import java.util.ArrayList;

public class Basic
{
    public static String getUserName(ArrayList<Doctor> docs, ArrayList<Patient> pats, char utype, String email)
    {

        String result = "";

        if (utype == 'P')
        {
            for (int i = 0; i < pats.size(); i++ )
            {
                Patient temp = pats.get(i);
                if (temp.Email.equals(email))
                {
                    result = temp.Name;
                }
            }
        }
        else if(utype=='D')
        {
            for(int i = 0; i < docs.size(); i++)
            {
                Doctor doctor = docs.get(i);
                if (doctor.Email.equals(email))
                {
                    result = doctor.Name;
                }
            }
        }
        return result;
    }

    public static String getUserPic(ArrayList<Doctor> docs, ArrayList<Patient> pats, char utype, String email)
    {

        String result = "";

        if (utype == 'P')
        {
            for (int i = 0; i < pats.size(); i++ )
            {
                Patient temp = pats.get(i);
                if (temp.Email.equals(email))
                {
                    result = temp.img;
                }
            }
        }
        else if(utype=='D')
        {
            for(int i = 0; i < docs.size(); i++)
            {
                Doctor doctor = docs.get(i);
                if (doctor.Email.equals(email))
                {
                    result = doctor.img;
                }
            }
        }
        return result;
    }
    public static Appointments getAppointment(ArrayList<Appointments> app, String starting_time)
    {
        Appointments result = new Appointments();
        //starting_time = starting_time + ":00";
        Appointments temp = new Appointments();

        for(int i = 0; i < app.size(); i++)
        {
            temp = app.get(i);
            if (starting_time.equals(temp.starting_time))
            {
                result = temp;
            }
        }
        return result;
    }
    public static ArrayList<Meds> TokenizeMedicine(String meds)
    {
        ArrayList<Meds> list=new ArrayList<Meds>();
        meds = meds + '\r';
        String q = "";
        String temp = "";
        for (int i = 0; i < meds.length(); i++)
        {
            if (meds.charAt(i) != ',')
            {
                temp = temp + meds.charAt(i);
            }
            else if (meds.charAt(i) == ',')
            {
                Meds obj = new Meds();
                obj.Med = temp;
                i++;
                while(meds.charAt(i)!='\r')
                {
                    q = q + meds.charAt(i);
                    i++;
                }
                i++;
                obj.Quantity = Integer.parseInt(q);
                temp = "";
                q="";

                list.add(obj);
            }
        }
        return list;
    }
}
