<%@ page import="java.sql.*" %>


<%
	if (request.getParameter("del_rno") != null)
	{
		try
		{
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "abc123");
			String sql = "delete from stu_info where rno=?";
			PreparedStatement pst = con.prepareStatement(sql);
			int r = Integer.parseInt(request.getParameter("del_rno"));
			pst.setInt(1, r);
			pst.executeUpdate();
		}

		catch (SQLException e)
		{
			out.println("Issue " + e);
		}
	}

	if (request.getParameter("send_mail") != null)
	{
		try
		{
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "abc123");
			String sql = "select * from stu_info where rno=?";
			PreparedStatement pst = con.prepareStatement(sql);
			int r = Integer.parseInt(request.getParameter("send_mail"));
			pst.setInt(1, r);
			ResultSet rs = pst.executeQuery();

			if(rs.next())
			{
				int rno = rs.getInt(1);
				String name = rs.getString(2);
				int maths = rs.getInt(3);
				int physics = rs.getInt(4);
				int chemistry = rs.getInt(5);
				float percent = ((maths+physics+chemistry)*100) / 300;

				request.getSession().setAttribute("rno", rno);
				request.getSession().setAttribute("name", name);
				request.getSession().setAttribute("maths", maths);
				request.getSession().setAttribute("physics", physics);
				request.getSession().setAttribute("chemistry", chemistry);
				request.getSession().setAttribute("percent", percent);

				response.sendRedirect("sendmail.jsp");
			}
		}

		catch (SQLException e)
		{
			out.println("Issue " + e);
		}
	}
%>

<html>
<head>
	<title> Student CRUD </title>

	<style>
		* { font-size:24px; }
		.btn { width:18%; color:white; background-color:blue; }
		table { width:50% }

		
		body{
    			background-image: url("./images/bg1.jpg");
		}
	</style>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF" crossorigin="anonymous">	
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<link rel=stylesheet" href="//cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
	<script src="//cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
	<script>
		$(document).ready( function () {
    			$('#myTable').DataTable();
		} );
	</script>

</head>

<body>
<center>

	<%
		if (session.getAttribute("user") == null)			// we have written this code so that if the user types "http://127.0.0.1:8080/pr12_auth_app/main.jsp"
		{								// he won't be able to directly access the main.jsp without logging in
			response.sendRedirect("index.jsp");
		}
		else
		{
	%>	
			<div style="background-color:#4DD0E1; height:100px"><h1> Welcome <%= session.getAttribute("user") %> </h1></div>
			<br><br>
			<form method="POST">
				<button type="submit" class="btn btn-primary" name="b1" class="btn" style="margin-right: 90px;">Logout</button>
				<button type="submit" class="btn btn-primary" name="b2" class="btn">Add Student</button>
			</form>

	<%
				if (request.getParameter("b1") != null)
				{
					session.invalidate();
					response.sendRedirect("index.jsp");
				}

				if (request.getParameter("b2") != null)
				{
					response.sendRedirect("add.jsp");
				}
		}
	%>


	<br><br>
	
	<table id="myTable" class="table" style="width:1300px;">
	<tr>
		<th> Rno </th>
		<th> Name </th>
		<th> Marks in Maths </th>
		<th> Marks in Physics </th>
		<th> Marks in Chemistry </th>
		<th> Percentage </th>
	</tr>

	<%
		try
		{
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL", "system", "abc123");
			String sql = "select * from stu_info";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next())
			{
				int rno = rs.getInt(1);
				String name = rs.getString(2);
				int maths = rs.getInt(3);
				int physics = rs.getInt(4);
				int chemistry = rs.getInt(5);
				float percent = ((maths+physics+chemistry)*100) / 300;
	%>

			<tr align="center">
				<td><%= rno %></td>
				<td><%= name %></td>
				<td><%= maths %></td>
				<td><%= physics %></td>
				<td><%= chemistry %></td>
				<td><%= percent %></td>
				<td><a href="?del_rno=<%= rno %>" onclick="return confirm('Are you sure??')"> Delete </a></td>
				<td><a href="?send_mail=<%= rno %>"> Send Result </a></td>
			</tr>

	<%	
			}
		}
		catch(SQLException e)
		{
			out.println("issue " + e);
		}
	%>
	</table>

</center>
</body>
</html>