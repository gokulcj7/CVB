<html>
<head>
	<title>HOSPITAL MANAGEMENT SYSTEM</title>
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

    <script type="text/javascript">
    let a=0;
    function loc()
    {
        a++;
        html='<div id=dform'+a+'>\
        <input type="text" name="nloc" placeholder="Location">\
        <button onclick="hide(`dform`+a)">submit</button>\
        </div>'
        var ip=document.getElementById('temp');
        ip.innerHTML+=html;
    }
    function hide(y)
    {
        var x=document.getElementById(y);
        x.style.display="none";
        loadAjax1(y);
    }
    function loadAjax1(x)
    {
        var t=document.getElementById(x);
        console.log(t);
        var location=t.children[0].value;
        console.log(location);
        var url="Location?location="+location;

         ajaxGetRequest(url,injectionOfNewRow);

			function ajaxGetRequest(path, callback){
				let request = new XMLHttpRequest();
				request.onreadystatechange = function(){
					if (this.readyState === 4 && this.status === 200){
						callback(this.response);
					}
				};
                request.open("GET", path);
                request.setRequestHeader("Content-Type", "application/vnd.api+json");
				request.send();
			}

			function injectionOfNewRow(resp) {
				console.log(resp);

				// var testing ={"data":[{"attributes":{"hid":"101","icu_beds":"13","location":"Chennai","oxygen_beds":"10","normal_beds":"10","hospital_name":"Apollo"},"id":"1","type":"hospitals"},{"attributes":{"hid":"102","icu_beds":"20","location":"Tirunelveli","oxygen_beds":"23","normal_beds":"23","hospital_name":"Galaxy"},"id":"2","type":"hospitals"},{"attributes":{"hid":"103","icu_beds":"13","location":"Tirunelveli","oxygen_beds":"12","normal_beds":"11","hospital_name":"Shifa"},"id":"3","type":"hospitals"},{"attributes":{"hid":"104","icu_beds":"27","location":"Chennai","oxygen_beds":"26","normal_beds":"25","hospital_name":"Stanly"},"id":"4","type":"hospitals"},{"attributes":{"hid":"105","icu_beds":"12","location":"Tirunelveli","oxygen_beds":"11","normal_beds":"10","hospital_name":"TMC"},"id":"5","type":"hospitals"},{"attributes":{"hid":"106","icu_beds":"17","location":"Vellore","oxygen_beds":"16","normal_beds":"15","hospital_name":"VMC"},"id":"6","type":"hospitals"},{"attributes":{"hid":"107","icu_beds":"31","location":"Trichy","oxygen_beds":"30","normal_beds":"29","hospital_name":"BHEL"},"id":"7","type":"hospitals"},{"attributes":{"hid":"108","icu_beds":"12","location":"Tirunelveli","oxygen_beds":"11","normal_beds":"10","hospital_name":"GH"},"id":"8","type":"hospitals"},{"attributes":{"hid":"109","icu_beds":"12","location":"Madurai","oxygen_beds":"11","normal_beds":"10","hospital_name":"Mission"},"id":"9","type":"hospitals"},{"attributes":{"hid":"110","icu_beds":"17","location":"Chennai","oxygen_beds":"12","normal_beds":"12","hospital_name":"MMC"},"id":"10","type":"hospitals"},{"attributes":{"hid":"111","icu_beds":"11","location":"FF","oxygen_beds":"11","normal_beds":"11","hospital_name":"DEF"},"id":"11","type":"hospitals"},{"attributes":{"hid":"112","icu_beds":"12","location":"hdj","oxygen_beds":"11","normal_beds":"10","hospital_name":"RKO"},"id":"12","type":"hospitals"},{"attributes":{"hid":"113","icu_beds":"12","location":"DEF","oxygen_beds":"10","normal_beds":"9","hospital_name":"RKO"},"id":"13","type":"hospitals"}]};
				var testing = JSON.parse(resp);
				console.log(testing	);
            
                var datas = testing.data;
                console.log(datas);
           
                var row = 0;
                var rowshtml = '<tbody><tr> <th> Hospital ID </th> <th> Hospital Name </th> <th> Location </th> <th> Normal Beds </th> <th> Oxygen Beds </th> <th> ICU Beds </th> </tr>';
                var alter = document.getElementById("data");
                var check=0;
                datas.forEach(data => {
                    data = data.attributes;
                    if(data.hid)
                    {
                        check=1;
                    }
                    rowshtml+='<tr id="row'+row+'">\
                            <td>\
                                <input type="text" name="id" id="id" value="'+data.hid+'" pwa2-uuid="EDITOR/input-B30-159-55FB6-5D0" pwa-fake-editor="">\
                            </td>\
                            <td>\
                                <input type="text" name="name" id="name" value="'+data.hospital_name+'" pwa2-uuid="EDITOR/input-4B9-DE2-3B130-35F" pwa-fake-editor="">\
                            </td>\
                            <td>\
                                <input type="text" name="location" id="location" value="'+data.location+'" pwa2-uuid="EDITOR/input-9C0-88D-E1565-DA0" pwa-fake-editor="">\
                            </td>\
                            <td>\
                                <input type="text" name="nbed" id="nbed" value="'+data.normal_beds+'" pwa2-uuid="EDITOR/input-7D6-A34-8484E-B3F" pwa-fake-editor="">\
                            </td>\
                            <td>\
                                <input type="text" name="obed" id="obed" value="'+data.oxygen_beds+'" pwa2-uuid="EDITOR/input-87F-64F-97785-FCD" pwa-fake-editor="">\
                            </td>\
                            <td>\
                                <input type="text" name="ibed" id="ibed" value="'+data.icu_beds+'" pwa2-uuid="EDITOR/input-194-064-24C22-28D" pwa-fake-editor="">\
                            </td>\
                        </tr>';
                        rowshtml+='</tbody>';
                        alter.innerHTML = rowshtml;
                        row++;
                        
                    });
                    if(check==0)
                    {
                        alert("No hospitals to display !");
                        alter.innerHTML ="";
                    }
			}
            

           
    }

  

    function loadAjax(){
           
            var url="Ajax";

           ajaxGetRequest(url,injectionOfNewRow);

			function ajaxGetRequest(path, callback){
				let request = new XMLHttpRequest();
				request.onreadystatechange = function(){
					if (this.readyState === 4 && this.status === 200){
						callback(this.response);
					}
				};
				request.open("GET", path);
                request.setRequestHeader("Content-Type", "application/vnd.api+json");
                request.send();
			}

			function injectionOfNewRow(resp) {
				console.log(resp);

				// var testing ={"data":[{"attributes":{"hid":"101","icu_beds":"13","location":"Chennai","oxygen_beds":"10","normal_beds":"10","hospital_name":"Apollo"},"id":"1","type":"hospitals"},{"attributes":{"hid":"102","icu_beds":"20","location":"Tirunelveli","oxygen_beds":"23","normal_beds":"23","hospital_name":"Galaxy"},"id":"2","type":"hospitals"},{"attributes":{"hid":"103","icu_beds":"13","location":"Tirunelveli","oxygen_beds":"12","normal_beds":"11","hospital_name":"Shifa"},"id":"3","type":"hospitals"},{"attributes":{"hid":"104","icu_beds":"27","location":"Chennai","oxygen_beds":"26","normal_beds":"25","hospital_name":"Stanly"},"id":"4","type":"hospitals"},{"attributes":{"hid":"105","icu_beds":"12","location":"Tirunelveli","oxygen_beds":"11","normal_beds":"10","hospital_name":"TMC"},"id":"5","type":"hospitals"},{"attributes":{"hid":"106","icu_beds":"17","location":"Vellore","oxygen_beds":"16","normal_beds":"15","hospital_name":"VMC"},"id":"6","type":"hospitals"},{"attributes":{"hid":"107","icu_beds":"31","location":"Trichy","oxygen_beds":"30","normal_beds":"29","hospital_name":"BHEL"},"id":"7","type":"hospitals"},{"attributes":{"hid":"108","icu_beds":"12","location":"Tirunelveli","oxygen_beds":"11","normal_beds":"10","hospital_name":"GH"},"id":"8","type":"hospitals"},{"attributes":{"hid":"109","icu_beds":"12","location":"Madurai","oxygen_beds":"11","normal_beds":"10","hospital_name":"Mission"},"id":"9","type":"hospitals"},{"attributes":{"hid":"110","icu_beds":"17","location":"Chennai","oxygen_beds":"12","normal_beds":"12","hospital_name":"MMC"},"id":"10","type":"hospitals"},{"attributes":{"hid":"111","icu_beds":"11","location":"FF","oxygen_beds":"11","normal_beds":"11","hospital_name":"DEF"},"id":"11","type":"hospitals"},{"attributes":{"hid":"112","icu_beds":"12","location":"hdj","oxygen_beds":"11","normal_beds":"10","hospital_name":"RKO"},"id":"12","type":"hospitals"},{"attributes":{"hid":"113","icu_beds":"12","location":"DEF","oxygen_beds":"10","normal_beds":"9","hospital_name":"RKO"},"id":"13","type":"hospitals"}]};
				var testing = JSON.parse(resp);
				console.log(testing	);
			var datas = testing.data;

			var row = 0;
			var rowshtml = '<tbody><tr> <th> Hospital ID </th> <th> Hospital Name </th> <th> Location </th> <th> Normal Beds </th> <th> Oxygen Beds </th> <th> ICU Beds </th> </tr>';
			var alter = document.getElementById("data");
			datas.forEach(data => {
				data = data.attributes;
				rowshtml+='<tr id="row'+row+'">\
						<td>\
							<input type="text" name="id" id="id" value="'+data.hid+'" pwa2-uuid="EDITOR/input-B30-159-55FB6-5D0" pwa-fake-editor="">\
						</td>\
						<td>\
							<input type="text" name="name" id="name" value="'+data.hospital_name+'" pwa2-uuid="EDITOR/input-4B9-DE2-3B130-35F" pwa-fake-editor="">\
						</td>\
						<td>\
							<input type="text" name="location" id="location" value="'+data.location+'" pwa2-uuid="EDITOR/input-9C0-88D-E1565-DA0" pwa-fake-editor="">\
						</td>\
						<td>\
							<input type="text" name="nbed" id="nbed" value="'+data.normal_beds+'" pwa2-uuid="EDITOR/input-7D6-A34-8484E-B3F" pwa-fake-editor="">\
						</td>\
						<td>\
							<input type="text" name="obed" id="obed" value="'+data.oxygen_beds+'" pwa2-uuid="EDITOR/input-87F-64F-97785-FCD" pwa-fake-editor="">\
						</td>\
						<td>\
							<input type="text" name="ibed" id="ibed" value="'+data.icu_beds+'" pwa2-uuid="EDITOR/input-194-064-24C22-28D" pwa-fake-editor="">\
						</td>\
					</tr>';
					rowshtml+='</tbody>';
					alter.innerHTML = rowshtml;
					row++;
					
				});
			}

			
        }


    </script>
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
        ArrayList<String> std = new ArrayList<>();

        std=(ArrayList<String>)request.getAttribute("data");
            request.getSession().setAttribute("data", std);
        
    %>

    <button class="btn btn-light" onclick="loc()">Nearby Hospitals</button>
          <button class="btn btn-light" onclick="loadAjax()">All Hospitals</button>
          
    <span id="temp"></span>
      
    <br>

    <p id="print"></p>
    <div id="tad">
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
                    String na=it.next();
                    String pe=it.next();
                    String ad=it.next();
                    String obed=it.next();
                    String ibed=it.next();
            %>
        
        

        <tr>
            <td>
                <input type="text" name="id" id="id" value="<%=rn%>" readonly>
            </td>
            <td>
                <input type="text" name="name" id="name" value="<%=na%>" readonly>
            </td>
            <td>
                <input type="text" name="location" id="location" value="<%=pe%>" readonly>
            </td>
            <td>
                <input type="text" name="nbed" id="nbed" value="<%=ad%>" readonly>
            </td>
            <td>
                <input type="text" name="obed" id="obed" value="<%=obed%>" readonly>
            </td>
            <td>
                <input type="text" name="ibed" id="ibed" value="<%=ibed%>" readonly>
            </td>
        </form>
       <% 
        } 
        %>       </tr>
   </table>
</div>
</div>
</div>