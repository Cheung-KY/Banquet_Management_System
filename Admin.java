import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Admin {
    private static Connection conn;
    private static Scanner scanner=new Scanner(System.in);

    public Admin(Connection conn) {
        this.conn = conn;
    }

    public Connection getConnection() {
        return conn;
    }

    public void displayAttendee() throws SQLException {
        new DisplayAttendee().display(conn);
    }

    public void displayRegistration() throws SQLException {
        new DisplayRegister().display(conn);
    }

    public void displayMeal() throws SQLException {
        new DisplayMeal().display(conn);
    }

    public void displayBanquet() throws SQLException {
        new DisplayBanquet().display(conn);
    }
    public static void updateBanquet() throws SQLException {
        while (true) {
            try {
                System.out.print("Enter BIN (-1 to exit): ");
                int bin = getIntInput();
                if (bin == -1) {
                    System.out.println("Exiting...");
                    return;
                }
    
                System.out.print("Enter Banquet Name (-1 to exit): ");
                String banquetName = getStringInput();
                if (banquetName.equals("-1")) return;
    
                System.out.print("Enter First Name of Contact Staff (-1 to exit): ");
                String fNameContactStaff = getStringInput();
                if (fNameContactStaff.equals("-1")) return;
    
                System.out.print("Enter Last Name of Contact Staff (-1 to exit): ");
                String lNameContactStaff = getStringInput();
                if (lNameContactStaff.equals("-1")) return;
    
                System.out.print("Enter Minimum Attendee (-1 to exit): ");
                int minAttendee = getIntInput();
                if (minAttendee == -1) return;
    
                System.out.print("Enter Quota (-1 to exit): ");
                int quota = getIntInput();
                if (quota == -1) return;
    
                System.out.print("Enter Availability (Y/N) (-1 to exit): ");
                String available = getStringInput();
                if (available.equals("-1")) return;
    
                System.out.print("Enter DateTime (YYYY-MM-DD HH:MM:SS) (-1 to exit): ");
                String dateTimeStr = getStringInput();
                if (dateTimeStr.equals("-1")) return;
                Timestamp dateTime;
                try {
                    dateTime = Timestamp.valueOf(dateTimeStr);
                } catch (IllegalArgumentException e) {
                    System.out.println("Timestamp format must be yyyy-mm-dd hh:mm:ss[.fffffffff]. Please try again.");
                    continue;
                }
    
                System.out.print("Enter Address (-1 to exit): ");
                String address = getStringInput();
                if (address.equals("-1")) return;
    
                System.out.print("Enter Location (-1 to exit): ");
                String location = getStringInput();
                if (location.equals("-1")) return;
    
                String sql = "UPDATE Banquet SET BanquetName = ?, FNameContactStaff = ?, LNameContactStaff = ?, " +
                             "MinAttendee = ?, Quota = ?, Available = ?, DateTime = ?, Address = ?, Location = ? " +
                             "WHERE BIN = ?";
    
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, banquetName);
                    pstmt.setString(2, fNameContactStaff);
                    pstmt.setString(3, lNameContactStaff);
                    pstmt.setInt(4, minAttendee);
                    pstmt.setInt(5, quota);
                    pstmt.setString(6, available);
                    pstmt.setTimestamp(7, dateTime); 
                    pstmt.setString(8, address);
                    pstmt.setString(9, location);
                    pstmt.setInt(10, bin);
    
                    pstmt.executeUpdate();
                    System.out.println("Banquet updated successfully.");
                }
                break;
            } catch (SQLException e) {
                System.out.println("An error occurred: " + e.getMessage());
            } catch (Exception e) {
                System.out.println("Invalid input. Please try again.");
                scanner.nextLine(); // Consume the invalid input
            }
        }
    }
    
    
    
    


    public void createNewBanquet(Connection conn) throws SQLException {
        while (true) {
            try {
                System.out.print("Enter Banquet BIN (-1 to exit): ");
                int bin = getIntInput();
                if (bin == -1) {
                    System.out.println("Exiting...");
                    return;
                }
    
                // Check if BIN already exists
                String checkBinSQL = "SELECT COUNT(*) FROM Banquet WHERE BIN = ?";
                try (PreparedStatement checkStmt = conn.prepareStatement(checkBinSQL)) {
                    checkStmt.setInt(1, bin);
                    ResultSet rs = checkStmt.executeQuery();
                    if (rs.next() && rs.getInt(1) > 0) {
                        System.out.println("A banquet with this BIN already exists. Please enter a unique BIN.");
                        continue;
                    }
                }
    
                System.out.print("Enter Banquet Name (-1 to exit): ");
                String banquetName = getStringInput();
                if (banquetName.equals("-1")) return;
    
                System.out.print("Enter First Name of Contact Staff (-1 to exit): ");
                String fnameContact = getStringInput();
                if (fnameContact.equals("-1")) return;
    
                System.out.print("Enter Last Name of Contact Staff (-1 to exit): ");
                String lnameContact = getStringInput();
                if (lnameContact.equals("-1")) return;
    
                System.out.print("Enter Minimum Attendee (-1 to exit): ");
                int minAttendee = getIntInput();
                if (minAttendee == -1) return;
    
                System.out.print("Enter Quota (-1 to exit): ");
                int quota = getIntInput();
                if (quota == -1) return;
    
                System.out.print("Is Available (Y/N) (-1 to exit): ");
                String available = getStringInput();
                if (available.equals("-1")) return;
    
                System.out.print("Enter Date and Time (YYYY-MM-DD HH:MM:SS) (-1 to exit): ");
                String dateTime = getStringInput();
                if (dateTime.equals("-1")) return;
    
                System.out.print("Enter Address (-1 to exit): ");
                String address = getStringInput();
                if (address.equals("-1")) return;
    
                System.out.print("Enter Location (-1 to exit): ");
                String location = getStringInput();
                if (location.equals("-1")) return;
    
                String insertBanquetSQL = "INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(insertBanquetSQL)) {
                    stmt.setInt(1, bin);
                    stmt.setString(2, banquetName);
                    stmt.setString(3, fnameContact);
                    stmt.setString(4, lnameContact);
                    stmt.setInt(5, minAttendee);
                    stmt.setInt(6, quota);
                    stmt.setString(7, available);
                    stmt.setTimestamp(8, Timestamp.valueOf(dateTime));
                    stmt.setString(9, address);
                    stmt.setString(10, location);
                    stmt.executeUpdate();
                }
    
                System.out.println("Banquet created.");
    
                // Add meals
                String insertMealSQL = "INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(insertMealSQL)) {
                    for (int i = 1; i <= 4; i++) {
                        System.out.print("Enter Dish Name for meal " + i + " (-1 to exit): ");
                        String dishName = getStringInput();
                        if ("-1".equals(dishName)) {
                            System.out.println("Exiting...");
                            return;
                        }
    
                        System.out.print("Enter Type for meal " + i + " (-1 to exit): ");
                        String type = getStringInput();
                        if ("-1".equals(type)) {
                            System.out.println("Exiting...");
                            return;
                        }
    
                        System.out.print("Enter Price for meal " + i + " (-1 to exit): ");
                        int price = getIntInput();
                        if (price == -1) return;
    
                        System.out.print("Enter Special Cuisine for meal " + i + " (-1 to exit): ");
                        String specialCuisine = getStringInput();
                        if ("-1".equals(specialCuisine)) {
                            System.out.println("Exiting...");
                            return;
                        }
    
                        stmt.setString(1, dishName);
                        stmt.setString(2, type);
                        stmt.setInt(3, price);
                        stmt.setString(4, specialCuisine);
                        stmt.setInt(5, bin);
                        stmt.addBatch();
                    }
                    stmt.executeBatch();
                }
    
                System.out.println("Meals added to the banquet.");
                break;
            } catch (SQLException e) {
                System.out.println("An error occurred: " + e.getMessage());
            } catch (Exception e) {
                System.out.println("Invalid input. Please try again.");
                scanner.nextLine(); // Consume the invalid input
            }
        }
    }
    
    private static int getIntInput() {
        while (true) {
            try {
                return Integer.parseInt(scanner.nextLine());
            } catch (NumberFormatException e) {
                System.out.print("Invalid input. Please enter an integer: ");
            }
        }
    }
    
    private static String getStringInput() {
        return scanner.nextLine();
    }
    
    

    public void updateBanquetMeal() throws SQLException {
        while (true) {
            try {
                System.out.print("Enter Banquet BIN (-1 to exit): ");
                int bin = getIntInput();
                if (bin == -1) {
                    System.out.println("Exiting...");
                    return;
                }
    
                System.out.print("Enter Dish Name of the meal to update: ");
                String oldDishName = getStringInput();
    
                System.out.print("Enter New Dish Name: ");
                String newDishName = getStringInput();
    
                System.out.print("Enter New Type: ");
                String type = getStringInput();
    
                System.out.print("Enter New Price: ");
                int price = getIntInput();
    
                System.out.print("Enter New Special Cuisine: ");
                String specialCuisine = getStringInput();
    
                String updateMealSQL = "UPDATE Meal SET DishName = ?, Type = ?, Price = ?, SpecialCuisine = ? WHERE BIN = ? AND DishName = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updateMealSQL)) {
                    stmt.setString(1, newDishName);
                    stmt.setString(2, type);
                    stmt.setInt(3, price);
                    stmt.setString(4, specialCuisine);
                    stmt.setInt(5, bin);
                    stmt.setString(6, oldDishName);
    
                    int rowsUpdated = stmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        System.out.println("Meal updated successfully.");
                    } else {
                        System.out.println("No meal found with the specified Dish Name for this Banquet.");
                    }
                }
                break;
            } catch (SQLException e) {
                System.out.println("An error occurred: " + e.getMessage());
            } catch (Exception e) {
                System.out.println("Invalid input. Please try again.");
                scanner.nextLine(); // Consume the invalid input
            }
        }
    }
    

    public void searchAttendeeByEmail(String email) throws SQLException {
        String attendeeQuery = "SELECT * FROM Attendee WHERE ATTENDEEID = ?";
        PreparedStatement attendeeStmt = conn.prepareStatement(attendeeQuery);
        attendeeStmt.setString(1, email);
        ResultSet attendeeRset = attendeeStmt.executeQuery();

        if (attendeeRset.next()) {
            System.out.println("ATTENDEEID: " + attendeeRset.getString("ATTENDEEID"));
            System.out.println("FNAME: " + attendeeRset.getString("FNAME"));
            System.out.println("LNAME: " + attendeeRset.getString("LNAME"));
            System.out.println("PHONENUMBER: " + attendeeRset.getString("PHONENUMBER"));
            System.out.println("ADDRESS: " + attendeeRset.getString("ADDRESS"));
            System.out.println("ATTENDEETYPE: " + attendeeRset.getString("ATTENDEETYPE"));
            System.out.println("PASSWORD: " + attendeeRset.getString("PASSWORD"));
            System.out.println("AFFILIATEDORG: " + attendeeRset.getString("AFFILIATEDORG"));
        } else {
            System.out.println("Email not found.");
        }
        attendeeRset.close();
        attendeeStmt.close();

        String registrationQuery = "SELECT * FROM Register WHERE ATTENDEEID = ?";
        PreparedStatement registrationStmt = conn.prepareStatement(registrationQuery);
        registrationStmt.setString(1, email);
        ResultSet registrationRset = registrationStmt.executeQuery();

        while (registrationRset.next()) {
            System.out.println("\nBanquet Details:");
            System.out.println("ATTENDEEID: " + registrationRset.getString("ATTENDEEID"));
            System.out.println("BIN: " + registrationRset.getString("BIN"));
            System.out.println("DRINKCHOICE: " + registrationRset.getString("DRINKCHOICE"));
            System.out.println("MEALCHOICE: " + registrationRset.getString("MEALCHOICE"));
            System.out.println("REMARKS: " + registrationRset.getString("REMARKS"));
        }
        registrationRset.close();
        registrationStmt.close();
    }

    //reg status
    public static List<String> generateReport1(Connection conn) throws SQLException {
        System.out.println("Registration Status Report:");

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT B.BIN, B.BanquetName, COUNT(R.BIN) as RegCNT, B.Quota " +
                "FROM Banquet B LEFT JOIN Register R ON B.BIN = R.BIN " +
                "WHERE B.Available = 'Y' " +
                "GROUP BY B.BIN, B.BanquetName, B.Quota " +
                "ORDER BY B.BIN");

        List<String> report = new ArrayList<>();

        while (rs.next()) {
            int bin = rs.getInt("BIN");
            String banquetName = rs.getString("BanquetName");
            int regcnt = rs.getInt("RegCNT");
            int quota = rs.getInt("Quota");

            report.add(bin + "\t" + regcnt + "/" + quota + "\t" + banquetName);
        }

        if (report.isEmpty()) {
            System.out.println("No available banquets found.");
        } else {
            for (String entry : report) {
                System.out.println(entry);
            }
        }
        return report;
    }

    public static List<String> generateReport2(Connection conn) throws SQLException {
        //popular meals
        System.out.println("\nTop 3 Popular Meals Report:");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT M.DishName, COUNT(R.MealChoice) as RegCNT FROM Meal M, Register R " +
                "WHERE M.BIN = R.BIN " + //bug
                "GROUP BY M.DishName " +
                "ORDER BY RegCNT DESC " +
                "FETCH FIRST 3 ROWS ONLY");

        List<String> popMeals = new ArrayList<>();
        boolean hasResults = false;

        while (rs.next()) {
            hasResults = true;
            String dishName = rs.getString("DishName");
            int count = rs.getInt("RegCNT");
            popMeals.add(count+"\t" +dishName);
        }
        if (!hasResults) {
            System.out.println("No meal registrations found.");
        } else {
            for (String dish : popMeals) {
                System.out.println(dish);
            }
        }
        return popMeals;
    }

}






