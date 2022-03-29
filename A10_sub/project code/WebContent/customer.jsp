<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
<style type="text/css">
table {
  border: 1px solid black;
}
</style>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="header.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
	//String testo = userName + "a";  //userName works here even if it is in the pervious < > block
// TODO: customer login page > (if correct uid/pw) custmer profile page

	// Make connection: header>jdbc.jsp
	getConnection();
	
//part1: customer info
	String sql = "SELECT * FROM customer where userid = ?;";
	PreparedStatement pst = con.prepareStatement(sql);
	pst.setString(1, userName);
	ResultSet rst = pst.executeQuery();
	int customerId = -1;
	
	while(rst.next()){
		out.print("<h1>Customer Profile</h1>");
		//firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password
		out.print("<table> <tr> <th>Id</th>  <td>" + rst.getString("userid") + "</td> </tr>");
		out.print("<tr> <th>First Name</th>  <td>" + rst.getString("firstName") + "</td> </tr>");
		out.print("<tr> <th>Last Name</th>  <td>" + rst.getString("lastName") + "</td> </tr>");
		out.print("<tr> <th>Email</th>  <td>" + rst.getString("email") + "</td> </tr>");
		out.print("<tr> <th>Phone</th>  <td>" + rst.getString("phonenum") + "</td> </tr>");
		out.print("<tr> <th>Address</th>  <td>" + rst.getString("address") + "</td> </tr>");
		out.print("<tr> <th>City</th>  <td>" + rst.getString("city") + "</td> </tr>");
		out.print("<tr> <th>State</th>  <td>" + rst.getString("state") + "</td> </tr>");
		out.print("<tr> <th>Postal Code</th>  <td>" + rst.getString("postalCode") + "</td> </tr>");
		out.print("<tr> <th>Country</th>  <td>" + rst.getString("country") + "</td> </tr>");
		out.print(" </table>");
		customerId = rst.getInt("customerId");
	}
	

//part3: edit Profile
			out.print("<h1>Edit Profile</h1>");
			out.print("<p>change both fields to edit</p>");
			out.print("<p>refresh to see update</p>");
			
		%>
			<form method=get action="customer.jsp">
				<table> <tr><th>address</th> <td><input type="text" name="address"  size=50  > </td> </tr>
						<tr><th>password</th><td><input type="text" name="pw"  size=50  ></td></tr> </table>
				<input type="submit" value="Submit"><input type="reset" value="Reset">
				
			</form>
			
			
		<% 	String address = request.getParameter("address");
			String pw = request.getParameter("pw");
			
			if((address != null || address != "") && (pw != null|| pw != "")){
				String sql3 = "Update customer Set address = ?, password = ? where customerId = ?;";
				PreparedStatement pst3 = con.prepareStatement(sql3);
				pst3.setString(1, address);
				pst3.setString(2,pw);
				pst3.setInt(3, customerId);
				int editR = pst3.executeUpdate();
			}
			
	
	
//part2: list of customer's order
	String sql2 = "SELECT * FROM ordersummary WHERE customerId = ?";
	PreparedStatement pst2 = con.prepareStatement(sql2);
	pst2.setInt(1,customerId);
	ResultSet rst2 = pst2.executeQuery();
	
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	out.print("<h1>List of Orders</h1>");
	out.print("<table> <tr> <th>orderId</th> <th>orderDate</th> <th>totalAmount</th> <th>shiptoAddress</th> <th>shiptoCity</th>"
			+" <th>shiptoState</th> <th>shiptoPostalCode</th> <th>shiptoCountry</th> </tr> ");
	while(rst2.next()){
		//firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password
		out.print("<tr>  <td>" + rst2.getInt(1) + "</td> ");
		out.print("<td>" + rst2.getDate(2) + "</td>");
		out.print("<td>" +  currFormat.format(rst2.getDouble(3)) + "</td>");
		out.print("<td>" + rst2.getString(4) + "</td>");
		out.print("<td>" + rst2.getString(5) + "</td>");
		out.print("<td>" + rst2.getString(6) + "</td> ");
		out.print("<td>" + rst2.getString(7) + "</td>");
		out.print("<td>" + rst2.getString(8) + "</td> </tr>");
		
	}out.print(" </table>");
	
	
	
	
// Close connection:try-catch	
 closeConnection();

%>

</body>
</html>

