<%@ include file="jdbc.jsp" %>

<H1 align="center"><font face="cursive" color="#3399FF"><a href="index.jsp">An Qing Luxury</a></font></H1>  

<%out.print("<a href =\"showcart.jsp\">shopping cart</a>"); %>   

<% 
String userNameH = (String) session.getAttribute("authenticatedUser"); //userid or null

getConnection();
String sqlH = "Select customerId From customer Where userid = ?";
PreparedStatement pstH = con.prepareStatement(sqlH);
pstH.setString(1,userNameH);
ResultSet rstH = pstH.executeQuery();


if(!(userNameH == null) && rstH.next()){
	out.print("<h3 align=\"right\">Signed in as: "+ userNameH +"   || customerId: "+ rstH.getInt(1)+"</h3>");
	
		
}

	
%> 
<hr>

