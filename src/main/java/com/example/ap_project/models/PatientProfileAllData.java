package com.example.ap_project.models;

import java.util.ArrayList;

public class PatientProfileAllData {
    public static class Prescription
    {
        public String Doctor_Name;
        public String Date;
        public String Disease_Diagnosed;
        public int Prescription_ID;
    }

    public static class Tests
    {
        public String Test;
        public int Prescription_ID;
    }

    public static class Meds
    {
        public String Med;
        public int Quantity;
        public int Prescription_ID;
    }

    public Patient user = new Patient();
    public ArrayList<Prescription> pres = new ArrayList<Prescription>();
    public ArrayList<Tests> Test_List = new ArrayList<Tests>();
    public ArrayList<Meds> Med_List = new ArrayList<Meds>();
}
