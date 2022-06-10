import java.io.*;
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
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import javax.mail.Session;
import javax.mail.Transport;
import java.time.LocalTime;

 @WebServlet("/Otp")
public class Otp extends HttpServlet{

    public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException{
		try{
			 HttpSession session=req.getSession();  
				
				Otp op=new Otp();
				int randomPin   =(int) (Math.random()*90000000)+10000000;
				String code  = String.valueOf(randomPin);
				String email=(session.getAttribute("email")).toString();
				System.out.println("hi"+""+email);
				
				Connection con = null;
				PreparedStatement st=null;
				PreparedStatement st1=null;
				con=DriverManager.getConnection("jdbc:mysql://localhost/covid", "root", "Gokul@2001");
				String query1=("select flag,otp from auth where uname=?");
				st=con.prepareStatement(query1);
				st.setString(1,email);
				ResultSet rs=st.executeQuery();
				String flag="";
				String dotp="";
				while(rs.next())
				{
					flag=rs.getString(1);
					dotp=rs.getString(2);
					
				}
				if(flag.equals("0"))
				{
					String query="update auth set otp =?,flag=? where uname=?";
					
					st1=con.prepareStatement(query);
					st1.setString(1,code);
					st1.setString(2,"1");
					st1.setString(3,email);
					st1.executeUpdate();
				}
				else if(flag.equals("1"))
				{
					code=dotp;
				}
				
                op.SendOtp(email,code);
				
			  if(req.isUserInRole("admin"))
			  {
				ServletContext context= getServletContext();
				RequestDispatcher rd= context.getRequestDispatcher("/Otp.html");
				rd.forward(req, res);
				//RequestDispatcher rd=req.getRequestDispatcher("Selectall");
				//rd.forward(req,res);
              }
			  else
			  {
				RequestDispatcher rd=req.getRequestDispatcher("/Otp.html");
				rd.forward(req,res);
			  }	
				
                
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
				
	}
    public void SendOtp(String rname,String code){

          System.out.println("Sending Mail...");   
          Properties properties=new Properties();
          properties.put("mail.smtp.auth","true");
          properties.put("mail.smtp.starttls.enable","true");
          properties.put("mail.smtp.host","smtp.gmail.com");
          properties.put("mail.smtp.port","587");

          String sender="1912058@nec.edu.in";
          String pass="jonesgeethalaya";

          Session session = Session.getInstance(properties,new Authenticator(){
           @Override
           protected PasswordAuthentication getPasswordAuthentication(){
               return new PasswordAuthentication(sender,pass);
           }
     });
          Message message =preparemessage(session,sender,rname,code); 
          try{
          Transport.send(message);
          System.out.println("OTP Sent Successfully"); 
          }
          catch(Exception e){
          e.printStackTrace();
       }     
       }

    private static Message preparemessage(Session session,String sender,String rname,String code){
    try{
         Message message =new MimeMessage(session);
         message.setFrom(new InternetAddress(sender));
         message.setRecipient(Message.RecipientType.TO,new InternetAddress(rname));
         message.setSubject("Two Factor Authentication");
         message.setText("One time password: "+code+""+"\nDo not share with this code to anyone");
         return message;
    } catch(Exception ex){
        ex.printStackTrace();
    }
     return null;
    }

	

    
}