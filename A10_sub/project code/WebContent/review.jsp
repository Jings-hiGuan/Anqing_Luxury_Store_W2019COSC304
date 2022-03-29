
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<style type="text/css">
		table.table1{
		border-collapse: collapse;
	 	 border: 1px solid black;
		}
		th{
		  width: 100%;
		}
		td{
		text-align: center;
		}
	</style>
	<title>Insert title here</title>
</head>
<body>


<%
//display from db the old reviews

//part1: display old reviews
	getConnection();
	String sql = "SELECT * FROM review";
	Statement stm = con.createStatement();
	ResultSet rst = stm.executeQuery(sql);
	
	//1, 2, 3, 4, 6
	out.print("<table class=\"table1\"> <tr><th>reviewId</th>  <th>reviewRating</th>  <th>reviewDate</th>  <th>customerId</th> <th>productId</th> <th>reviewComment</th> </tr>");
	while(rst.next()){
		out.print("<tr> <td>"+rst.getInt(1)+"</td>  <td>"+rst.getInt(2)+"</td>  <td>"+rst.getDate(3)+"</td>  <td>"+rst.getInt(4)+"</td>  <td>"+rst.getInt(5)+"</td>");
		out.print("  <td> <table> "+rst.getString(6)+" </table> </td></tr>");
	}
	out.print("</table>");
	
	closeConnection();
%>
</body>
</html>