import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.*;
import javax.servlet.*;


@WebServlet("/Update")
public class Update extends HttpServlet
{
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException
	{
		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();

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
			
			if(n1>0 || n2>0 || n3>0 || n4>0)
			{
				ServletContext context= getServletContext();
				RequestDispatcher rd= context.getRequestDispatcher("/Selectall");
				rd.forward(request, response);
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		out.close();
		
	}
	
}
	
			