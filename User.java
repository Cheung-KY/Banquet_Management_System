import java.sql.*;
import java.util.Arrays;
import java.util.*;

public class User {
    private static Connection conn;
    private static String attendeeID;
    private String fname;
    private String lname;
    private String address;
    private String attendeeType;
    private String password;
    private String phoneNumber;
    private String affiliatedOrg;

    public User(String attendeeID, String fname, String lname, String address, String attendeeType, String password, String phoneNumber, String affiliatedOrg) {
        this.attendeeID = attendeeID;
        this.fname = fname;
        this.lname = lname;
        this.address = address;
        this.attendeeType = attendeeType;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.affiliatedOrg = affiliatedOrg;
    }

    public User(Connection conn) {
        this.conn = conn;
    }

    public Connection getConnection() {
        return conn;
    }

    public void create(Connection conn) throws SQLException {
        String query = "INSERT INTO Attendee (AttendeeID, FNAME, LNAME, ADDRESS, ATTENDEETYPE, PASSWORD, PHONENUMBER, AFFILIATEDORG) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, attendeeID);
        stmt.setString(2, fname);
        stmt.setString(3, lname);
        stmt.setString(4, address);
        stmt.setString(5, attendeeType);
        stmt.setString(6, password);
        stmt.setString(7, phoneNumber);
        stmt.setString(8, affiliatedOrg);
        stmt.executeUpdate();
        stmt.close();
    }

    public static void searchByUser() throws SQLException {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Select search type:");
        System.out.println("1. BIN");
        System.out.println("2. Banquet Name");
        System.out.println("3. First Name of Contact Staff");
        System.out.println("4. Last Name of Contact Staff");
        System.out.println("5. Address");
        System.out.println("6. Location");
        System.out.println("7. Minimum Attendee");
        System.out.println("8. Quota");
        System.out.println("9. Available");
        System.out.println("10. DateTime(YYYY-MM-DD XX:XX:XX)");

        int searchType = scanner.nextInt();
        scanner.nextLine();

        String searchColumn = "";
        switch (searchType) {
            case 1: searchColumn = "BIN"; break;
            case 2: searchColumn = "BanquetName"; break;
            case 3: searchColumn = "FNameContactStaff"; break;
            case 4: searchColumn = "LNameContactStaff"; break;
            case 5: searchColumn = "Address"; break;
            case 6: searchColumn = "Location"; break;
            case 7: searchColumn = "MinAttendee"; break;
            case 8: searchColumn = "Quota"; break;
            case 9: searchColumn = "Available"; break;
            case 10: searchColumn = "DateTime"; break;
            default:
                System.out.println("Invalid selection.");
                return;
        }

        System.out.print("Enter the search value: ");
        String searchValue = scanner.nextLine();

        String sql = "SELECT * FROM Banquet WHERE " + searchColumn + " = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            if (searchColumn.equals("BIN") || searchColumn.equals("MinAttendee") || searchColumn.equals("Quota")) {
                pstmt.setInt(1, Integer.parseInt(searchValue));
            } else if (searchColumn.equals("DateTime")) {
                pstmt.setTimestamp(1, Timestamp.valueOf(searchValue));
            } else {
                pstmt.setString(1, searchValue);
            }

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                System.out.println("BIN: " + rs.getInt("BIN"));
                System.out.println("Banquet Name: " + rs.getString("BanquetName"));
                System.out.println("First Name of Contact Staff: " + rs.getString("FNameContactStaff"));
                System.out.println("Last Name of Contact Staff: " + rs.getString("LNameContactStaff"));
                System.out.println("Minimum Attendee: " + rs.getInt("MinAttendee"));
                System.out.println("Quota: " + rs.getInt("Quota"));
                System.out.println("Available: " + rs.getString("Available"));
                System.out.println("DateTime: " + rs.getTimestamp("DateTime"));
                System.out.println("Address: " + rs.getString("Address"));
                System.out.println("Location: " + rs.getString("Location"));
                System.out.println();
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw e;
        }
    }

    public static boolean update(Connection conn, String email, String col, String input) throws SQLException {
        col = col.toUpperCase().trim();
        if (!Arrays.asList("ATTENDEEID", "FNAME", "LNAME", "PHONENUMBER", "ADDRESS", "ATTENDEETYPE", "PASSWORD", "AFFILIATEDORG").contains(col)) {
            throw new SQLException("Invalid column name.");
        }

        String query = "UPDATE Attendee SET " + col + " = ? WHERE AttendeeID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, input);
            stmt.setString(2, email);
            stmt.executeUpdate();
        }
        return true;
    }

    public static boolean updateAttendeeID(Connection conn, String oldID, String newID) throws SQLException {
        try {
            conn.setAutoCommit(false);

            String updateAttendee = "UPDATE Attendee SET AttendeeID = ? WHERE AttendeeID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateAttendee)) {
                stmt.setString(1, newID);
                stmt.setString(2, oldID);
                stmt.executeUpdate();
            }

            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (SQLException e) {
            conn.rollback();
            System.err.println("SQL error: " + e.getMessage());
            return false;
        }
    }
}



