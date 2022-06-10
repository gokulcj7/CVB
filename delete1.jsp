<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <link href="style.css" rel="stylesheet" type="text/css">
	    <link rel="preconnect" href="https://fonts.googleapis.com">
	    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	    <link href="https://fonts.googleapis.com/css2?family=Montserrat&family=Teko:wght@500&display=swap" rel="stylesheet">
		 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

		<!-- Optional theme -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

		<style>
        body{
            background-color:rgba(107, 147, 207, 0.795);
        }
        table{
            text-align: center;
            width: 50%;
        }
        th{
            border: 1px solid black;
            background-color: aliceblue;
            font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        h1{
            text-align: center;
        }
        td{
            border: 1px solid black;
            background-color: aliceblue;
            font-family: 'Montserrat', sans-serif;
        }
        .main{
            display: flex;
            justify-content: center;
        }
		.f4{
			display:flex;
			justify-content:center;
		}
        .main form[type="submit"]{
            background-color:rgba(107, 147, 207, 0.795);
        }
    </style>

    </head>

    <body>
        <%

            try
            {
                Connection con=DriverManager.getConnection("jdbc:mysql://localhost/covid","root","Gokul@2001");
            
               
                String sql1= "delete from hospital_information where hospital_id=?";
                String sql = "delete from hospitals where hospital_id=?";

                PreparedStatement st1 = con.prepareStatement(sql1);
                PreparedStatement st = con.prepareStatement(sql);
                
                
                int id=Integer.parseInt(request.getParameter("id").trim());

                st1.setInt(1,id);
                st.setInt(1,id);
                
                st1.executeUpdate();
                int n=st.executeUpdate();
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
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
                <th colspan="2">
                    Actions
                </th>
        </tr>
        <%int i=0; 
              while(rs.next()){
                    String rn=(rs.getInt(1)+"");
                    String na=rs.getString(2);
                    String pe=rs.getString(3);
                    String ad=rs.getString(4);
                    String obed=rs.getString(5);
                    String ibed=rs.getString(6);
        %>
        <form name="data">
        <tr id="row<%=i%>">
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
        <td>
                <input type="hidden" name="type" value="edit">
                <button type="button" onclick="loadAjax('row<%=i%>')">edit</button>
        </td>
        <td>
                <input type="hidden" name="sid" value = "delete">
                <button type="button" onclick="loadAjax2('row<%=i%>')">Delete</button>
        </td>
    </tr>
    
    <% i++;    
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



                