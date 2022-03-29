<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
</head>
<body>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Please register</h3>

<%
// Print prior error reg message if present
if (session.getAttribute("rgMessage") != null)
	out.println("<p>"+session.getAttribute("rgMessage").toString()+"</p>");
%>

<br>
<form name="MyForm" method=post action="rgValidation.jsp">
<table style="display:inline">

<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
	<td><input type="text" name="fName"  size=50 maxlength=50></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
	<td><input type="text" name="lName"  size=50 maxlength=50></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
	<td><input type="text" name="email"  size=50 maxlength=50></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone Number:</font></div></td>
	<td><input type="text" name="phone"  size=50 maxlength=50></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
	<td><input type="text" name="address"  size=50 maxlength=50></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
	<td><input type="text" name="city"  size=50 maxlength=50></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">State:</font></div></td>
	<td><input type="text" name="state"  size=50 maxlength=50></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code:</font></div></td>
	<td><input type="text" name="postalCode"  size=50 maxlength=50></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
	<td><input type="text" name="country"  size=50 maxlength=50></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Fucking UserId:</font></div></td>
	<td><input type="text" name="uId"  size=50 maxlength=50></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">fucking Password:</font></div></td>
	<td><input type="password" name="password" size=50 maxlength="50"></td>
</tr>
</table>
		
			<br/>
			<input class="submit" type="submit" name="Submit2" value="Register">
		
</form>
</body>
</html>