<%@ page import="java.sql.*" %>

<html>
<head>
	<title> Auth App </title>
	<style> 
		*{ font-size:24px; }
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
	<div style="background-color:#F0B27A; height:100px"><h1> Login page </h1></div>
	<br>
	<div>
	<form method="POST">
  		<div class="mb-3">
    			<label for="usrnm" class="form-label">Enter Username</label>
    			<input type="text" class="form-control" id="un" name="un" aria-describedby="emailHelp" style="width:300px;" required>
  		</div>
  		<div class="mb-3">
    			<label for="passwrd" class="form-label">Password</label>
    			<input type="password" class="form-control" id="pw" name="pw" style="width:300px;" required>
  		</div>
  		<button type="submit" class="btn btn-primary" value="Login" name="b1" style="width:10%;">Login</button>
	</form>
	</div>
		
	<form>
		<input class="btn btn-primary" type="submit" value="SignUp" name="b2" class="btn">		<!--- if we type this in previous form, then due to required it asks for name and password --->
	</form> 

	<%
		if (request.getParameter("b2") != null)
		{
			response.sendRedirect("signup.jsp");			// redirecting to signup.jsp
		}

		if (request.getParameter("b1") != null)
		{
			String un = request.getParameter("un");
			String pw = request.getParameter("pw");

			try
			{
				DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
				Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "abc123");
				String sql = "select * from tr_info where username=?";
				PreparedStatement pst = con.prepareStatement(sql);
				pst.setString(1, un);
				ResultSet rs = pst.executeQuery();
				if(rs.next())					// if some user with username found
				{
					String p = rs.getString(2);		// retreiving his registered password
					if(p.equals(pw))			// if registered password (p) matches entered password (pw)
					{
						request.getSession().setAttribute("user", un);			// creating session for that user. logging in
						response.sendRedirect("view.jsp");
					}
					else
					{
						out.println("Incorrect password");
					}
				}

				else
				{
					out.println("Username does not exists");
				}
			}

			catch(SQLException e)
			{
				out.println("Issue " + e);
			}
		}
	%>
</center>
</body>
</html>