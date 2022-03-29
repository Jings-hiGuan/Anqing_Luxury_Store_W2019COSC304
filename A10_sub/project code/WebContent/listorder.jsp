<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<style>
body{
 background-color:#FFA07A;
}
table{
 border-collapse: collapse;
 width: 40%;

}
th {
  height: 50px;
  text-align: right;
   border-bottom: 1px solid #ddd;
}
td {
    text-align: right;
    border-bottom: 1px solid #ddd;
    
}
h1{
	font-family: 'Dekko';font-size: 22px;
	color: white;
}

</style>
<title>YOUR NAME Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_llin;";
String uid = "llin";
String pw = "24603458";
try(Connection con = DriverManager.getConnection(url,uid,pw);
		Statement stm = con.createStatement();){

// Write query to retrieve all order summary records
	ResultSet rst = stm.executeQuery("SELECT * FROM ordersummary ORDER BY orderDate desc;");
// For each order in the ResultSet

	// Print out the order summary information 
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 
		
	out.println("<table ><tr>  <th>orderId</th> <th>orderDate</th> <th>customerId</th> <th>totalAmount</th>  </tr>");//orderSummary  //customer Name
	while(rst.next()){
		int orid = rst.getInt("orderId");
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		//part0: outer table
		out.println("<tr> <td>"+ orid +"</td> <td>"+ rst.getDate("orderDate") +"</td> <td>"+ rst.getInt("customerId") +"</td> <td></td>   </tr>");
		//part1: inner table
		String sql = "SELECT * FROM orderproduct WHERE orderId = ?;";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, orid);
		ResultSet rst2 = pst.executeQuery();
		out.println("<td></td>  <td></td><td></td>         <td><table style = \"width:100%\" > <tr>  <th>productId</th> <th>quantity</th> <th>price</th> </tr>");//orderproduct
		while(rst2.next()){
			out.println("<tr> <td>"+ rst2.getInt("productId")+"</td> <td>"+ rst2.getInt("quantity")+"</td> <td>"+ currFormat.format(rst2.getDouble("price"))+"</td>  </tr>");
		}
		out.println("</table> </td>");
		
		//part2: outer table
		out.println("<tr> <td></td> <td></td> <td></td> <td>"+ currFormat.format(rst.getDouble("totalAmount")) +"</td>   </tr>");
		
		
		
	}
	out.println("</table>");

// Close connection
	con.close();
}catch (SQLException ex) { out.println(ex); }

%>

</body>
</html>



