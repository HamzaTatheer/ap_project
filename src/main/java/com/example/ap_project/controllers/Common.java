package com.example.ap_project.controllers;

import com.example.ap_project.db.CRUD;
import com.example.ap_project.db.SqlHelper;
import com.example.ap_project.models.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.sql.SQLException;
import java.util.ArrayList;

@Controller
public class Common {


    @RequestMapping(value = "/Home")
    public ModelAndView Home() throws SQLException {
        ArrayList<UserAuth> users = CRUD.getAllUsers();
        ArrayList<Patient> patients = CRUD.getAllPatients();
        ModelAndView mv = new ModelAndView();
        mv.addObject("Allauthentications", users);
        mv.addObject("patients", patients);
        if (Global.email == null)
        {
            mv.addObject("session", "");
            mv.addObject("profile", "x");
        }
        else
        {
            mv.addObject("session",Global.username);
            mv.addObject("profile", Global.userType);
            mv.addObject("pic",Global.userpic);
        }


        mv.setViewName("common/Home");
        return mv;
    }

    @RequestMapping(value = "/authentication", method= RequestMethod.GET)
    public ModelAndView authentication() throws SQLException
    {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("common/authentication");
        return mv;
    }

    @RequestMapping(value = "/authenticateSignIn", method= RequestMethod.POST)
    public ModelAndView authenticateSignIn(@RequestParam String _email, @RequestParam String _password) throws SQLException {

        singInResult User = CRUD.signin(_email, _password);
        System.out.println(User.result);

        //check if result is valid
        if (User.result == -1)
        {
            String data = "Something went wrong while connecting with the database";
            ModelAndView mv = new ModelAndView();
            mv.setViewName("redirect:/Home");
            mv.addObject(data);
            return mv;
        }
        else if (User.result == 0)
        {
            String data = "Invalid Credentials!";
            ModelAndView mv = new ModelAndView();
            mv.setViewName("redirect:/Home");
            mv.addObject(data);
            return mv;
        }


        Global.email = _email;
        if (User.userType == 'A')
        {
            Global.username = "Reception";
            Global.userType = "Admin";
        }
        else
        {
            ArrayList<Patient> patients = CRUD.getAllPatients();
            ArrayList<Doctor> doctors = CRUD.GetAllDoctors();
            Global.username = Basic.getUserName(doctors, patients, User.userType, Global.email);
            Global.userpic = Basic.getUserPic(doctors, patients, User.userType, Global.email);
            if (User.userType == 'P')
            {
                Global.userType = "Patient";

                if (Global.username.length()<=1)
                {
                    //This is used as we need to add further details of patient
                    ModelAndView mv = new ModelAndView();
                    mv.setViewName("redirect:/RegForm");
                    return mv;
                }
            }
            else if (User.userType == 'D')
            {
                Global.userType = "Doctor";

                if (Global.username.length() <= 1)
                {
                    ModelAndView mv = new ModelAndView();
                    mv.setViewName("redirect:/DoctorProfile");
                    return mv;
                }

                ModelAndView mv = new ModelAndView();
                mv.setViewName("redirect:/Booked_Appointments");
                return mv;

            }
        }
        ModelAndView mv = new ModelAndView();
        mv.setViewName("redirect:/Home");
        return mv;
    }

    @RequestMapping("/Logout")
    public ModelAndView Logout()
    {
        Global.email = null;
        Global.username = "";
        Global.userType = "x";
        Global.userpic = "x";
        ModelAndView mv = new ModelAndView();
        mv.setViewName("redirect:/Home");
        return mv;
    }



    @RequestMapping(value = "/Doctors")
    public ModelAndView Doctors()
    {
        ModelAndView mv = new ModelAndView();
        if (Global.email == null)
        {
            mv.addObject("session", "");
            mv.addObject("profile", "x");
            mv.addObject("pic","x");
        }
        else
        {
            mv.addObject("session", Global.username);
            mv.addObject("profile", Global.userType);
            mv.addObject("pic",Global.userpic);
        }
        ArrayList<Doctor> doctors = CRUD.GetAllDoctors();
        mv.addObject("doctors", doctors);
        mv.setViewName("Doctors");
        return mv;
    }



    //#################################################### Admin Methods
    @RequestMapping("/Booked_Appointments")
    public ModelAndView Booked_Appointments()
    {
        ModelAndView mv = new ModelAndView();
        if (Global.email == null)
        {
            mv.setViewName("index");
            return mv;
        }
        ArrayList<Appointments> list = CRUD.BookedAppointments();
        mv.addObject("session", Global.username);
        mv.addObject("profile", Global.userType);
        mv.addObject("appointments", list);
        mv.setViewName("Booked_Appointments");
        return mv;
    }





}
