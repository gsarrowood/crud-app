<%-- 
    Document   : edit
    Created on : Apr 22, 2011, 3:04:46 PM
    Author     : FMilens
--%>

<%@taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Client</title>
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    </head>
    <body>
        <h1>Edit Client</h1>
		
		<br/>
		<p><a href="${pageContext.request.contextPath}/">Home</a>

        <c:if test="${fn:length(errors) gt 0}">
            <p>Please correct the following errors in your submission:</p>
            <ul>
                <c:forEach items="${errors}" var="error">
                    <li>${error}</li>
                </c:forEach>
            </ul>
        </c:if>
        <form action="${pageContext.request.contextPath}/client/edit" method="POST">
            <input type="hidden" name="clientId" value="${client.clientId}"/>
            <br/>
			<div id="err_div" style="padding-left:50px; margin-left: 50px"></div>
			<table>
				<tr>
					<th style="text-align:right">Client Name</th>
					<td><input type="text" id="name" name="name" value="${client.name}"/></td>
				</tr>
				<tr>
					<th style="text-align:right">Website</th>
					<td><input type="text" id="web" name="web" value="${client.web}"/></td>
				</tr>
				<tr>
					<th style="text-align:right">Street Address</th>
					<td><input type="text" id="addr" name="addr" value="${client.addr}"/></td>
				</tr>
				<tr>
					<th style="text-align:right">City</th>
					<td><input type="text" id="city" name="city" value="${client.city}"/></td>
				</tr>
				<tr>
					<th style="text-align:right">State</th>
					<td><input type="text" id="state" name="state" value="${client.state}"/></td>
				</tr>
				<tr>
					<th style="text-align:right">Zip Code</th>
					<td><input type="text" id="zipCode" name="zipCode" value="${client.zipCode}"/></td>
				</tr>
			</table>
        <br/>
        <input type="submit" name="Submit" value="Submit"/>

	<br/>
	<br/>
	
        <c:choose>
			<c:when test="${fn:length(personListForClient) gt 0}">
				<h3>Talent currently assigned to ${client.name}</h3>
				<table STYLE="border: solid black; ">
					<thead>
						<tr style="border: solid black; background-color: aliceblue">
							<th>Talent</th>
							<th>Email</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${personListForClient}" var="item">
							<tr style="border: solid black;">
								<td>${item.firstName} ${item.lastName}</td>
								<td>${item.emailAddress}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:when>
			<c:otherwise>
				<p>No Talent currently assigned to ${client.name}</p>
			</c:otherwise>
		</c:choose>
				
		<br/>
		<br/>
		<a href="${pageContext.request.contextPath}/client/multiAssignPersons/${client.clientId}">Change Talent Assignments</a>
    </form>
		<script>
		$( "form" ).submit(function( event ) {
			$("#err_div").text("");

			var input=$("#name").val();
			if( !input)
				$("#err_div").append("Error: Client Name Required<br/>");
			else if( input.length > 50)	
				$("#err_div").append("Error: Client Name too long. 50 Max.<br/>");

			var input=$("#web").val();
			if( !input)
				$("#err_div").append("Error: Web URL Required<br/>");
			else if( input.length > 50)	
				$("#err_div").append("Error: Web URL too long. 50 Max.<br/>");

			var input=$("#addr").val();
			if( !input)
				$("#err_div").append("Error: Street Address Required<br/>");
			else if( input.length > 50)	
				$("#err_div").append("Error: Street Address too long. 50 Max.<br/>");

			var input=$("#city").val();
			if( !input)
				$("#err_div").append("Error: City Required<br/>");
			else if( input.length > 50)	
				$("#err_div").append("Error: City too long. 50 Max.<br/>");

			var input=$("#state").val();
			//alert("field.val() = " + input);
			if( !input)
				$("#err_div").append("Error: State Required<br/>");
			else if( input.length != 2)	
				$("#err_div").append("Error: State must be a length of 2.<br/>");

			var input=$("#zipCode").val();
			if( !input)
				$("#err_div").append("Error: Zip Code Required<br/>");
			else if( input.length != 5)	
				$("#err_div").append("Error: Zip Code must be a length of 5<br/>");

			var err=$("#err_div").text();
			//alert( "err_div is ["+err+"]");
			if( err)
				{
				$("#err_div").append("<br/>Please correct the errors above and re-submit.<br/><br/>");
				event.preventDefault();
				}
			return;
			});
			//$("#err_div").text("-No Errors-");
		</script>
	
    </body>
</html>
