<%-- 
    Document   : delete
    Created on : Apr 22, 2011, 3:55:55 PM
    Author     : FMilens
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Client</title>
    </head>
    <body>
        <h1>Delete Client</h1>
        <p>You are about to delete the client ${client.name}:  Are you sure?</p>
        <form action="${pageContext.request.contextPath}/client/delete" method="post">
            <input type="hidden" name="clientId" value="${client.clientId}"/>
            <input type="submit" name="command" value="Cancel"/>
            <input type="submit" name="command" value="Delete"/>
        </form>
    </body>
</html>
