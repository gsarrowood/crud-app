<%-- 
    Document   : edit
    Created on : Apr 22, 2011, 3:04:46 PM
    Author     : FMilens
--%>

<%@taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Talent</title>
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    </head>
    <body>
        <h1>Edit Talent</h1>
		<p><a href="${pageContext.request.contextPath}/">Home</a></p>
		
        <c:if test="${fn:length(errors) gt 0}">
            <p>Please correct the following errors in your submission:</p>
            <ul>
                <c:forEach items="${errors}" var="error">
                    <li>${error}</li>
                </c:forEach>
            </ul>
        </c:if>
        <form:form action="${pageContext.request.contextPath}/person/edit" modelAttribute="person" method="POST">
            <form:input type="hidden" path="personId"/>
			<div id="err_div" style="padding-left:50px; margin-left: 50px"></div>
 			<table>
				<tr>
					<th style="text-align:right">First Name</th>
					<td><form:input type="text" id="firstName" path="firstName" /></td>
				</tr>
				<tr>
					<th style="text-align:right">Last Name</th>
					<td><form:input type="text" id="lastName"path="lastName"/></td>
				</tr>
				<tr>
					<th style="text-align:right">Email Address</th>
					<td><form:input type="text" id="emailAddress" path="emailAddress" /></td>
				</tr>
				<tr>
					<th style="text-align:right">Street Address</th>
					<td><form:input type="text" id="streetAddress" path="streetAddress"/></td>
				</tr>
				<tr>
					<th style="text-align:right">City</th>
					<td><form:input type="text" id="city" path="city" /></td>
				</tr>
				<tr>
					<th style="text-align:right">State</th>
					<td><form:input type="text" id="state" path="state" /></td>
				</tr>
				<tr>
					<th style="text-align:right">Zip Code</th>
					<td><form:input type="text" id="zipCode" path="zipCode"/></td>
				</tr>
				<tr>
					<th style="text-align:right">Client</th>
					<td>			
						<form:select path="clientId">
							<form:option value="-1" label="-- None --"/>
							<form:options items="${clientSelectList}"/>
						</form:select>
					</td>
				</tr>
			</table>
            <br/>
			<br/>
            <input type="submit" value="Submit"/>
        </form:form>
			
			<script>
			$( "form" ).submit(function( event ) {
				$("#err_div").text("");
				
				var input=$("#firstName").val();
				if( !input)
					$("#err_div").append("Error: First Name Required<br/>");
				else if( input.length > 50)	
					$("#err_div").append("Error: First Name too long. 50 Max.<br/>");
				
				var input=$("#lastName").val();
				if( !input)
					$("#err_div").append("Error: Last Name Required<br/>");
				else if( input.length > 50)	
					$("#err_div").append("Error: Last Name too long. 50 Max.<br/>");
				
				
				var input=$("#emailAddress").val();
				if( !input)
					$("#err_div").append("Error: Email Address Required<br/>");
				else if( input.length > 50)	
					$("#err_div").append("Error: Email Address too long. 50 Max.<br/>");

				var input=$("#streetAddress").val();
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
