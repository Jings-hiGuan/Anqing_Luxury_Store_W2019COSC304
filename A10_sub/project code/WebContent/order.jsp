<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
</head>
<body>



<% 
// Get customer id
String custId = request.getParameter("customerId");
String payT = request.getParameter("paymentType");
String cardno = request.getParameter("paymentNumber");
String expireD = request.getParameter("paymentExpiryDate");
String shiptoAddress = request.getParameter("shiptoAddress");
String shiptoCity = request.getParameter("shiptoCity");
String shiptoState = request.getParameter("shiptoState");
String postalCode = request.getParameter("shiptoPostalCode");
String shiptoCountry = request.getParameter("shiptoCountry");


@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

	//TODO:

// Make connection
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_llin;";
String uid = "llin";
String pw = "24603458";
try(Connection con = DriverManager.getConnection(url,uid,pw);
		Statement stm = con.createStatement();){
	

//#0:check cid validity & cart	
	//part1: check cid
	// Determine if valid customer id was entered
	//reEnter: checkout.jsp
	boolean reEnter = false;
	//part1-1
	if(custId == ""){												//check "" /condition
		out.println("<h1>Please enter your customerId. Try again!</h1>");
		reEnter = true;
	}
	else{
	//part1-2: check if input == digit
		try	{int cid =Integer.parseInt(custId);								//check not int /conditions
		}catch (Exception e){
			out.println("<h1>Invalid customerId. Try again!</h1>");	
			reEnter = true;
		}	
	//part1-3: is it in db?
		if(reEnter == false){
			Statement stm0 = con.createStatement();
			ResultSet rst0 = stm0.executeQuery("SELECT count(customerId) FROM customer WHERE customerId = " + custId);
			rst0.next();
			if(rst0.getInt(1)==0){
				out.println("<h1>Welcome to \"this store\"! Please set up an account before checking out.</h1>");
				reEnter = true;
//				out.println("<a href = \"checkout.jsp\"> Click here to set up</a>");
//				String insert0_setCust = "INSERT INTO ";
	//			Statement stm0_setCust = con.createStatement();
		//		ResultSet rst0_setCust;
				
			}
		}
	}

if(reEnter == true)	{
	request.setAttribute("customerId", null);
	out.println("<a href = \"checkout.jsp\"> Click here </a>");
}else if(reEnter == false){
//#1:ordersummay: update only once (per customer/per order)
	// Save order information to database
	String sql = "INSERT INTO ordersummary (customerId, orderDate) values (?,?) ;";
	
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);	
	pstmt.setString(1, custId);
	pstmt.setString(2, (new java.util.Date().toLocaleString())); //new java.util.Date()- setDate
	
	out.println(new java.util.Date());
	//how do i get the totalAmout: do it in #step3
	//pstmt.setDouble(3, x);
	
	int insert = pstmt.executeUpdate();
	//get orderId
	ResultSet rst_keys = pstmt.getGeneratedKeys();
	rst_keys.next();
	int orderId = rst_keys.getInt(1); 
	
//#0:check cid validity & cart	
	//part2: check cart != empty
	// Determine if there are products in the shopping cart
		
	if(productList == null|| productList.size() ==0)
		out.println("Empty cart. Cannot check out.");
			
			/*String sql0 = "SELECT count(*) FROM incart WHERE orderId = ?";
			PreparedStatement pstmt0 = con.prepareStatement(sql0);
			pstmt0.setInt(1,orderId);
			
			ResultSet rst0 = pstmt0.executeQuery();
			rst0.next();
			out.println("@"+rst0.getInt(1)+"@");
			//rst0.getInt(1): number of products in the cart (of an specific order)
			if(rst0.getInt(1) == 0){
				out.println("Empty cart. Cannot check out.");
				String sql0_2 = "DELETE FROM ordersummary WHERE orderId = ?";
				PreparedStatement pstmt0_2 = con.prepareStatement(sql0_2);
				pstmt0_2.setInt(1,orderId);
				
				int delete0 = pstmt0_2.executeUpdate();
			}*/

//#2:orderproduct: update more than once (per customer/per order): loop
	// Insert each item into OrderProduct table using OrderId from previous INSERT	
		//
	
	// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-price, 3-quantity
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	
	double totalA = 0;
	//double subtotal = 0;
	out.print("@@@@1");
	while (iterator.hasNext()){ 	
		String sql2 = "INSERT INTO orderproduct (orderId, productId, quantity, price) values (?, ?, ?, ?) ;"; //orderId, 0, 2, 3
		PreparedStatement pstmt2 = con.prepareStatement(sql2);	
		pstmt2.setInt(1, orderId);
		
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
 		double pr = Double.parseDouble(price);	
 		Object getQty = product.get(3);
 		int qty = Integer.parseInt(getQty.toString());
		
		totalA += pr*qty;
		
		pstmt2.setString(2,productId);
		pstmt2.setInt(3,qty);
		pstmt2.setDouble(4,pr);
		int insert2 = pstmt2.executeUpdate();
	}
	
	//the above is update, 
	//if i want: productID, quantity, price (print #step4) do another query
	//or print before the while loop renews the values of id, ..., price
	
	
//#3:ordersummary: update only once (per customer/per order)	
	// Update total amount for order record
	out.print("@@@@2");
	String sql3 = "UPDATE ordersummary SET totalAmount = ?,"
	+"shiptoAddress=?, shiptoCity=?, shiptoState=?, shiptoPostalCode=?, shiptoCountry=? "
	+" WHERE orderId =?;";
	PreparedStatement pstmt3 = con.prepareStatement(sql3);	
	pstmt3.setDouble(1, totalA);
		
	pstmt3.setString(2, shiptoAddress);
	pstmt3.setString(3, shiptoCity);
	pstmt3.setString(4, shiptoState);
	pstmt3.setString(5, postalCode);
	pstmt3.setString(6, shiptoCountry);
	pstmt3.setInt(7, orderId);
	
	int update = pstmt3.executeUpdate();
	//update payment table
	String sql3_2 = "UPDATE paymentmethod SET paymentType = ?, paymentNumber =? where customerId = ?;";
	PreparedStatement pstmt3_2 = con.prepareStatement(sql3_2);	
	pstmt3_2.setString(1, payT);
	pstmt3_2.setString(2, cardno);
	//pstmt3_2.setString(3, expireD);
	pstmt3_2.setString(3, shiptoState);
	int update2 = pstmt3_2.executeUpdate();
	
//#4:Print out order summary: show the order summary page: productID, productName, quantity, price, subtotal, order total
	out.print("@@@@3");
	out.println("<h1>Your Order Summary</h1>");
	out.println("<table> <tr> <th>Product Id</th> <th>Product Name</th> <th>Quantity</th> <th>Price</th>  <th>Subtotal</th> </tr>");
	
	//String sql4 = "SELECT orderId FROM ordersummary WHEREcustomerId =" + custId; //[wrong]: there are multiple orderId with the same customerId (a person can place >1 orders)
	String sql4 = "SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?";
	PreparedStatement pstmt4 = con.prepareStatement(sql4);
	pstmt4.setInt(1, orderId);
	ResultSet rst4 = pstmt4.executeQuery();

	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	//int pid;
	//int quantity;
	//double prc;
	//double subtotal;
	
	while(rst4.next()){
		int pid = rst4.getInt(1);
		int quantity = rst4.getInt(2);
		double prc = rst4.getDouble(3);
		double subtotal = quantity * prc;
		
		String sql5 = "SELECT productName FROM product WHERE productId = ? ;";
		PreparedStatement pstmt5 = con.prepareStatement(sql5);	
		pstmt5.setInt(1, pid);
		ResultSet rst5 = pstmt5.executeQuery();
		
		rst5.next();
		out.println("<tr> <td>"+ pid +"</td>  <td>"+ rst5.getString(1) +"</td>  <td>"+ quantity +"</td>  <td>"+ currFormat.format(prc) +"</td>  <td>"+ currFormat.format(subtotal) +"</td> </tr>");
		
	}
	out.println("<tr> <th></th> <th></th> <th></th><th>Order Total</th> <td>"+ currFormat.format(totalA)+" </td></tr>");
	out.println(" </table>");
	out.println("<h1>Order completed!</h1>");

//#5:Clear cart if order placed successfully
	//delete rows with orderId= xx in "incart" table
	//because "incart" table is not stored in the db. Use HashMap (hashMap is the cart!)
	
		/*String sql6 ="DELETE FROM incart WHERE orderId = ?";
		PreparedStatement pstmt6 = con.prepareStatement(sql6);	
		pstmt6.setInt(1, orderId);
		int delete = pstmt6.executeUpdate();*/
		
	session.setAttribute("productList", null);
		
}//this bracket is for if-else(reEnter)

//#6: try-catch closes the connection for me
}catch (SQLException ex) { out.println(ex); }



%>
</BODY>
</HTML>

