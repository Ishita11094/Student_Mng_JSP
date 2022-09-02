<%@ page import="java.sql.*" %>

<html>
<head>
	<title> Auth App </title>
	<style> 
		*{ font-size:24px;}
		.btn{ width:10%; }

		body{
    			background-image: url("./images/bg2.jpg");
			background-repeat: no-repeat;
		}
	</style>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF" crossorigin="anonymous">

</head>

<body>
<center>
	<div style="background-color:#F0B27A; height:100px"><h1> Sign Up page </h1></div>
	<form method="POST">
  		<div class="mb-3">
    			<label for="usrnm" class="form-label" name="usrnm" required>Enter Username</label>
    			<input type="text" class="form-control" id="un" name="un" aria-describedby="emailHelp" style="width:300px;" required>
  		</div>
  		<div class="mb-3">
    			<label for="passwd1" class="form-label">Enter Password</label>
   			<input type="password" class="form-control" id="pw1" name="pw1" style="width:300px;" required>
  		</div>
		<div class="mb-3">
    			<label for="passwd2" class="form-label">Repeat Password</label>
   			<input type="password" class="form-control" id="pw2" name="pw2" style="width:300px;" required>
  		</div>
  		<button type="submit" class="btn btn-primary" name="b1" class="btn">Register</button>
	</form>

		

	<form>
		<button type="submit" class="btn btn-primary" name="b2" class="btn">Back</button>		<!--- if we type this in previous form, then due to required it asks for name and password --->
	</form> 

	<%
		if (request.getParameter("b2") != null)
		{
			response.sendRedirect("index.jsp");			// redirecting to index.jsp
		}

		if (request.getParameter("b1") != null)
		{
			String un = request.getParameter("un");
			String pw1 = request.getParameter("pw1");
			String pw2 = request.getParameter("pw2");

			if (pw1.equals(pw2))
			{
				try
				{
					DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
					Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "abc123");
					String sql = "insert into tr_info values(?,?)";
					PreparedStatement pst = con.prepareStatement(sql);
					pst.setString(1, un);
					pst.setString(2, pw1);
					pst.executeUpdate();
					response.sendRedirect("index.jsp");
				}
				
				catch(SQLException e)
				{
					out.println("Username already exists");
				}
			}
			
			else
			{
				out.println("Passwords didnot match");
			}

		}
	%>
</center>
</body>
</html>