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
        <title>Client Listing</title>
    </head>
    <body>
        <h1>Client Listing</h1>     
 		<p><a href="${pageContext.request.contextPath}/">Home</a>
        <p><a href="${pageContext.request.contextPath}/client/create">Create New Client Company</a></p>
        <c:choose>
            <c:when test="${fn:length(clients) gt 0}">
                <table STYLE="border: solid black; ">
                    <thead>
                        <tr  style="border: solid black; background-color: aliceblue">
                            <th>Client</th>
                            <th>Website</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${clients}" var="client">
                            <tr>
                                <td>${client.name}</td>
                                <td>${client.web}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/client/edit/${client.clientId}">Edit Client</a>
                                    <a href="${pageContext.request.contextPath}/client/delete/${client.clientId}">Delete Client</a>
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
