<%-- 
    Document   : multiAssignPersons
    Created on : May 27, 2017, 6:09:25 PM
    Author     : dads work
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
        <title>Assign Talent</title>
    </head>
    <body>
        <h1>Assign Talent to ${client.name}</h1>
		
		<p><a href="${pageContext.request.contextPath}/">Home</a></p>
		<p><a href="${pageContext.request.contextPath}/client/edit/${client.clientId}">Back to the Edit Screen</a></p>
 
        <form action="${pageContext.request.contextPath}/client/multiAssignPersons" method="POST">
			<c:choose>
				<c:when test="${fn:length(personList) gt 0}">
					<h3>Talent List</h3>
					<table STYLE="border: solid black; ">
						<thead>
							<tr style="border: solid black; background-color: aliceblue">
								<th>Talent</th>
								<th>Currently With</th>
								<th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${personList}" var="item">
								<c:set var="clientString">${item.clientId}</c:set>
								<c:set var="checked" value="" ></c:set>
								<c:if test="${item.clientId eq client.clientId}">
									<c:set var="checked" value="CHECKED" ></c:set>
								</c:if>
								<tr style="border: solid black;">
									<td>${item.firstName} ${item.lastName}</td>
									<td>${clientSelectList[clientString]}</td>
									<td>
										<input type="checkbox" id="${item.personId}" name="selPersons"  value="${item.personId}"  ${checked}>
										<label for="${item.personId}">${item.firstName} ${item.lastName}</label>
									</td>
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
			<input type="hidden" name="clientId" value="${client.clientId}"/>
			<input type="hidden" name="selPersons" value="ignore"/>
			<input type="submit" value="Assign Selected"/>
       </form>
    </body>
</html>
