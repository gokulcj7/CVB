import java.io.IOException; 
import java.io.PrintWriter; 
import javax.servlet.*;  
import javax.servlet.http.*;  
import javax.servlet.ServletException; 
import javax.servlet.annotation.WebInitParam; 
import javax.servlet.annotation.WebServlet; 
import javax.servlet.http.HttpServlet; 
import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse; 
import java.sql.*;
import java.util.*;

@WebServlet("/Selectall2")
public class Selectall2 extends HttpServlet{
    public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException{
        try{
            if(req.isUserInRole("admin"))
            {
                System.out.println("You are Admin");
            }
        PrintWriter out=res.getWriter();
        System.out.println("hello");
        Connection con=DriverManager.getConnection("jdbc:mysql://localhost/covid","root","Gokul@2001");
        Statement st=con.createStatement();
        String sql="select hospitals.hospital_id,hospital_information.Hospital_Name,hospitals.location,hospital_information.normal_bed,hospital_information.oxygen_bed,hospital_information.icu_bed FROM hospitals INNER JOIN hospital_information ON hospitals.hospital_id=hospital_information.hospital_id;";   
        ResultSet rs=st.executeQuery(sql);
        String data="";
        ArrayList<String> al= new ArrayList<>();
        while(rs.next()){
            String id=rs.getInt(1)+"";
            String name=rs.getString(2);
            String location=rs.getString(3);
            String nbed=rs.getString(4);
            String obed=rs.getString(5);
            String ibed=rs.getString(6);
            al.add(id);
            al.add(name);
            al.add(location);
            al.add(nbed);
            al.add(obed);
            al.add(ibed);

        }
        req.setAttribute("data", al);
		if(req.isUserInRole("admin"))
		{
			req.getRequestDispatcher("selectallv2.jsp").forward(req, res);
		}
		else if(req.isUserInRole("user"))
		{
			req.getRequestDispatcher("selectallv3.jsp").forward(req, res);
		}

			
    }catch(SQLException e){
        e.printStackTrace();
    }

    }

    public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException{
        try{
        PrintWriter out=res.getWriter();
       // System.out.println("hello");
	   if(req.isUserInRole("admin"))
       {
                System.out.println("You are Admin");
       }
        Connection con=DriverManager.getConnection("jdbc:mysql://localhost/covid","root","Gokul@2001");
        Statement st=con.createStatement();
		String sql="";
		if(req.getParameter("nloc")!=null)
		{
			String loc=req.getParameter("nloc");
			System.out.println("tirunelveli");
			sql="select hospitals.hospital_id,hospital_information.Hospital_Name,hospitals.location,hospital_information.normal_bed,hospital_information.oxygen_bed,hospital_information.icu_bed FROM hospitals INNER JOIN hospital_information ON hospitals.hospital_id=hospital_information.hospital_id where hospitals.location="+"'"+loc+"'";
		}
		else
		{
			sql="select hospitals.hospital_id,hospital_information.Hospital_Name,hospitals.location,hospital_information.normal_bed,hospital_information.oxygen_bed,hospital_information.icu_bed FROM hospitals INNER JOIN hospital_information ON hospitals.hospital_id=hospital_information.hospital_id;";
        }
		ResultSet rs=st.executeQuery(sql);
        String data="";
        ArrayList<String> al= new ArrayList<>();
        while(rs.next()){
            String id=rs.getInt(1)+"";
            String name=rs.getString(2);
            String location=rs.getString(3);
            String nbed=rs.getString(4);
            String obed=rs.getString(5);
            String ibed=rs.getString(6);
            al.add(id);
            al.add(name);
            al.add(location);
            al.add(nbed);
            al.add(obed);
            al.add(ibed);
        }
		//System.out.println(req);
		//System.out.println(req.getParameter("sid"));
		if(req.getParameter("sid")!=null)
		{
			al.add("true");
		}
		if(req.getParameter("iid")!=null)
		{
			al.add("false");
		}
		if(req.getParameter("id")!=null)
		{
			al.add("med");
		}
		System.out.print(al);
		
        req.setAttribute("data", al);

		if(req.isUserInRole("admin"))
		{
			RequestDispatcher rd = req.getRequestDispatcher("selectallv2.jsp");
			rd.forward(req, res);
		}
		else if(req.isUserInRole("user"))
		{
			RequestDispatcher rd = req.getRequestDispatcher("selectallv3.jsp");
			rd.forward(req, res);
		}
    }catch(SQLException e){
        e.printStackTrace();
    }

    }

}
