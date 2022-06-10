package jaas;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.sql.*;


import javax.security.auth.Subject;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.NameCallback;
import javax.security.auth.callback.PasswordCallback;
import javax.security.auth.callback.UnsupportedCallbackException;
import javax.security.auth.login.LoginException;
import javax.security.auth.spi.LoginModule;

public class CbaLoginModule implements LoginModule {

	private CallbackHandler handler;
	private Subject subject;
	private UserPrincipal userPrincipal;
	private RolePrincipal rolePrincipal;
	private String login;
	private List<String> userGroups;

	@Override
	public void initialize(Subject subject, CallbackHandler callbackHandler,
			Map<String, ?> sharedState, Map<String, ?> options) {

		handler = callbackHandler;
		this.subject = subject;
	}

	@Override
	public boolean login() throws LoginException {

		Callback[] callbacks = new Callback[2];
		callbacks[0] = new NameCallback("login");
		callbacks[1] = new PasswordCallback("password", true);

		try {
			handler.handle(callbacks);
			String name = ((NameCallback) callbacks[0]).getName();
			String password = String.valueOf(((PasswordCallback) callbacks[1])
					.getPassword());

			  try
			{
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/covid", "root", "Gokul@2001");;
			
			
			
			String query="select * from admin where username=?";
			PreparedStatement st=con.prepareStatement(query);
			
			String qr1="select email,password from user where email=?";
			PreparedStatement st1=con.prepareStatement(qr1);
			
			st.setString(1,name);

			st1.setString(1,name);

			ResultSet rs=st.executeQuery();
			if(rs.next())
			{
				
				String username=rs.getString(1);
				String pass=rs.getString(2);
				System.out.println(username+" "+name);
				System.out.println(pass+" "+password);
			  if (password.equals(pass)) {
				login = name;
				userGroups = new ArrayList<String>();
				userGroups.add("admin");
				return true;
				}
			}
			rs.close();
			ResultSet rs1=st1.executeQuery();
			if(rs1.next())
			{
				String username=rs1.getString(1);
				String pass=rs1.getString(2);
			  if (password.equals(pass)) {
				login = name;
				userGroups = new ArrayList<String>();
				userGroups.add("user");
				return true;
				}
			}
			
			
	  }
	  catch(Exception e)
	  {
		  System.out.println("Connection Failed");
	  }

      throw new LoginException("Authentication failed");

    } catch (IOException e) {
      throw new LoginException(e.getMessage());
    } catch (UnsupportedCallbackException e) {
      throw new LoginException(e.getMessage());
    }

	}

	@Override
	public boolean commit() throws LoginException {

		userPrincipal = new UserPrincipal(login);
		subject.getPrincipals().add(userPrincipal);

		if (userGroups != null && userGroups.size() > 0) {
			for (String groupName : userGroups) {
				rolePrincipal = new RolePrincipal(groupName);
				subject.getPrincipals().add(rolePrincipal);
			}
		}

		return true;
	}

	@Override
	public boolean abort() throws LoginException {
		return false;
	}

	@Override
	public boolean logout() throws LoginException {
		subject.getPrincipals().remove(userPrincipal);
		subject.getPrincipals().remove(rolePrincipal);
		return true;
	}


}
