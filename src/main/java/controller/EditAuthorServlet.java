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

@WebServlet("/editAuthor")
public class EditAuthorServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Author author = null;

        try (Connection conn = new EmpConnBuilder().getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "SELECT id, full_name, phone, email, rating FROM authors WHERE id = ?")) {
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
        request.getRequestDispatcher("/editAuthor.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        Double rating = Double.parseDouble(request.getParameter("rating"));

        try (Connection conn = new EmpConnBuilder().getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "UPDATE authors SET full_name = ?, phone = ?, email = ?, rating = ? WHERE id = ?")) {
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setDouble(4, rating);
            ps.setLong(5, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("authors");
    }
}