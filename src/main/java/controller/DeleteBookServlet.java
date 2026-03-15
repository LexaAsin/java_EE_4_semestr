package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.EmpConnBuilder;
import domain.Author;
import domain.Book;

@WebServlet("/deleteBook")
public class DeleteBookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Book book = null;

        try (Connection conn = new EmpConnBuilder().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT b.id, b.title, b.year, a.id as author_id, a.full_name " +
                "FROM books b LEFT JOIN authors a ON b.author_id = a.id WHERE b.id = ?");
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Author author = new Author(
                    rs.getLong("author_id"),
                    rs.getString("full_name"),
                    null, null, 0.0
                );
                
                book = new Book(
                    rs.getLong("id"),
                    rs.getString("title"),
                    null, null, rs.getInt("year"), null,
                    rs.getLong("author_id"),
                    author
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("book", book);
        request.getRequestDispatcher("/deleteBook.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));

        try (Connection conn = new EmpConnBuilder().getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM books WHERE id = ?")) {
            ps.setLong(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("books");
    }
}