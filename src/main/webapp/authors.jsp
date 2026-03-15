<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Авторы</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="/WEB-INF/jspf/header.jsp" />
    <div id="main">
        <h2>Список авторов</h2>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>ФИО</th>
                <th>Телефон</th>
                <th>Email</th>
                <th>Рейтинг</th>
                <th scope="col">Редактировать</th>
				<th scope="col">Удалить</th>
            </tr>
            <c:forEach var="author" items="${authors}">
                <tr>
                    <td>${author.id}</td>
                    <td>${author.fullName}</td>
                    <td>${author.phone}</td>
                    <td>${author.email}</td>
                    <td>${author.rating}</td>
                    <td width="20">
					    <a href="<c:url value='/editAuthor?id=${author.id}' />" 
					       class="btn btn-outline-primary btn-sm">
					        <img src="images/icon-edit.png" alt="Ред." width="16">
					    </a>
					</td>
					<td width="20">
					    <a href="<c:url value='/deleteAuthor?id=${author.id}' />" 
					       class="btn btn-outline-primary btn-sm">
					        <img src="images/icon-delete.png" alt="Уд." width="16">
					    </a>
					</td>
                </tr>
            </c:forEach>
        </table>
        
        <h3>Добавить нового автора</h3>
        <form method="POST" action="authors">
            <input type="text" name="fullName" placeholder="ФИО" required>
            <input type="text" name="phone" placeholder="Телефон">
            <input type="email" name="email" placeholder="Email">
            <input type="number" step="0.1" name="rating" placeholder="Рейтинг">
            <button type="submit">Добавить автора</button>
        </form>
    </div>
    <jsp:include page="/WEB-INF/jspf/footer.jsp" />
</body>
</html>