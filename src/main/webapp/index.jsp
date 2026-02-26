<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <meta charset="UTF-8">
    <title>Библиотека</title>
</head>
<body>
    <jsp:include page="/WEB-INF/jspf/header.jsp" />
    <div id="main">
        <h2>Функции системы</h2>
        <nav>
            <ul>
                <li><a href="authors">Авторы</a></li>
                <li><a href="books">Книги</a></li>
            </ul>
        </nav>
    </div>
    <jsp:include page="/WEB-INF/jspf/footer.jsp" />
</body>
</html>