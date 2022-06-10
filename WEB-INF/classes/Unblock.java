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


public class Unblock extends HttpServlet{
    public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
        try{
        	 String s=request.getParameter("uname");
        	 System.out.println(s);
        	 UnlockUser.unlock(s);

        	}


        	catch(Exception e){
        e.printStackTrace();
    }

    }
}

class UnlockUser extends LockoutRealm{

	public static void unlock(String username)
	{
		System.out.print("Unlocked");
		super.unlock(username);
	}
}