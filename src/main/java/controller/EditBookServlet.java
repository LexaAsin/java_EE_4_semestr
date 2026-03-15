package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.EmpConnBuilder;
import domain.Author;
import domain.Book;

@WebServlet("/editBook")
public class EditBookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Book book = null;
        ArrayList<Author> authors = new ArrayList<>();

        try (Connection conn = new EmpConnBuilder().getConnection()) {
            // Загружаем книгу
            PreparedStatement psBook = conn.prepareStatement(
                "SELECT id, title, binding, publisher, year, genre, author_id FROM books WHERE id = ?");
            psBook.setLong(1, id);
            ResultSet rsBook = psBook.executeQuery();
            if (rsBook.next()) {
                Long authorId = rsBook.getLong("author_id");
                Author author = null;

                // Загружаем автора книги
                PreparedStatement psAuthor = conn.prepareStatement(
                    "SELECT id, full_name, phone, email, rating FROM authors WHERE id = ?");
                psAuthor.setLong(1, authorId);
                ResultSet rsAuthor = psAuthor.executeQuery();
                if (rsAuthor.next()) {
                    author = new Author(
                        rsAuthor.getLong("id"),
                        rsAuthor.getString("full_name"),
                        rsAuthor.getString("phone"),
                        rsAuthor.getString("email"),
                        rsAuthor.getDouble("rating")
                    );
                }
                book = new Book(
                    rsBook.getLong("id"),
                    rsBook.getString("title"),
                    rsBook.getString("binding"),
                    rsBook.getString("publisher"),
                    rsBook.getInt("year"),
                    rsBook.getString("genre"),
                    authorId,
                    author
                );
            }

            // Загружаем всех авторов для выпадающего списка
            PreparedStatement psAllAuthors = conn.prepareStatement("SELECT id, full_name FROM authors");
            ResultSet rsAllAuthors = psAllAuthors.executeQuery();
            while (rsAllAuthors.next()) {
                authors.add(new Author(
                    rsAllAuthors.getLong("id"),
                    rsAllAuthors.getString("full_name"),
                    null, null, 0.0
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("book", book);
        request.setAttribute("authors", authors);
        request.getRequestDispatcher("/editBook.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String title = request.getParameter("title");
        String binding = request.getParameter("binding");
        String publisher = request.getParameter("publisher");
        Integer year = Integer.parseInt(request.getParameter("year"));
        String genre = request.getParameter("genre");
        Long authorId = Long.parseLong(request.getParameter("authorId"));

        try (Connection conn = new EmpConnBuilder().getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "UPDATE books SET title=?, binding=?, publisher=?, year=?, genre=?, author_id=? WHERE id=?")) {
            ps.setString(1, title);
            ps.setString(2, binding);
            ps.setString(3, publisher);
            ps.setInt(4, year);
            ps.setString(5, genre);
            ps.setLong(6, authorId);
            ps.setLong(7, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("books");
    }
}