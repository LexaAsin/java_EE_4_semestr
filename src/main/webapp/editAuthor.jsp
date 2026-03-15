<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <title>Редактирование автора</title>
</head>
<body>
<jsp:include page="/WEB-INF/jspf/header.jsp" />
<div class="container mt-4">
    <h2>Редактирование автора</h2>
    <form method="POST" action="editAuthor">
        <input type="hidden" name="id" value="${author.id}">
        <div class="mb-3">
            <label class="form-label">ФИО</label>
            <input type="text" name="fullName" class="form-control" value="${author.fullName}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Телефон</label>
            <input type="text" name="phone" class="form-control" value="${author.phone}">
        </div>
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" value="${author.email}">
        </div>
        <div class="mb-3">
            <label class="form-label">Рейтинг</label>
            <input type="number" step="0.1" name="rating" class="form-control" value="${author.rating}">
        </div>
        <button type="submit" class="btn btn-primary">Сохранить</button>
        <a href="authors" class="btn btn-secondary">Отмена</a>
    </form>
</div>
<jsp:include page="/WEB-INF/jspf/footer.jsp" />
</body>
</html>