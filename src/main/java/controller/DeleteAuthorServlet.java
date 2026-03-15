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

@WebServlet("/deleteAuthor")
public class DeleteAuthorServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Author author = null;

        try (Connection conn = new EmpConnBuilder().getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT id, full_name, phone, email, rating FROM authors WHERE id = ?");
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                author = new Author(
                    rs.getLong("id"),
                    rs.getString("full_name"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getDouble("rating")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("author", author);
        request.getRequestDispatcher("/deleteAuthor.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));

        try (Connection conn = new EmpConnBuilder().getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM authors WHERE id = ?")) {
            ps.setLong(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("authors");
    }
}