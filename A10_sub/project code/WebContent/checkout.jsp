<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Ray's Grocery CheckOut Line</title>
</head>
<body>

<h1>Enter your customer id to complete the transaction:</h1>

<form method="get" action="order.jsp">

<table>
	<tr><th>costomerId</th> <td><input type="text" name="customerId" size="50" ></td></tr>
	<tr><th>costomerId</th> <td> 
		 <select size="15" name="paymentType ">
		  <option></option>
		  <option>Credit/Debit</option>
		  </select>
	</td></tr>
	  
	<tr><th>paymentNumber</th> <td><input type="text" name="paymentNumber" size="50"> </td></tr>
	<tr><th>paymentExpiryDate</th> <td><input type="text" name="paymentExpiryDate" size="50"></td></tr>
	
	<tr><th>shiptoAddress</th> <td><input type="text" name="shiptoAddress" size="50"></td></tr>
	<tr><th>shiptoCity</th> <td><input type="text" name="shiptoCity" size="50"></td></tr>
	<tr><th>shiptoState</th> <td><input type="text" name="shiptoState" size="50"></td></tr>
	<tr><th>shiptoPostalCode</th> <td><input type="text" name="shiptoPostalCode" size="50"></td></tr>
	<tr><th>shiptoCountry</th> <td><input type="text" name="shiptoCountry" size="50"></td></tr>

</table>
<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>



</body>
</html>

