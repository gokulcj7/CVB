import java.io.IOException;
import java.io.PrintWriter;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;



public class Ajax extends HttpServlet 
{
public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException
    {	
		
		
		

			try
			{
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost/covid","root","Gokul@2001");
				String query1="update hospital_information set normal_bed =? where hospital_id=?";
				String query2="update hospital_information set oxygen_bed =? where hospital_id=?";
				String query3="update hospital_information set icu_bed =? where hospital_id=?";
				String query4="update hospital_information set Hospital_Name =? where hospital_id=?";
				
				
			
				PreparedStatement st1 = con.prepareStatement(query1);
				PreparedStatement st2 = con.prepareStatement(query2);
				PreparedStatement st3 = con.prepareStatement(query3);
				PreparedStatement st4 = con.prepareStatement(query4);
				
				int id=Integer.parseInt(request.getParameter("id").trim());
				
				st1.setInt(1,Integer.parseInt(request.getParameter("nbed").trim()));
				st1.setInt(2,id);
				
				
				st2.setInt(1,Integer.parseInt(request.getParameter("obed").trim()));
				st2.setInt(2,id);
				
				st3.setInt(1,Integer.parseInt(request.getParameter("ibed").trim()));
				st3.setInt(2,id);
				
				st4.setString(1,request.getParameter("name").trim());
				st4.setInt(2,id);
				
				
				int n1=st1.executeUpdate();
				int n2=st2.executeUpdate();
				int n3=st3.executeUpdate();
				int n4=st4.executeUpdate();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			try{
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/covid","root","Gokul@2001");
            Statement st=con.createStatement();
            String sql="select hospitals.hospital_id,hospital_information.Hospital_Name,hospitals.location,hospital_information.normal_bed,hospital_information.oxygen_bed,hospital_information.icu_bed FROM hospitals INNER JOIN hospital_information ON hospitals.hospital_id=hospital_information.hospital_id;";
            ResultSet rs=st.executeQuery(sql);
		    int i=0; 
		    JSONObject ob=new JSONObject();
		    JSONArray arr=new JSONArray();
		    while(rs.next()){
		                String rn=(rs.getInt(1)+"");
		                String na=rs.getString(2);
		                String pe=rs.getString(3);
		                String ad=rs.getString(4);
		                String obed=rs.getString(5);
		                String ibed=rs.getString(6);
		                JSONObject obj=new JSONObject();
		                obj.put("ID",rn);
		                obj.put("Hospital Name",na);
		                obj.put("Location",pe);
		                obj.put("Normal Beds",ad);
		                obj.put("Oxygen Beds",obed);
		                obj.put("ICU Beds",ibed);
		                arr.add(obj);
		    }
	    	ob.put("hospital_details",arr);
	    	System.out.print(ob);
		}
			catch(Exception e)
			{
				e.printStackTrace();
			}
	                
	}
}