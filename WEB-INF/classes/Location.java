import java.io.PrintWriter;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import org.json.JSONObject;
import org.json.simple.JSONArray;
import org.json.*;


public class Location extends HttpServlet 
{
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException
		{
				try{
				String loc=request.getParameter("location");
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost/covid","root","Gokul@2001");
				Statement st=con.createStatement();
	            String sql="select hospitals.hospital_id,hospital_information.Hospital_Name,hospitals.location,hospital_information.normal_bed,hospital_information.oxygen_bed,hospital_information.icu_bed FROM hospitals INNER JOIN hospital_information ON hospitals.hospital_id=hospital_information.hospital_id where hospitals.location="+"'"+loc+"'";
				ResultSet rs=st.executeQuery(sql);
				JSONObject json=new JSONObject();
				JSONArray arr=new JSONArray();
				
				int i=1;
				while(rs.next()){
							JSONObject details=new JSONObject();
							details.put("type","hospitals");
							details.put("id",i+"");
							JSONObject attributes=new JSONObject();
							i++;
							String rn=(rs.getInt(1)+"");
							String na=rs.getString(2);
							String pe=rs.getString(3);
							String ad=rs.getString(4);
							String obed=rs.getString(5);
							String ibed=rs.getString(6);
							attributes.put("hid",rn);
							attributes.put("hospital_name",na);
							attributes.put("location",pe);
							attributes.put("normal_beds",ad);
							attributes.put("oxygen_beds",obed);
							attributes.put("icu_beds",ibed);
							details.put("attributes",attributes);
							arr.add(details);
				}
				json.put("data",arr);
				response.getWriter().write(json.toString());
				
				
			}
				catch(Exception e)
				{
					e.printStackTrace();
				}
		}
}