<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>

<title>Reset password</title>
</head>
<body>

	<% out.print("<h1>Reset password</h1>");%>
			<form method=get action="forgetpw.jsp">
				<table> <tr><th>what is your userid</th> <td><input type="text" name="userid"  size=50  > </td> </tr>
						<tr><th>verify: enter ur address</th> <td><input type="text" name="address"  size=50  > </td> </tr>
						<tr><th>new password</th><td><input type="text" name="pw"  size=50  ></td></tr> </table>
				<input type="submit" value="Submit"><input type="reset" value="Reset">
				
			</form>
			
			
		<% 	String userid = request.getParameter("userid");
			String address = request.getParameter("address");
			String pw = request.getParameter("pw");
			
			String sql = "select count(*) From customer Where userid=? and address =?";
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setString(1, userid);
			pst.setString(2,address);
			ResultSet rst = pst.executeQuery();
			while(rst.next()){
				if(rst.getInt(1) != 0){
					String sql3 = "Update customer Set password = ? where userid = ?;";
					PreparedStatement pst3 = con.prepareStatement(sql3);
					pst3.setString(1, pw);
					pst3.setString(2, userid);
					int update = pst3.executeUpdate();
					out.print("sucessfully reset!");
				}else
					out.print("incorrect address. Unsucessfully reset!");
			}
%>

</body>
</html>