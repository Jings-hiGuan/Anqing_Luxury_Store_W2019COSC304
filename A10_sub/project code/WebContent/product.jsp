<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<html>
<head>
<title>Ray's Grocery - Product Information</title>

<style>
table,th, td{
  border: 1px solid black;
  border-collapse: collapse;
  width: 100%;
  height: 50px;
}
th, td {
  padding: 15px;
  text-align: left;
}
</style>

<link href="css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<%@ include file="header.jsp" %>

<%
getConnection();
// Get product name to search for
// TODO: Retrieve and display info for the product
 String productId = request.getParameter("id");
		
//productId, productName, productPrice, productImageURL, productImage, productDesc, categoryId
String sql = "SELECT * FROM product WHERE productId = ?;";
PreparedStatement pst = con.prepareStatement(sql);
pst.setString(1, productId);
ResultSet rst = pst.executeQuery();

//print
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

while(rst.next()){
	String pN = rst.getString("productName");
	double prc = rst.getDouble("productPrice");
	
	out.print("<h1>"+ pN +"</h1>");
	
	// TODO: If there is a productImageURL, display using IMG tag
	if(rst.getString("productImageURL")!= null)//.jpg
		out.print("<img src = \"   "+ rst.getString("productImageURL")+"   \"  width = \"500\"    height = \"333\" >");
	// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
	if(rst.getString("productImage")!= null)
		out.print("<img src=\"displayImage.jsp?id="+ productId +"\">");
	
	out.print("<table>");
	out.print("<tr> <th>Id</th>  <td>"+ productId +"</td> </tr> ");
	out.print("<tr> <th>Price</th>  <td>"+ currFormat.format(prc) +"</td> </tr>");
	
	out.print("</table>");

	//TODO: Add links to Add to Cart and Continue Shopping	
	out.print("<h2><a href=\""+"addcart.jsp?id=" + productId +"&name=" +pN+"&price="+prc+"\">Add to Cart</a></h2>"); 
	out.print("<h2><a href=\"listprod.jsp\">Continue Shopping</a></h2>");
	
}//else{ out.print("something is wrong with the query");

%>

	<form method="get" action="product.jsp">
		<% out.print("<input type=\"hidden\" name=\"id\" value="+productId +" >"); %>
		<input type="text" name="Rating" size="15" value="Rating: 1-5">
		<input type="text" name="reviewComment" size="50" value="Comment">
		<input type="text" name="customerId" size="15" value="customerId">
		<input type="submit" value="Submit"><input type="reset" value="Reset">
	</form>


<%
//display from db the old reviews && store new reviews into db
	String rating = request.getParameter("Rating");
	String customerId = request.getParameter("customerId");
	//String productId = request.getParameter("productId");
	String comment = request.getParameter("reviewComment");
	
//part2: store new reviews into db
		if(rating!= null ){
			String insertS3 = "Insert into review (reviewRating,reviewDate,customerId,productId,reviewComment) values( ?, ?, ?, ?, ?)";
			PreparedStatement pst3 = con.prepareStatement(insertS3, Statement.RETURN_GENERATED_KEYS);
			pst3.setString(1, rating);
			pst3.setString(2, (new java.util.Date().toLocaleString()));
			pst3.setString(3, customerId);
			pst3.setString(4, productId);
			pst3.setString(5, comment);
			int r = pst3.executeUpdate();
			session.setAttribute("Rating", null);
			session.setAttribute("customerId", null);
			session.setAttribute("reviewComment", null);
		}

//part1: display old reviews
	getConnection();
	String sql2 = "SELECT * FROM review WHERE productId = ?";
	PreparedStatement pst2 = con.prepareStatement(sql2);
	pst2.setString(1, productId);
	ResultSet rst2 = pst2.executeQuery();
	
	//1, 2, 3, 4, 6
	out.print("<table class=\"table1\"> <tr><th>reviewId</th>  <th>reviewRating</th>  <th>reviewDate</th>  <th>customerId</th>  <th>reviewComment</th> </tr>");
	while(rst2.next()){
		out.print("@test 1 @");
		out.print("<tr> <td>"+rst2.getInt(1)+"</td>  <td>"+rst2.getInt(2)+"</td>  <td>"+rst2.getDate(3)+"</td>  <td>"+rst2.getInt(4)+"</td> ");
		out.print("  <td> "+rst2.getString(6)+" </td> </tr>");
	}
	out.print("@test 2 @");
	out.print("@  " + rating +"  @");
	out.print("<tr></tr>");
	out.print("<tr></tr>");
	out.print("</table>");
	
	//out.print(r);
	
	
	closeConnection();
%>

</body>
</html>

