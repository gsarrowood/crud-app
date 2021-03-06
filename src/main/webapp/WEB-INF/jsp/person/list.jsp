<%-- 
    Document   : list
    Created on : Apr 22, 2011, 2:25:22 PM
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
        <title>Talent Listing</title>
    </head>
    <body>
        <h1>Talent Listing</h1>     
 		<p><a href="${pageContext.request.contextPath}/">Home</a>
        <p><a href="${pageContext.request.contextPath}/person/create">Create New Talent</a></p>
        <c:choose>
            <c:when test="${fn:length(persons) gt 0}">
                <table STYLE="border: solid black; ">
                    <thead>
                        <tr style="border: solid black; background-color: aliceblue">
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Email Address</th>
                            <th>Client</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${persons}" var="person">
							<c:set var="clientString">${person.clientId}</c:set>
                            <tr style="border: solid black;">
                                <td>${person.firstName}</td>
                                <td>${person.lastName}</td>
                                <td>${person.emailAddress}</td>
                                <td>${clientSelectList[clientString]}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/person/edit/${person.personId}">Edit</a>
                                    <a href="${pageContext.request.contextPath}/person/delete/${person.personId}">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p>No results found.</p>
            </c:otherwise>
        </c:choose>
    </body>
</html>
