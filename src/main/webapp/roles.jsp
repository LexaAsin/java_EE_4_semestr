<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="domain.Role"%>

<%
    Role r1 = new Role(11, "директор");
    Role r2 = new Role(21, "бухгалтер");
    Role r3 = new Role(31, "менеджер");
    Role r4 = new Role(41, "маркетолог");
    Role[] roles = new Role[]{r1, r2, r3, r4};
    pageContext.setAttribute("roles", roles);
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <meta charset="UTF-8">
    <title>Должности</title>
</head>
<body>
    <jsp:include page="/WEB-INF/jspf/header.jsp" />
    <div id="main">
        <h2>Список должностей</h2>
        <table border="1">
            <tr><th>Код</th><th>Должность</th></tr>
            <c:forEach var="role" items="${roles}">
                <tr><td>${role.id}</td><td>${role.nameRole}</td></tr>
            </c:forEach>
        </table>
    </div>
    <jsp:include page="/WEB-INF/jspf/footer.jsp" />
</body>
</html>