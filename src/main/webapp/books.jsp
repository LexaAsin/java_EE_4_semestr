<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Книги</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/jspf/header.jsp" />
    <div id="main">
        <h2>Список книг</h2>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Название</th>
                <th>Переплёт</th>
                <th>Издательство</th>
                <th>Год</th>
                <th>Жанр</th>
                <th>Автор</th>
            </tr>
            <c:forEach var="book" items="${books}">
                <tr>
                    <td>${book.id}</td>
                    <td>${book.title}</td>
                    <td>${book.binding}</td>
                    <td>${book.publisher}</td>
                    <td>${book.year}</td>
                    <td>${book.genre}</td>
                    <td>${book.author.fullName}</td>
                </tr>
            </c:forEach>
        </table>
        
        <h3>Добавить новую книгу</h3>
        <form method="POST" action="books">
            <input type="text" name="title" placeholder="Название" required>
            <input type="text" name="binding" placeholder="Переплёт">
            <input type="text" name="publisher" placeholder="Издательство">
            <input type="number" name="year" placeholder="Год">
            <input type="text" name="genre" placeholder="Жанр">
            <select name="authorId" required>
                <option value="">Выберите автора</option>
                <c:forEach var="author" items="${authors}">
                    <option value="${author.id}">${author.fullName}</option>
                </c:forEach>
            </select>
            <button type="submit">Добавить книгу</button>
        </form>
    </div>
    <jsp:include page="/WEB-INF/jspf/footer.jsp" />
</body>
</html>