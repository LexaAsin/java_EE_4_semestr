package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/persons")
public class PersonsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public PersonsServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Перенаправляем запрос на JSP-страницу
        request.getRequestDispatcher("/person.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Если форма отправлена POST — пока делаем то же, что и GET
        doGet(request, response);
    }
}