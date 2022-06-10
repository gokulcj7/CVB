<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	</head>
	<body>
		<%
			try{
	            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/covid","root","Gokul@2001");
	            Statement st=con.createStatement();
	            String sql="select hospitals.hospital_id,hospital_information.Hospital_Name,hospitals.location,hospital_information.normal_bed,hospital_information.oxygen_bed,hospital_information.icu_bed FROM hospitals INNER JOIN hospital_information ON hospitals.hospital_id=hospital_information.hospital_id;";
	            ResultSet rs=st.executeQuery(sql);
	    %>
	    <table id="data" class="table table-hover">
		<tr>
                <th>
                    Hospital ID
                </th>
                <th>
                    Hospital Name
                </th>
                <th>
                    Location
                </th>
                <th>
                    Normal Beds
                </th>
                <th>
                    Oxygen Beds
                </th>
                <th>
                    ICU Beds
                </th>
        </tr>
	    <%     
	    while(rs.next()){
	                String rn=(rs.getInt(1)+"");
	                String na=rs.getString(2);
	                String pe=rs.getString(3);
	                String ad=rs.getString(4);
	                String obed=rs.getString(5);
	                String ibed=rs.getString(6);
	    %>
	    <form name="data">
    	<tr id>
        <td>
            <input type="text" name="id" id="id" value=" <%=rn%>" readonly>
        </td>
        <td>
            <input type="text" name="name" id="name" value=" <%=na%> ">
        </td>
        <td>
            <input type="text" name="location" id="location" value=" <%=pe%>">
        </td>
        <td>
            <input type="text" name="nbed" id="nbed" value=" <%=ad%>">
        </td>
        <td>
            <input type="text" name="obed" id="obed" value=" <%=obed%>">
        </td>
        <td>
            <input type="text" name="ibed" id="ibed" value=" <%=ibed%>">
        </td>
    </tr>
    <%  
        }

        }
        catch(Exception e)
        {
            e.printStackTrace();
        } 
	%> 
	</form>
    </table>

		
		
	</body>
</html>