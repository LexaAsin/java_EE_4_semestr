<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Удаление автора</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
<jsp:include page="/WEB-INF/jspf/header.jsp" />
<div class="container mt-4">
    <h2>Удаление автора</h2>
    <p>Вы уверены, что хотите удалить автора?</p>
    
    <form method="POST" action="deleteAuthor">
        <input type="hidden" name="id" value="${author.id}">
        
        <div class="mb-3 row">
            <label class="col-sm-2 col-form-label">ФИО</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="${author.fullName}" readonly>
            </div>
        </div>
        
        <div class="mb-3 row">
            <label class="col-sm-2 col-form-label">Телефон</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="${author.phone}" readonly>
            </div>
        </div>
        
        <div class="mb-3 row">
            <label class="col-sm-2 col-form-label">Email</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="${author.email}" readonly>
            </div>
        </div>
        
        <div class="mb-3 row">
            <label class="col-sm-2 col-form-label">Рейтинг</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="${author.rating}" readonly>
            </div>
        </div>
        
        <button type="submit" class="btn btn-danger">Удалить</button>
        <a href="authors" class="btn btn-secondary">Отмена</a>
    </form>
</div>
<jsp:include page="/WEB-INF/jspf/footer.jsp" />
</body>
</html>