<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Удаление книги</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
<jsp:include page="/WEB-INF/jspf/header.jsp" />
<div class="container mt-4">
    <h2>Удаление книги</h2>
    <p>Вы уверены, что хотите удалить книгу?</p>
    
    <form method="POST" action="deleteBook">
        <input type="hidden" name="id" value="${book.id}">
        
        <div class="mb-3 row">
            <label class="col-sm-2 col-form-label">Название</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="${book.title}" readonly>
            </div>
        </div>
        
        <div class="mb-3 row">
            <label class="col-sm-2 col-form-label">Автор</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="${book.author.fullName}" readonly>
            </div>
        </div>
        
        <div class="mb-3 row">
            <label class="col-sm-2 col-form-label">Год</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="${book.year}" readonly>
            </div>
        </div>
        
        <button type="submit" class="btn btn-danger">Удалить</button>
        <a href="books" class="btn btn-secondary">Отмена</a>
    </form>
</div>
<jsp:include page="/WEB-INF/jspf/footer.jsp" />
</body>
</html>