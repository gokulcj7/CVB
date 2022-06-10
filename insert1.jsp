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
	<script type="text/javascript">
		function loadAjax(){
			var id= document.getElementById("id").value;
			var name= document.getElementById("name").value;
			var location= document.getElementById("location").value;
			var nbed= document.getElementById("nbed").value;
			var obed= document.getElementById("obed").value;
			var ibed= document.getElementById("ibed").value;
			
			
			var url="ajax.jsp?id="+id +"&name="+name+"&location="+location+"&nbed="+nbed+"&obed="+obed+"&ibed="+ibed;

			if(window.XMLHttpRequest){
				
				request = new XMLHttpRequest();
				
			}else if(window.ActiveXObject){
				
				request = new ActiveXObject("Microsoft.XMLHTTP");
			}
			
			try{
				request.onreadystatechange=sendInfo;
				request.open("POST",url,true);
				request.send();
				
			}catch(e){
				alert("Unable to connect server");
			}
			
		}

		function sendInfo(){
			var p =	document.getElementById("print");

			if(request.readyState ==4){
				var text = request.responseText;
				window.alert("Updated Successfully");
				p.innerHTML=text;
			}
		}
	</script>

	</head>

	<body>
		<%

			try
			{
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost/covid","root","Gokul@2001");
				String query1="insert into hospitals values(?,?,?)";
				String query2="insert into hospital_information values(?,?,?,?,?)";

				PreparedStatement st1 = con.prepareStatement(query1);
				PreparedStatement st2 = con.prepareStatement(query2);

				int id=Integer.parseInt(request.getParameter("id").trim());
				String name=request.getParameter("name").trim();
				String location=request.getParameter("location").trim();
				int nbed=Integer.parseInt(request.getParameter("nbed").trim());
				int obed=Integer.parseInt(request.getParameter("obed").trim());
				int ibed=Integer.parseInt(request.getParameter("ibed").trim());

				st1.setInt(1,id);
				st1.setString(2,name);
				st1.setString(3,location);

				st2.setInt(1,id);
				st2.setString(2,name);
				st2.setInt(3,nbed);
				st2.setInt(4,obed);
				st2.setInt(5,ibed);

				int n1=st1.executeUpdate();
				int n2=st2.executeUpdate();

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
	    <% int i=0;  
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


