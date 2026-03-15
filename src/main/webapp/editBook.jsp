<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Редактирование книги</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
<jsp:include page="/WEB-INF/jspf/header.jsp" />
<div class="container mt-4">
    <h2>Редактирование книги</h2>
    <form method="POST" action="editBook">
        <input type="hidden" name="id" value="${book.id}">

        <div class="mb-3">
            <label class="form-label">Название</label>
            <input type="text" name="title" class="form-control" value="${book.title}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Переплёт</label>
            <input type="text" name="binding" class="form-control" value="${book.binding}">
        </div>
        <div class="mb-3">
            <label class="form-label">Издательство</label>
            <input type="text" name="publisher" class="form-control" value="${book.publisher}">
        </div>
        <div class="mb-3">
            <label class="form-label">Год</label>
            <input type="number" name="year" class="form-control" value="${book.year}">
        </div>
        <div class="mb-3">
            <label class="form-label">Жанр</label>
            <input type="text" name="genre" class="form-control" value="${book.genre}">
        </div>
        <div class="mb-3">
            <label class="form-label">Автор</label>
            <select name="authorId" class="form-control" required>
                <option value="">Выберите автора</option>
                <c:forEach var="author" items="${authors}">
                    <option value="${author.id}" ${author.id == book.author.id ? 'selected' : ''}>
                        ${author.fullName}
                    </option>
                </c:forEach>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Сохранить</button>
        <a href="books" class="btn btn-secondary">Отмена</a>
    </form>
</div>
<jsp:include page="/WEB-INF/jspf/footer.jsp" />
</body>
</html>