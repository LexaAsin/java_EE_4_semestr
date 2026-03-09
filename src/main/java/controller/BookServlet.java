package controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
import domain.Book;

@WebServlet("/books")
public class BookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    ConnectionProperty prop;
    String selectAllBooks = "SELECT b.id, b.title, b.binding, b.publisher, b.year, b.genre, b.author_id, "
                          + "a.full_name, a.phone, a.email, a.rating "
                          + "FROM books b LEFT JOIN authors a ON b.author_id = a.id";
    String insertBook = "INSERT INTO books(title, binding, publisher, year, genre, author_id) VALUES(?, ?, ?, ?, ?, ?)";
    ArrayList<Book> books = new ArrayList<>();
    ArrayList<Author> authors = new ArrayList<>();
    String userPath;

    public BookServlet() throws FileNotFoundException, IOException {
        prop = new ConnectionProperty();
    }

    private Author findAuthorById(Long id, ArrayList<Author> authors) {
        if (authors != null) {
            for (Author a : authors) {
                if (a.getId().equals(id)) {
                    return a;
                }
            }
        }
        return null;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        EmpConnBuilder builder = new EmpConnBuilder();

        try (Connection conn = builder.getConnection()) {
            Statement stmt = conn.createStatement();

            ResultSet rsAuthors = stmt.executeQuery("SELECT id, full_name, phone, email, rating FROM authors");
            if (rsAuthors != null) {
                authors.clear();
                while (rsAuthors.next()) {
                    String fullName = new String(rsAuthors.getString("full_name").getBytes("ISO-8859-1"), "UTF-8");
                    String phone = new String(rsAuthors.getString("phone").getBytes("ISO-8859-1"), "UTF-8");
                    String email = new String(rsAuthors.getString("email").getBytes("ISO-8859-1"), "UTF-8");

                    authors.add(new Author(
                        rsAuthors.getLong("id"),
                        fullName,
                        phone,
                        email,
                        rsAuthors.getDouble("rating")
                    ));
                }
                rsAuthors.close();
                request.setAttribute("authors", authors);
            }

            ResultSet rsBooks = stmt.executeQuery(selectAllBooks);
            if (rsBooks != null) {
                books.clear();
                while (rsBooks.next()) {
                    String title = new String(rsBooks.getString("title").getBytes("ISO-8859-1"), "UTF-8");
                    String binding = new String(rsBooks.getString("binding").getBytes("ISO-8859-1"), "UTF-8");
                    String publisher = new String(rsBooks.getString("publisher").getBytes("ISO-8859-1"), "UTF-8");
                    String genre = new String(rsBooks.getString("genre").getBytes("ISO-8859-1"), "UTF-8");

                    Long authorId = rsBooks.getLong("author_id");
                    Author author = null;
                    if (!rsBooks.wasNull()) {
                        String authorName = new String(rsBooks.getString("full_name").getBytes("ISO-8859-1"), "UTF-8");
                        String authorPhone = new String(rsBooks.getString("phone").getBytes("ISO-8859-1"), "UTF-8");
                        String authorEmail = new String(rsBooks.getString("email").getBytes("ISO-8859-1"), "UTF-8");

                        author = new Author(
                            authorId,
                            authorName,
                            authorPhone,
                            authorEmail,
                            rsBooks.getDouble("rating")
                        );
                    }

                    books.add(new Book(
                        rsBooks.getLong("id"),
                        title,
                        binding,
                        publisher,
                        rsBooks.getInt("year"),
                        genre,
                        authorId,
                        author
                    ));
                }
                rsBooks.close();
                request.setAttribute("books", books);
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        userPath = request.getServletPath();
        if ("/books".equals(userPath)) {
            request.getRequestDispatcher("/books.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String title = request.getParameter("title");
        String binding = request.getParameter("binding");
        String publisher = request.getParameter("publisher");
        String yearStr = request.getParameter("year");
        String genre = request.getParameter("genre");
        String authorIdStr = request.getParameter("authorId");
        
        Integer year = 0;
        if (yearStr != null && !yearStr.isEmpty()) {
            year = Integer.parseInt(yearStr);
        }
        
        Long authorId = null;
        if (authorIdStr != null && !authorIdStr.isEmpty()) {
            authorId = Long.parseLong(authorIdStr);
        }
        
        EmpConnBuilder builder = new EmpConnBuilder();
        
        try (Connection conn = builder.getConnection();
             PreparedStatement ps = conn.prepareStatement(insertBook)) {
            
            ps.setString(1, title);
            ps.setString(2, binding);
            ps.setString(3, publisher);
            ps.setInt(4, year);
            ps.setString(5, genre);
            ps.setLong(6, authorId);
            
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        response.sendRedirect("books");
    }
}