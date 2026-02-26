package controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ConnectionProperty;
import dao.EmpConnBuilder;
import domain.Author;

@WebServlet("/authors")
public class AuthorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    ConnectionProperty prop;
    String selectAllAuthors = "SELECT id, full_name, phone, email, rating FROM authors";
    ArrayList<Author> authors = new ArrayList<>();
    String userPath;

    public AuthorServlet() throws FileNotFoundException, IOException {
        prop = new ConnectionProperty();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        EmpConnBuilder builder = new EmpConnBuilder();

        try (Connection conn = builder.getConnection()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(selectAllAuthors);
            if (rs != null) {
                authors.clear();
                while (rs.next()) {
                    // Костыль: перекодируем строки из БД
                    String fullName = new String(rs.getString("full_name").getBytes("ISO-8859-1"), "UTF-8");
                    String phone = new String(rs.getString("phone").getBytes("ISO-8859-1"), "UTF-8");
                    String email = new String(rs.getString("email").getBytes("ISO-8859-1"), "UTF-8");

                    authors.add(new Author(
                        rs.getLong("id"),
                        fullName,
                        phone,
                        email,
                        rs.getDouble("rating")
                    ));
                }
                rs.close();
                request.setAttribute("authors", authors);
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        userPath = request.getServletPath();
        if ("/authors".equals(userPath)) {
            request.getRequestDispatcher("/authors.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}