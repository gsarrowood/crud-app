
<%@taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 		<meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home</title>
	</head>
	<body>
		<H1>Home Page</H1>
		<ul>
			<li><a href="${pageContext.request.contextPath}/client/list">Work with clients</a></li>
			<li><a href="${pageContext.request.contextPath}/person/list">Work with talent</a></li>
		</ul>
	</body>
</html>

