<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp"%>
<%
	String newUser = null;
	session = request.getSession(true);

	try {
		out.print("@  0  @");
		newUser = rgValidation(out, request, session);
		out.print("@  0.1  @");
	} catch (IOException e) {
		System.err.println(e);
	}

	if (newUser != null)
		response.sendRedirect("index.jsp"); // Successful login
	else{
		out.print(newUser);
		response.sendRedirect("register.jsp"); // Failed login - redirect back to login page with a message 
	}
%>
<%!String rgValidation(JspWriter out, HttpServletRequest request, HttpSession session) throws IOException {
		String fName = request.getParameter("fName");
		String lName = request.getParameter("lName");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String postalCode = request.getParameter("postalCode");
		String country = request.getParameter("country");
		String uId = request.getParameter("uId");
		String pw = request.getParameter("password");
		int inResult = -1;

		if (fName == null || lName == null|| email == null|| phone == null|| address == null|| city == null|| state == null|| postalCode == null|| country == null|| uId == null|| pw == null){
			out.print( "@  2.1  @");
			out.print( "@  " +fName +"  @");
			out.print( "@  " +lName +"  @");
			out.print( "@  " +email +"  @");
			out.print( "@  " +phone +"  @");
			out.print( "@  " +address +"  @");
			out.print( "@  " +state +"  @");
			out.print( "@  " +postalCode +"  @");
			out.print( "@  " +country +"  @");
			out.print( "@  " +uId +"  @");
			out.print( "@  " +pw +"  @");
			
			session.setAttribute("rgMessage","plz fill in all the fields");
			return null;
		}
			
		if ((fName.length() == 0) || (lName.length() == 0)|| (email.length() == 0)|| (phone.length() == 0)|| (address.length() == 0)|| (city.length() == 0)|| (state.length() == 0)|| (postalCode.length() == 0)|| (country.length() == 0)|| (uId.length() == 0)|| (pw.length() == 0)){
			out.print( "@  3.1  @");
			
			session.setAttribute("rgMessage","plz fill in all the fields");
			return null;
		}	

		try {
			getConnection();
			String existingLog1 = "Select count(*) From customer where userid = ? ;";
			PreparedStatement pst_ex1 = con.prepareStatement(existingLog1);
			pst_ex1.setString(1, uId);
			ResultSet rst_ex1 = pst_ex1.executeQuery();
			
			String existingLog2 = "Select count(*) From customer where password = ? ;";
			PreparedStatement pst_ex2 = con.prepareStatement(existingLog2);
			pst_ex2.setString(1, pw);
			ResultSet rst_ex2 = pst_ex2.executeQuery();
			
			if(rst_ex1.next() && rst_ex1.getInt(1)!= 0){
				session.setAttribute("rgMessage","Unsuccessful registeration! Username already used! ");
				return null;
			}
			if(rst_ex2.next() && rst_ex2.getInt(1)!= 0){
				session.setAttribute("rgMessage","Unsuccessful registeration! Passward already used!");
				return null;
			}
			
			out.print("@  1  @");
			String sql = "INSERT INTO customer values(?,?,?,?,?,?,?,?,?,?,?);";
			PreparedStatement pst = con.prepareStatement(sql);
			out.print("@  2  @");
			pst.setString(1, fName);
			pst.setString(2, lName);
			pst.setString(3, email);
			pst.setString(4, phone);
			pst.setString(5, address);
			pst.setString(6, city);
			pst.setString(7, state);
			pst.setString(8, postalCode);
			pst.setString(9, country);
			pst.setString(10, uId);
			pst.setString(11, pw);
			out.print("@  3  @");
			inResult = pst.executeUpdate();
			out.print("@  4  @");
			
			
			
		} catch (SQLException ex) {
			out.println(ex);
		} finally {
			closeConnection();
		}

		//if (inResult != 0) {
		//	session.removeAttribute("rgMessage");
			
		//} else
	//		session.setAttribute("loginMessage", "Could not connect to the system using that username/password.");

		if(inResult == 1){
			session.removeAttribute("rgMessage");
			return "" +inResult;
		}
		else{
			session.setAttribute("rgMessage","Unsuccessful registeration! plz try agian");
			return null;
		}
			
	}%>