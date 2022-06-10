import java.io.IOException;
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
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;


public class Demo extends HttpServlet 
{
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException
		{	
			System.out.println("Accessed");
			System.out.println(request.getRequestURI());
			
		}
}