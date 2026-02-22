package domain;

public class Role {
    private Long id;
    private String namerole;

    public Role() {}

    public Role(int id, String namerole) {
        this.id = (long) id;
        this.namerole = namerole;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNameRole() { return namerole; }
    public void setNameRole(String namerole) { this.namerole = namerole; }
}