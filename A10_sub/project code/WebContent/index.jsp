
<!DOCTYPE html>
<html>
<head>
	<style>
	#header {
	    background-color:burlywood;
	    color:white;
	    text-align:center;
	    padding:5px;
	}
	#nav {
	    line-height:35px;
	    background-color:lightcyan;
	    height:500px;
	    width:250px;
	     text-align:left;
	    padding:5px;	      
	}
	
	#footer {
	    background-color:burlywood;
	    color:white;
	    clear:both;
	    text-align:center;
	   padding:5px;	 	 
	}

	</style>
        <title>Ray's Grocery Main Page</title>
</head>
<body>

<div id="header">
<h1><font face="Comic Sans MS">Welcome to An Qing Luxury</font></h1>
</div>


<div id="nav">
    <h2><font face="Comic Sans MS">
<a href="listprod.jsp">Begin Shopping</a><br><br>

<a href="userAccount.jsp">User Center</a><br><br>


<a href="customer.jsp">Customer Info</a><br><br>

<a href="admin.jsp">Administrators</a><br><br>

<a href="review.jsp">Product reviews</a>
        </font></h2>

</div>
<p>


</p>



<%@ include file="jdbc.jsp" %>

<%
//TODO: Display user name that is logged in (or nothing if not logged in)
	String userName = (String) session.getAttribute("authenticatedUser"); //userid or null
//make connection:
	getConnection();
	if(!(userName == null))
		out.print("<h3 align=\"center\">Signed in as: "+ userName +"</h3>");

closeConnection();

%>
</body>
</head>


