<!DOCTYPE html>
<html>
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
            <li><a href="LogoutServlet">Logout</a></li>
          </ul>
        </li>
	</ul>
	 <div class="title">
        <a class="navbar-brand mx-auto" href="#">Hospital Management System</a>
	 </div>
	</nav>
    <%@page import="java.util.*"%>

    <%
    ArrayList<String> std = new ArrayList<>();

    std=(ArrayList<String>)request.getAttribute("data");
        request.getSession().setAttribute("data", std);
		
	if(std.get(std.size()-1).equals("true"))
	{
		out.println("<script>alert('deleted succesfully')</script>");
	}
	if(std.get(std.size()-1).equals("false"))
	{
		out.println("<script>alert('Inserted succesfully')</script>");
	}
	if(std.get(std.size()-1).equals("med"))
	{
		out.println("<script>alert('Updated succesfully')</script>");
	}
	
	
	
    %>
    <span id="temp"></span>
    <!--<h1>Hospital Management System</h1>-->
    <div class="f4">
	<div id="btn1">
		<button type="button" class="btn btn-light" onclick="add_hos()">Add Hospital</button>
       <!-- <button onclick="add_hos()"> Add Hospital</button> -->
	</div>
		<span id="ip"></span>
    </div>
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
                <th colspan="2">
                    Actions
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
                <form name="data2">
                    <input type="text" id="id" name="id" value=" <%=rn%>" readonly>
                </form>
            </td>
            <td>
                <form name="data3">
                    <input type="text" id="name" name="name" value=" <%=na%> ">
                </form>
            </td>
            <td>
                <form name="data4">
                    <input type="text" id="location" name="location" value=" <%=pe%>">
                </form>
            </td>
            <td>
                <form name="data5">
                    <input type="text" id="nbed" name="nbed" value=" <%=ad%>">
                </form>
            </td>
            <td>
                <form name="data6">
                    <input type="text" id="obed" name="obed" value=" <%=obed%>">
                </form>
            </td>
            <td>
                <form name="data7">
                    <input type="text" id="ibed" name="ibed" value=" <%=ibed%>">
                </form>
            </td>
            <td>
                <input type="hidden" name="type" value="edit">
                <!--<input type="submit" name="edit" value="edit"> -->
                <button type="submit" onclick="sendInfo1()">Edit</button>
            </td>

        
        <td>
            <form name="data1">
                <input type="hidden" name="sid" value = "<%=rn%>">
                <!--<input type="submit" name="delete" value="delete"> -->
                <button type="submit" onclick="sendInfo2()">Delete</button>
            </form>
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


</body>
</html>