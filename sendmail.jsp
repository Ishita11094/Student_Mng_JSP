<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>

<html>
<head>
	<title> Stu_mng </title>
	<style>
		*{ font-size:30px; font-family:Calibri; }

		body{
    			background-image: url("./images/bg1.jpg");
		}
	</style>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF" crossorigin="anonymous">	
</head>

<body>
<center>
	<form>
  		<div class="mb-3">
    			<div style="background-color:#4DD0E1; height:100px"> <label for="exampleInputEmail1" class="form-label" style="font-size:60px">Send Result</label> </div>
			<br>
    			<input type="email" class="form-control" id="em" name="em" aria-describedby="emailHelp" style="width:450px;" required>
    			<div id="emailHelp" class="form-text">Enter students's email address to send him/her the result</div>
  		</div>
  		<button type="submit" class="btn btn-primary" name="b1" class="btn">Send</button>
	</form>
	<a href="view.jsp"><button type="submit" class="btn btn-primary" name="b1">Back</button></a>

	<%
		if (request.getParameter("b1") != null)
		{
			String email = request.getParameter("em");

			try
			{
				// setting up the server. setting the properties
				Properties p = System.getProperties();
				p.put("mail.smtp.host", "smtp.gmail.com");
				p.put("mail.smtp.port", "587");
				p.put("mail.smtp.auth", "true");
				p.put("mail.smtp.starttls.enable", true);

				// connecting to gmail server
				Session ms = Session.getInstance(p, new Authenticator() 
				{
					public PasswordAuthentication getPasswordAuthentication() 
					{		
						return new PasswordAuthentication("ishita.sharma.11094@gmail.com", "IshitaAnvita");
					}
				});

				// sending msg
				try
				{
					MimeMessage msg = new MimeMessage(ms);
					msg.setSubject("Message from Teacher");
					msg.setText(
						"Hello " + session.getAttribute("name") + "\n" +
						"Your roll no is = " + session.getAttribute("rno") + "\n" + 
						"Maths = " + session.getAttribute("maths") + "\n" + 
						"Physics = " + session.getAttribute("physics") + "\n" +
						"Chemistry = " + session.getAttribute("chemistry") + "\n" +
						"Your percent is = " + session.getAttribute("percent"));	
					msg.addRecipient(Message.RecipientType.TO, new InternetAddress(request.getParameter("em")));
					Transport.send(msg);
	%>
					<script>
					alert("Mail sent successfully!!");
					</script>
	<%
				}
				
				catch (Exception e)
				{
					out.println("issue " + e);
					e.printStackTrace();
				}

			}
		
			catch (Exception e)
			{
				out.println("Error");
			}

		}
	%>
</center>
</body>

</html>