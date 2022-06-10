<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
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
	<script src="script.js"></script>
	<title>SelectAll</title>
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
	<nav class="navbar navbar-light" style="background-color: #e3f2fd;">
	<ul class="nav navbar-nav navbar-right">
		<li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-user"></span><%= request.getRemoteUser()%> <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
          </ul>
        </li>
	</ul>
	 <div class="title">
        <a class="navbar-brand mx-auto" href="Selectall">Hospital Management System</a>
	 </div>
	</nav>
    <%@page import="java.util.*"%>
	
	 <%
	 int flag=0;
    ArrayList<String> std = new ArrayList<>();

    std=(ArrayList<String>)request.getAttribute("data");
        request.getSession().setAttribute("data", std);
		
	if(std.size()==0)
	{
		out.println("<script>alert('No Hospitals to Display')</script>");
		flag=1;
	}
		
	  %>
          <button class="btn btn-light" onclick="loc()">Nearby Hospitals</button>
		  <a href="Selectall"><button class="btn btn-light">All Hospitals</button></a>
		  
	<span id="temp"></span>
	  
	  <br>
	  
	  
	
    
    <!--<h1>Hospital Management System</h1>-->
    
	<br>
    <div class="f1">
        <div class="main">  
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
        ListIterator<String> it = std.listIterator();
        while(it.hasNext()){
            
            String rn=it.next();
			if(rn.equals("true"))
			{
				break;
			}
			if(rn.equals("false"))
			{
				break;
			}
			if(rn.equals("med"))
			{
				break;
			}
            String na=it.next();
            String pe=it.next();
            String ad=it.next();
            String obed=it.next();
            String ibed=it.next();
        %>
       
        <tr>
            <td>
                <input type="text" name="id" value=" <%=rn%>" readonly>
            </td>
            <td>
                <input type="text" name="name" value=" <%=na%> " readonly>
            </td>
            <td>
                <input type="text" name="location" value=" <%=pe%>" readonly>
            </td>
            <td>
                <input type="text" name="nbed" value=" <%=ad%>" readonly>
            </td>
            <td>
                <input type="text" name="obed" value=" <%=obed%>" readonly>
            </td>
            <td>
                <input type="text" name="ibed" value=" <%=ibed%>" readonly>
            </td>
        

       
        </tr>
       
        <% } %> 
        </table>
        </div>
    </div>


<!--<div class="f3">
    <form style="border:none; padding:1%;" action="Logout">
        <input type="submit" value="Logout" style="padding: 5%;background-color:rgba(191, 211, 241, 0.795);border: none;" name="logout">
    </form>-->
</div>

</body>
</html>