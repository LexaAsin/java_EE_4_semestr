<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <meta charset="UTF-8">
    <title>Главная страница</title>
</head>
<body>
    <header>
        <a href="/persons/">
            <img alt="Логотип" id="top-image" src="images/employees.png">
        </a>
        <div id="user-panel">
            <h1>Управление персоналом</h1>
        </div>
    </header>

    <div id="main">
        <h2>Функции системы</h2>
        <nav>
            <ul>
                <li><a href="persons">Сотрудники</a></li>
                <li><a href="roles">Должности</a></li>
            </ul>
        </nav>
    </div>

    <footer>
        <div>
            <span>Тестовое приложение JAVA EE</span>
        </div>
    </footer>
</body>
</html>