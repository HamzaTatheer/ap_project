package com.example.ap_project.db;

import com.example.ap_project.models.*;

import java.sql.*;
import java.util.ArrayList;

public class CRUD {


    //it will return -1 if no users are created
    public static singInResult signin(String _email, String _password) throws SQLException {
        singInResult data = new singInResult();
        data.userType = 'x';
        try {
            Connection con = SqlHelper.createConnection();
            CallableStatement cs = con.prepareCall("{call signin(?,?) }");

            cs.setString(1, _email);
            cs.setString(2, _password);
            ResultSet rdr = cs.executeQuery();
            while (rdr.next()) {
                data.userType = rdr.getString(1).charAt(0);
            }

            if (data.userType == 'x') {
                data.result = 0;
            } else {
                data.result = 1;
            }
            con.close();
            rdr.close();
            return data;
        } catch (SQLException ex) {
            System.out.println(ex);
            data.result = -1; //-1 will be interpreted as "error while connecting with the database."
        }

        return data;
    }


    public static int signup(String _email, String _pass) throws SQLException {

        int result = 0;

        try
        {
            Connection con = SqlHelper.createConnection();
            CallableStatement cs = con.prepareCall("{call signup(?,?,?,?)}");
            cs.setString(1, _email);
            cs.setString(2, _pass);
            cs.setString(3, "P");
            cs.registerOutParameter(4, Types.INTEGER);
            cs.execute();
            return cs.getInt(4);
        }

        catch (SQLException e)
        {
            System.out.println(e);
        }
        return result;
    }

    public static ArrayList<UserAuth> getAllUsers() {
        try
        {
            Connection con = SqlHelper.createConnection();
            CallableStatement cs = con.prepareCall("{call AllUsersAuth()}");
            ResultSet rdr = cs.executeQuery();
            ArrayList<UserAuth> list = new ArrayList<>();
            while (rdr.next())
            {
                UserAuth user = new UserAuth();

                user.Email = rdr.getString(1);
                user.Password = rdr.getString(2);
                user.UserType = rdr.getString(3);
                list.add(user);
            }
            rdr.close();
            con.close();
            return list;

        } catch (SQLException throwables) {
            throwables.printStackTrace();
            return null;
        }


    }

    public static ArrayList<Patient> getAllPatients() throws SQLException {
        try {
            Connection con = SqlHelper.createConnection();
            CallableStatement cs = con.prepareCall("{call AllPatients()}");
            ResultSet rdr = cs.executeQuery();
            ArrayList<Patient> list = new ArrayList<Patient>();
            while (rdr.next()) {
                Patient user = new Patient();
                user.Name = rdr.getString(2);
                user.Email = rdr.getString(3);
                user.City = rdr.getString(4);
                user.Gender = rdr.getString(5);
                user.Age = String.valueOf(rdr.getInt(6));
                user.Phone = rdr.getString(7);
                user.Address = rdr.getString(8);
                user.img = rdr.getString(10);

                list.add(user);
            }
            rdr.close();
            con.close();
            return list;
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        }
    }
    public static ArrayList<Doctor> GetAllDoctors()  {
        try
        {
            Connection con = SqlHelper.createConnection();

            CallableStatement cmd = con.prepareCall("{call getAllDoctors()}");
            ResultSet rdr = cmd.executeQuery();

            ArrayList<Doctor> docs = new ArrayList<Doctor>();
            while (rdr.next())
            {
                Doctor user = new Doctor();
                user.DocID = rdr.getInt(1);
                user.Name = rdr.getString(2);
                user.Email = rdr.getString(3);
                user.City = rdr.getString(4);
                user.Gender = rdr.getString(5);
                user.Age = rdr.getString(6);
                user.Phone = rdr.getString(7);
                user.Fee = rdr.getString(8);
                user.img = rdr.getString(9);
                user.start_time = rdr.getString(10);
                user.end_time = rdr.getString(11);
                docs.add(user);
            }


            for (Doctor user : docs)
            {
                rdr.close();
                cmd.close();
                cmd = con.prepareCall("{call getDoctorSpecialization(?)}");
                cmd.setString(1, String.valueOf(user.DocID));
                rdr = cmd.executeQuery();

                String speciality;
                while (rdr.next())
                {
                    speciality = rdr.getString(1);
                    user.specializations.add(speciality);
                }
            }
            con.close();

            return docs;
        }

        catch (SQLException ex)
        {
            System.out.println(ex);
            return null;
        }
    }


    public static ArrayList<Appointments> BookedAppointments()    {
        ArrayList<Appointments> data = new ArrayList<>();

        try
        {
            Connection con = SqlHelper.createConnection();
            CallableStatement cmd = con.prepareCall("{call Booked_Appointments()}");
            ResultSet rdr = cmd.executeQuery();
            while (rdr.next())
            {
                Appointments app = new Appointments();
                app.starting_time =rdr.getString(1);
                app.ending_time = rdr.getString(2);
                app.patient_name = rdr.getString(3);
                app.doctor_name = rdr.getString(4);
                app.app_date = rdr.getString(5);
                data.add(app);
            }
        }

        catch ( SQLException ex)
        {
            System.out.println(ex);
        }

        return data;
    }


    public static int PatientCount() {
        int result = 0;
        try
        {
            Connection con = SqlHelper.createConnection();
            CallableStatement cs = con.prepareCall("{call patientcount(?)}");
            cs.registerOutParameter(1, Types.INTEGER);
            cs.execute();
            return cs.getInt(1);
        }

        catch (SQLException e)
        {
            System.out.println(e);
        }
        return result;
    }


    public static int Addpatient(String img,String path,String reg_address_bt, String emailID, String reg_name_bt, String reg_city_bt, int reg_age_bt, String reg_phone_bt, String radio_bt) throws SQLException {

        int result = 0;
        String gender = "";
        if (radio_bt.equals("0"))
            gender = "Male";
        else if (radio_bt.equals("1"))
            gender = "Female";
        try
        {
            Connection con = SqlHelper.createConnection();
            CallableStatement cs = con.prepareCall("{call insertPatientinfo(?,?,?,?,?,?,?,?,?,?)}");
            cs.setString(1, emailID);
            cs.setString(2, reg_name_bt);
            cs.setString(3, reg_city_bt);
            cs.setString(4, gender);
            cs.setInt(5, reg_age_bt);
            cs.setString(6, reg_phone_bt);
            cs.setString(7, reg_address_bt);
            cs.setString(8, img);
            cs.setString(9, path);
            cs.registerOutParameter(10, Types.INTEGER);
            cs.execute();
            return cs.getInt(10);
        }

        catch (SQLException e)
        {
            System.out.println(e);
        }

        return result;
    }




}
