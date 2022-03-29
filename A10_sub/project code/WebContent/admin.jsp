<!DOCTYPE html>
<html>
<head>
<style type="text/css">

table {
  border: 1px solid black;
}
</style>
<title>Administrator Page</title>
</head>
<body>
<%@include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="header.jsp" %>


<h1>Add new products</h1>
<% out.print("<table>");

out.print("<tr> <th>productName</th> <th>categoryId</th> <th>productDesc</th>  <th>productPrice</th>  <th>brandId</th>  </tr>");
out.print("<form method=\"get\" action=\"admin.jsp\">");
out.print("<tr> <td><input type=\"text\" name=\"productName\" size=\"50\" value=\"..\"> </td>");
out.print("<td> <input type=\"text\" name=\"categoryId\" size=\"3\" value=\"\"> </td>");
out.print("<td> <input type=\"text\" name=\"productDesc\" size=\"50\" value=\"\"> </td> ");
out.print("<td> <input type=\"text\" name=\"productPrice\" size=\"50\" value=\"\" > </td>");
out.print("<td> <input type=\"text\" name=\"brandId\" size=\"3\" value=\"\"> </td> </tr>");
		
out.print("	<tr> <td> <input type=\"submit\" value=\"Submit\"><input type=\"reset\" value=\"Reset\"> </td></tr>");
out.print("</form>");
	
 out.print("</table>"); %>
	<% String pname = request.getParameter("productName"); 
	String cid = request.getParameter("categoryId"); 
	 String productdesc = request.getParameter("productDesc") ;
	 String pr = request.getParameter("productPrice") ;
	 String bid = request.getParameter("brandId") ;	
	%>

<%

// TODO: Write SQL query that prints out total order amount by day
getConnection();

//part3: add new product
Statement stm3_1 = con.createStatement();
ResultSet rst3_1 = stm3_1.executeQuery("Select count(*) From product");
while(rst3_1.next()) out.print("<p>" +rst3_1.getInt(1)+ "</p>");
	out.print("//"+pname); out.print( "//"+cid); out.print( "//"+pr);  out.print( "//"+bid); out.print(pname == null); out.print(pname == "");
if( pname != null ||pname != "" ){
	String sql3 = "INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES (?, ? ,? ,? , ?)";
	PreparedStatement pst3 = con.prepareStatement(sql3);
	pst3.setString(1, pname);
	pst3.setString(2, cid);
	pst3.setString(3, productdesc);
	pst3.setString(4, pr);
	pst3.setString(5, bid);

	out.print("@  "+pname+"  @");
	String x = "productName";
	out.print(pname == x);
	//int update3 = pst3.executeUpdate();
}
Statement stm3_2 = con.createStatement();
ResultSet rst3_2 = stm3_2.executeQuery("Select count(*) From product");
while(rst3_2.next()) out.print("<p>" +rst3_2.getInt(1)+ "</p>");


//part4: delete update
out.print("<h1>Delete & Update products</h1>");
out.print("<table> <tr> <th> search by product name </th> </tr>");
out.print("<tr><td> <input type=\"text\" name=\"productName\" size=\"50\"> </td> </tr>");
out.print("</table>");

pname = request.getParameter("productName"); 

Statement stm4 = con.createStatement();
ResultSet rst4 = stm4.executeQuery("Select * From product where productName = " + pname);
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
int pid = -1;

while(rst4.next()) {
	pid = rst4.getInt(1);
	out.print("<table> <tr> <td>" +rst4.getInt(1)+ " </td>  <td>" +rst4.getString(2)+ " </td>  <td>" +currFormat.format(rst4.getDouble(3))+ " </td>");
	out.print("<td>" +rst4.getString(6)+ " </td> <td>" +rst4.getInt(7)+ " </td> <td>" +rst4.getInt(8)+ " </td>  </tr></table>");
}

String sql5 = "Delete From product Where productId = ?";
PreparedStatement stm5 = con.prepareStatement(sql5);
stm5.setInt(1,pid);
int delete = stm5.executeUpdate();

//part1: sales report
Statement stm = con.createStatement();
String sql = "SELECT orderDate, totalAmount FROM ordersummary ORDER BY orderDate ;";
ResultSet rst = stm.executeQuery(sql);


	out.print("<h1>Administrator Sales Report by Day</h1>");
	out.print("<table>");
	out.print("<tr>  <th>Order Date</th> <th>Total Order Amount</th>  </tr>");

	while(rst.next()){
		out.print("<tr> <td>"+rst.getDate(1)+"</td> <td>" +currFormat.format(rst.getDouble(2))+"</td></tr>");
	}
	
	out.print("</table>");
	
//part2: list customers
	Statement stm2 = con.createStatement();
	String sql2 = "SELECT * FROM customer ORDER BY customerId ;";
	ResultSet rst2 = stm2.executeQuery(sql2);
	
	out.print("<h1>Customer List</h1>");
	out.print("<table>");
	out.print("<tr>  <th>customerId</th> <th>firstName</th> <th>lastName</th> <th>email</th> <th>phonenum</th>");
	out.print("<th>address</th> <th>city</th> <th>state</th> <th>postalCode</th> <th>country</th> <th>userid</th> <th>password</th>  </tr>");

	while(rst2.next()){
		out.print("<tr> <td>"+rst2.getInt(1)+"</td> <td>" +rst2.getString(2)+"</td>  <td>" +rst2.getString(3)+"</td> <td>" +rst2.getString(4)+"</td> <td>" +rst2.getString(5)+"</td>");
		out.print("<td>" +rst2.getString(6)+"</td> <td>" +rst2.getString(7)+"</td> <td>" +rst2.getString(8)+"</td> <td>" +rst2.getString(9)+"</td> <td>" +rst2.getString(10)+"</td>");
		out.print("<td>" +rst2.getString(11)+"</td> <td>" +rst2.getString(12)+"</td></tr>");
	}
	
	out.print("</table>");
	
//part5: list order
	out.print("<h1>List All Order</h1>");
	out.print("<h2> <a href=\"listorder.jsp\"> Order List </a> </h2>");
	
closeConnection();
%>

</body>
</html>

