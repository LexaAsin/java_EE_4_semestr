<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="domain.Person"%>
<%@ page import="domain.Role"%>

<%
    Role r1 = new Role(11, "директор");
    Role r2 = new Role(21, "бухгалтер");
    Role r3 = new Role(31, "менеджер");
    Role r4 = new Role(41, "маркетолог");
    Role[] roles = new Role[]{r1, r2, r3, r4};
    pageContext.setAttribute("roles", roles);

    Person p1 = new Person(11, "Иван", "Иванов", "ivanov@mail.ru", "+7(961)289-55-24", 11, r1);
    Person p2 = new Person(21, "Петр", "Петров", "petrov@mail.ru", "+7(961)289-44-39", 21, r2);
    Person p3 = new Person(31, "Сидор", "Сидоров", "sidorov@mail.ru", "+7(961)289-33-57", 31, r3);
    Person p4 = new Person(41, "Иван", "Иванов", "ivanov@mail.ru", "+7(961)289-44-39", 41, r4);
    Person[] persons = new Person[]{p1, p2, p3, p4};
    pageContext.setAttribute("persons", persons);
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <meta charset="UTF-8">
    <title>Сотрудники</title>
</head>
<body>
    <jsp:include page="/WEB-INF/jspf/header.jsp" />
    <div id="main">
        <h2>Список сотрудников</h2>
        <table border="1">
            <tr><th>Код</th><th>Фамилия</th><th>Имя</th><th>Должность</th><th>Телефон</th><th>Email</th></tr>
            <c:forEach var="person" items="${persons}">
                <tr>
                    <td>${person.id}</td>
                    <td>${person.lastName}</td>
                    <td>${person.firstName}</td>
                    <td>${person.role.nameRole}</td>
                    <td>${person.phone}</td>
                    <td>${person.email}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <jsp:include page="/WEB-INF/jspf/footer.jsp" />
</body>
</html>