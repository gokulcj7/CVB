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



@WebServlet("/Insert")
public class Insert extends HttpServlet
{
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException
	{
		
		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();	
		
		try
		{
			
			Connection con = null;
			
			PreparedStatement st=null;
			PreparedStatement st1=null;
			con=DriverManager.getConnection("jdbc:mysql://localhost/covid", "root", "Gokul@2001");
			
			String query="insert into hospitals(hospital_id,Hospital_Name,Location) values(?,?,?)";
			String query1="insert into hospital_information(hospital_id,Hospital_Name,normal_bed,oxygen_bed,icu_bed) values(?,?,?,?,?)";
			
			
			st=con.prepareStatement(query);
			st1=con.prepareStatement(query1);
			
			
			st.setInt(1,Integer.parseInt(request.getParameter("iid")));
			st.setString(2,request.getParameter(("name")));
			st.setString(3,request.getParameter(("location")));
			
			st1.setInt(1,Integer.parseInt(request.getParameter("iid")));
			st1.setString(2,request.getParameter(("name")));
			st1.setInt(3,Integer.parseInt(request.getParameter("nbed")));
			st1.setInt(4,Integer.parseInt(request.getParameter("obed")));
			st1.setInt(5,Integer.parseInt(request.getParameter("ibed")));
			
			
			int n=st.executeUpdate();
			int n1=st1.executeUpdate();
			
			if(n>0 && n1>0)
			{
				ServletContext context= getServletContext();
				RequestDispatcher rd= context.getRequestDispatcher("/Selectall");
				rd.forward(request, response);
			}
			else
			{
				out.print("<p>Failed to Insert<p>");
				request.getRequestDispatcher("insert.html").include(request,response);
			}
			
			st.close();
			
		}
		catch(Exception e)
		{			
			e.printStackTrace();
		}
		out.close();
	}
}