package com.example.ap_project.controllers;

import com.example.ap_project.db.CRUD;
import com.example.ap_project.models.Basic;
import com.example.ap_project.models.Patient;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.*;
import java.sql.SQLException;
import java.util.ArrayList;

@Controller
public class PatientServlet {
    @RequestMapping(value="/authenticateSignup", method= RequestMethod.POST)
    public ModelAndView authenticateSignup(@RequestParam String signup_mail_bt, @RequestParam String signup_pass_bt) throws SQLException {

        int result = CRUD.signup(signup_mail_bt,signup_pass_bt);
        System.out.println(result);
        Global.email = signup_mail_bt;
        ModelAndView mv = new ModelAndView();
        if(result  == 1){
            mv.setViewName("patient/RegForm");
        }
        else{
            String data = "Email already taken!";
            mv.setViewName("common/Home");
            mv.addObject(data);
        }
        return mv;
    }


    @RequestMapping(value = "/AddPatientInfo", method = RequestMethod.POST)
    public ModelAndView AddPatientInfo(@RequestParam CommonsMultipartFile img, @RequestParam String reg_address_bt, @RequestParam String reg_name_bt, @RequestParam String reg_city_bt, @RequestParam int reg_age_bt, @RequestParam String reg_phone_bt, @RequestParam("radio_bt") String radio_bt) throws SQLException, IOException, IOException {
        if (Global.email != null) {
            int unique = CRUD.PatientCount();
            String fileName = img.getOriginalFilename();
            String path = "";
            path = path.concat(Global.upload_dir +"/Patient_pics");
            byte[] bytes = img.getBytes();
            BufferedOutputStream stream =new BufferedOutputStream(new FileOutputStream( new File(path + File.separator + fileName)));
            stream.write(bytes);
            stream.flush();
            stream.close();

            int result = CRUD.Addpatient(fileName, "/Patient pics", reg_address_bt, Global.email, reg_name_bt, reg_city_bt, reg_age_bt, reg_phone_bt, radio_bt);
            if (result == -1) {
                String data = "Something went wrong while connecting with the database.";
                ModelAndView mv = new ModelAndView();
                mv.addObject(data);
                mv.setViewName("patient/RegForm");
                return mv;
            } else if (result == 0) {

                String data = "Email Already Exists";
                ModelAndView mv = new ModelAndView();
                mv.addObject(data);
                mv.setViewName("patient/RegForm");
                return mv;
            }
            ArrayList<Patient> patients = CRUD.getAllPatients();

            Global.userType = "Patient";
            Global.username = Basic.getUserName(null, patients, 'P', Global.email);
            Global.userpic = Basic.getUserPic(null, patients, 'P', Global.email);
            ModelAndView mv = new ModelAndView();
            mv.setViewName("redirect:/Home");
            return mv;
        } else {
            ModelAndView mv = new ModelAndView();
            mv.setViewName("common/Home");
            return mv;
        }
    }


    @RequestMapping("/RegForm")
    public ModelAndView RegForm()
    {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("patient/RegForm");
        return mv;
    }


}
