<%-- 
    Document   : create
    Created on : Apr 22, 2011, 3:24:13 PM
    Author     : FMilens
--%>

<%@taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Talent</title>
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    </head>
    <body>
        <h1>Create New Talent</h1>
		<p><a href="${pageContext.request.contextPath}/">Home</a></p>
		
        <c:if test="${fn:length(errors) gt 0}">
            <p>Please correct the following errors in your submission:</p>
            <ul>
                <c:forEach items="${errors}" var="error">
                    <li>${error}</li>
                </c:forEach>
            </ul>
        </c:if>
			
			
        <form:form name="newPersonForm" action="${pageContext.request.contextPath}/person/create" modelAttribute="person" method="POST">
			<div id="err_div" style="padding-left:50px; margin-left: 50px"></div>
			<table>
				<tr>
					<th style="text-align:right">First Name</th>
					<td><form:input id="firstName" name="firstName" type="text" path="firstName" /></td>
				</tr>
				<tr>
					<th style="text-align:right">Last Name</th>
					<td><form:input id="lastName" name="lastName" type="text" path="lastName"/></td>
				</tr>
				<tr>
					<th style="text-align:right">Email Address</th>
					<td><form:input id="emailAddress" name="emailAddress" type="text" path="emailAddress" /></td>
				</tr>
				<tr>
					<th style="text-align:right">Street Address</th>
					<td><form:input id="streetAddress" name="streetAddress" type="text" path="streetAddress"/></td>
				</tr>
				<tr>
					<th style="text-align:right">City</th>
					<td><form:input id="city" name="city" type="text" path="city" /></td>
				</tr>
				<tr>
					<th style="text-align:right">State</th>
					<td><form:input id="state" name="state" type="text" path="state" /></td>
				</tr>
				<tr>
					<th style="text-align:right">Zip Code</th>
					<td><form:input id="zipCode" name="zipCode" type="text" path="zipCode"/></td>
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
            <div id="new_submit">	 
				<input type="submit" value="Submit"/>
			</div>
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
				if( err)
					{
					$("#err_div").append("<br/>Please correct the errors above and re-submit.<br/><br/>");
					event.preventDefault();
					}
				return;
				});
				$("#err_div").text("-No Errors-");
			</script>

			
	</body>
</html>
