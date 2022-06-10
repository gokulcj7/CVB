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

public class Val extends HttpServlet{
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		String otp=request.getParameter("otp");
		try{
			Connection con = null;
			PreparedStatement st=null;
			con=DriverManager.getConnection("jdbc:mysql://localhost/covid", "root", "Gokul@2001");
			String email=request.getRemoteUser();
			String query="SELECT otp FROM auth where uname=?";
			st=con.prepareStatement(query);
			st.setString(1,email);
			ResultSet rs=st.executeQuery();
			String oo="";
			while(rs.next())
			{
				oo=rs.getString(1);
			}
			if(otp.equals(oo))
			{
				PreparedStatement st1=null;
				String query1="update auth set flag=? where uname=?";
				st1=con.prepareStatement(query1);
				st1.setString(1,"0");
				st1.setString(2,email);
				st1.executeUpdate();
				ServletContext context= getServletContext();
				response.setStatus(200);
				RequestDispatcher rd= context.getRequestDispatcher("/Selectall");
				rd.forward(request, response);
			}
			else
			{
				System.out.println("<script>alert('Enter correct Otp')</script>");
				RequestDispatcher rd = request.getRequestDispatcher("/Otp.html");
				rd.forward(request, response);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	
	
	
	
	
	}
	
}