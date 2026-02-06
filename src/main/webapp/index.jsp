<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <title>Главная страница</title>
</head>
<body>
    <header>
        <a href="/"><img alt="Логотип" id="top-image" src="#"></a>
        <div id="user-panel">
            <h1>Управление персоналом</h1>
        </div>
    </header>
    
    <div id="main">
        <h2>Функции системы</h2>
        <ul>
            <li><a href="PersonsServlet">Сотрудники</a></li>
            <li><a href="HelloRoleServlet">Должности</a></li>
        </ul>
    </div>
    
    <footer>
        <div>
            <span>Тестовое приложение JAVA EE</span>
        </div>
    </footer>
</body>
</html>