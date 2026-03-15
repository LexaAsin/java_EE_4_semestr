<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Книги</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/jspf/header.jsp" />
    <div class="container mt-4">
        <h2>Список книг</h2>
        <table class="table table-bordered table-sm">
            <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Название</th>
                    <th>Переплёт</th>
                    <th>Издательство</th>
                    <th>Год</th>
                    <th>Жанр</th>
                    <th>Автор</th>
                    <th>Ред.</th>
                    <th>Уд.</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="book" items="${books}">
                    <tr>
                        <td>${book.id}</td>
                        <td>${book.title}</td>
                        <td>${book.binding}</td>
                        <td>${book.publisher}</td>
                        <td>${book.year}</td>
                        <td>${book.genre}</td>
                        <td>${book.author.fullName}</td>
                        <td>
                            <a href="<c:url value='/editBook?id=${book.id}' />" class="btn btn-outline-primary btn-sm">
                                <img src="images/pencil-icon.png" alt="Ред" width="16">
                            </a>
                        </td>
                        <td>
                            <a href="<c:url value='/deleteBook?id=${book.id}' />" class="btn btn-outline-primary btn-sm">
                                <img src="images/trash.png" alt="Уд" width="16">
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <h3 class="mt-4">Добавить новую книгу</h3>
        <form method="POST" action="books" class="row g-3">
            <div class="col-md-4">
                <input type="text" name="title" class="form-control" placeholder="Название" required>
            </div>
            <div class="col-md-2">
                <input type="text" name="binding" class="form-control" placeholder="Переплёт">
            </div>
            <div class="col-md-3">
                <input type="text" name="publisher" class="form-control" placeholder="Издательство">
            </div>
            <div class="col-md-1">
                <input type="number" name="year" class="form-control" placeholder="Год">
            </div>
            <div class="col-md-2">
                <input type="text" name="genre" class="form-control" placeholder="Жанр">
            </div>
            <div class="col-md-4">
                <select name="authorId" class="form-control" required>
                    <option value="">Автор</option>
                    <c:forEach var="author" items="${authors}">
                        <option value="${author.id}">${author.fullName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary">Добавить</button>
            </div>
        </form>
    </div>
    <jsp:include page="/WEB-INF/jspf/footer.jsp" />
</body>
</html>