<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>


<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
	<style>
	body{
		background-color:#DAF7A6;
		}
	h1{
		font-family: 'Dekko';font-size: 22px;
		color: white;
	}
	table,{
	 width: 100%;
	 height: 50px;
	 align: "center";
	
	}
	</style>
</head>

<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">

 <select size="1" name="categoryName">
  <option></option>
  <option>Cars</option>
  <option>Makeup</option>
  <option>Furniture</option>
  <option>Yatch</option>
  <option>Robots</option>
  <option>Aircraft</option>
  </select>
  
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>


<% // Get product name to search for (input = name)  // Variable "name" now contains the search string the user entered
String name = request.getParameter("productName");
String categoryname = request.getParameter("categoryName");
String brdname = request.getParameter("brandName");

//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

	//TODO:
// Make the connection
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_llin;";
String uid = "llin";
String pw = "24603458";

try(Connection con = DriverManager.getConnection(url,uid,pw);
		Statement stm = con.createStatement();){
	
	
//page with all products: part1
	String sql0 = "SELECT productId,productName,productPrice, categoryId, brandId FROM product";

	String sqlCat ="SELECT categoryName From category Where categoryId = ?";
	String sqlBrd ="SELECT brandName From brand Where brandId = ?";
	
	ResultSet rst = null;
	int categoryId = -1 ;
	
	
// Print: print all products
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		
	

	if((name == null || name == "")&& (categoryname==""||categoryname== null)){
		out.println("<h2>All products</h2>");
			sql0 += " Order by categoryId";
		rst = stm.executeQuery(sql0);
		
	}else if((name == null || name == "")&& (!(categoryname=="") || !(categoryname== null))){
		out.print("<h2>Products in category: '" + categoryname +"'</h2>"); //we have category name -> query category table to get id (categoryname is not in product table)
		
		String sql2 = "SELECT categoryId From category Where categoryName = ?";
		PreparedStatement pst2 = con.prepareStatement(sql2);
		pst2.setString(1,categoryname);
		ResultSet rst2 = pst2.executeQuery();
		while(rst2.next())
			categoryId = rst2.getInt(1);// get categoryId from categoryname 
		
		sql0 += " Where categoryId = ?;";
		PreparedStatement pst = con.prepareStatement(sql0); //"SELECT productId,productName,productPrice, categoryId, brandId FROM product Where categoryId = ?;";
		pst.setInt(1, categoryId);	
			sql0 += " Order by categoryId";
		rst = pst.executeQuery();
		
	}else if(!(name == null || name == "")&& (categoryname==""||categoryname== null)){
		out.println("<h2>Products containing '"+ name +"' </h2>");
		sql0 += " Where productName LIKE ? ;";
		
		PreparedStatement pst = con.prepareStatement(sql0);
		pst.setString(1, "%"+name+"%");
			sql0 += " Order by categoryId";
		rst = pst.executeQuery();

		
	}else if(!(name == null || name == "")&&  !(categoryname==""&&categoryname== null)){
		out.print("<h2>Products containing '"+name+"' in category: '"+categoryname+"'</h2>");
		sql0 += " Where categoryId = ? and productName LIKE ? ;"; //need to get categoryId to do query in product table
		
		String sql2 = "SELECT categoryId From category Where categoryName = ?";
		PreparedStatement pst2 = con.prepareStatement(sql2);
		pst2.setString(1,categoryname);
		ResultSet rst2 = pst2.executeQuery();
		while(rst2.next())
			categoryId = rst2.getInt(1);// get categoryId from categoryname 
			
		PreparedStatement pst = con.prepareStatement(sql0);
		pst.setInt(1, categoryId);
		pst.setString(2, "%"+name+"%");
			sql0 += " Order by categoryId";
		rst = pst.executeQuery();
	}
	
	out.println("<table><tr>  <th> </th> <th>ProductName</th> <th>Brand</th> <th>Category</th> <th>Price</th>  </tr>");
	while(rst.next()){
		
		int pid = rst.getInt(1);
		String pN = rst.getString(2);
		double prc = rst.getDouble(3);
		categoryId = rst.getInt(4); //need to fetch each time for condition1: not searching [categoryId/categoryName is different each time]
		int brandId = rst.getInt(5);
		
		PreparedStatement pst2 = con.prepareStatement(sqlCat);
		pst2.setInt(1, categoryId);
		ResultSet rst2 = pst2.executeQuery();
		
		PreparedStatement pst3 = con.prepareStatement(sqlBrd);
		pst3.setInt(1, brandId);
		ResultSet rst3 = pst3.executeQuery();
		
		while(rst2.next() && rst3.next()){
			out.print("<tr>  <td><a href=\""+"addcart.jsp?id=" + pid+"&name=" +pN+"&price="+prc+"\">Add to Cart</a></td>");
			out.print("  <td><a href =\"product.jsp?id=" + pid+ " \"> " + pN + "</a> </td>");
			out.print( "<td>" + rst3.getString(1) +"</td>");//brand name
			out.print( "<td>" + rst2.getString(1)+"</td>");//category name
			out.print("  <td>" + currFormat.format(prc) +"</td>  </tr>");
		}
		
	}
	out.println("</table>");
	request.setAttribute("categoryname", null);
	
// Close connection:try-catch
}catch (SQLException ex) { out.println(ex); }
%>

</body>
</html>

