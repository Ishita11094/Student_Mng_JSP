<%@ page import="java.sql.*" %>

<html>
<head>
	<title> Student CRUD </title>

	<style>
		* { font-size:25px; }
		.btn { width:10%; }

		body{
    			background-image: url("./images/bg1.jpg");
		}
	</style>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF" crossorigin="anonymous">

</head>

<body>
<center>
	<div style="background-color:#4DD0E1; height:100px"><h1> Add Student Page </h1></div>
	<br>
	<a href="view.jsp"><button type="submit" class="btn btn-primary" name="b1">Back</button></a>
	<br><br>


	<form>
 		<div class="mb-3">
    			<label for="roll" class="form-label">Enter Roll no</label>
    			<input type="number" class="form-control" id="r" name="r" aria-describedby="emailHelp" style="width:350px;" required>
  		</div>
		<div class="mb-3">
    			<label for="name" class="form-label">Enter Name</label>
    			<input type="text" class="form-control" id="n" name="n" aria-describedby="emailHelp" style="width:350px;" required>
  		</div>
		<div class="mb-3">
    			<label for="m" class="form-label">Enter marks in maths</label>
    			<input type="number" class="form-control" id="maths" name="maths" aria-describedby="emailHelp" style="width:350px;" required>
  		</div>
		<div class="mb-3">
    			<label for="p" class="form-label">Enter marks in physics</label>
    			<input type="number" class="form-control" id="physics" name="physics" aria-describedby="emailHelp" style="width:350px;" required>
  		</div>
		<div class="mb-3">
    			<label for="c" class="form-label">Enter marks in chemistry</label>
    			<input type="number" class="form-control" id="chem" name="chem" aria-describedby="emailHelp" style="width:350px;" required>
  		</div>
		<br>
  		<button type="submit" class="btn btn-primary" name="b1" onclick="return alert('Record Added')">Submit</button>
	</form>

	<%
		if (request.getParameter("b1") != null)
		{
			int rno = Integer.parseInt(request.getParameter("r"));
			String name = request.getParameter("n");
			int m = Integer.parseInt(request.getParameter("maths"));
			int p = Integer.parseInt(request.getParameter("physics"));
			int c = Integer.parseInt(request.getParameter("chem"));

			try
			{
				DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
				Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "abc123");
				String sql = "insert into stu_info values(?,?,?,?,?)";
				PreparedStatement pst = con.prepareStatement(sql);
				pst.setInt(1, rno);
				pst.setString(2, name);
				pst.setInt(3, m);
				pst.setInt(4, p);
				pst.setInt(5, c);
				pst.executeUpdate();
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