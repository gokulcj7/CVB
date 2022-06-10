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


@WebServlet("/Delete")
public class Delete extends HttpServlet
{
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException
	{
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		try
		{
			
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost/covid","root","Gokul@2001");
			String sql1= "delete from hospital_information where hospital_id=?";
			String sql = "delete from hospitals where hospital_id=?";
			
			PreparedStatement st1 = con.prepareStatement(sql1);
			PreparedStatement st = con.prepareStatement(sql);
			
			
			int id=Integer.parseInt(request.getParameter("sid"));

			st1.setInt(1,id);
			st.setInt(1,id);
			
			st1.executeUpdate();
			int n=st.executeUpdate();
			
			if(n==1)
			{	
				out.print("<p>No Hospitals Deleted<p>");
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
	
		