import java.io.*;
import java.sql.*;
import oracle.jdbc.driver.*;
import java.util.*;

public class bms {
    private static String LoginEmail = null;
    private static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) throws SQLException, IOException, InterruptedException {
        clearScreen();
        Console console = System.console();
        if (console == null) {
            System.out.println("No console available. Please run from a terminal.");
            return;
        }

        DriverManager.registerDriver(new OracleDriver());
        Connection conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@studora.comp.polyu.edu.hk:1521:dbms", "\"23088621d\"", "ftytjmee");

        System.out.print("Are you an admin (yes/no)? ");
        String role = console.readLine().trim().toLowerCase();

        if ("yes".equals(role)) {
            Admin admin = new Admin(conn);
            adminMenu(console, admin,conn);
        } else if ("no".equals(role)) {
            User user = new User(conn);
            userMenu(console, user, conn);
        }
        else {
            System.out.println("Invalid command.");
        }
        conn.close();
    }

    private static void adminMenu(Console console, Admin admin, Connection conn) throws SQLException {
        int choice = 0;
        try {
            while (true) {
            if (LoginEmail == null) {
                System.out.println("\n-------------------------");
                System.out.println("\n1. Login");
            } else {
                System.out.println("\n-------------------------");
                System.out.println("3. Display attendee");
                System.out.println("4. Display registration");
                System.out.println("5. Display banquet");
                System.out.println("6. Display meal");
                System.out.println("7. Search");
                System.out.println("8. Create new banquet (with meal)");
                System.out.println("9. Update banquet");
                System.out.println("10. Update meal");
                System.out.println("11. Generate report");

            }
            System.out.println("-1. Exit");
            System.out.print("Enter command: ");

            choice = scanner.nextInt();
            scanner.nextLine();

            switch (choice) {
                case 1:
                    login(scanner, admin.getConnection());
                    break;
                case 3:
                    if (LoginEmail != null) {
                        admin.displayAttendee();
                    }
                    break;
                case 4:
                    if (LoginEmail != null) {
                        admin.displayRegistration();
                    }
                    break;
                case 5:
                    if (LoginEmail != null) {
                        admin.displayBanquet();
                    }
                    break;
                case 6:
                    if (LoginEmail != null) {
                        admin.displayMeal();
                    }
                    break;
                case 7:
                    if (LoginEmail != null) {
                        System.out.print("Enter attendee email: ");
                        String email = console.readLine().trim();
                        admin.searchAttendeeByEmail(email);
                    }
                    break;
                case 8:
                    if (LoginEmail != null) {
                        admin.createNewBanquet(conn);
                    }
                    break;
                case 9:
                    if(LoginEmail != null){
                        Admin.updateBanquet();
                    }
                    break;

                case 10:
                    if (LoginEmail != null) {
                        admin.updateBanquetMeal();
                    }
                    break;
                case 11:
                    if (LoginEmail != null) {
                        admin.generateReport1(conn);
                        admin.generateReport2(conn);
                    }
                    break;
                case -1:
                    System.out.println("Exiting system. Goodbye!");
                    return;

                default:
                    System.out.println("Invalid command. Please enter a valid admin command or 'exit'.");
            }
        }
        } catch (InputMismatchException e) {
            System.out.println("Invalid input. Please enter an integer.");
            scanner.next();
        }
    }



    private static void userMenu(Console console, User user, Connection conn) throws SQLException {
        int choice = 0;
        try {
            while (true) {
            System.out.println("\n-------------------------");
            if (LoginEmail == null) {
                System.out.println("\n1. Create account");
                System.out.println("2. Login");
            }
            else {
                System.out.println("3. Update Profile");
                System.out.println("4. Register Banquet");
                System.out.println("5. Display banquet");
                System.out.println("6. Display meal");
                System.out.println("7. Search");
                System.out.println("8. Update meal choice/ drink choice/ remarks");
            }
            System.out.println("-1. Exit");
            System.out.print("Enter command: ");

            choice = scanner.nextInt();
            scanner.nextLine();

            switch (choice) {
                case 1:
                    createAccount(scanner, conn);
                    break;
                case 2:
                    login(scanner, conn);
                    break;
                case 3:
                    if (LoginEmail != null) {
                        updateProfile(scanner, conn);
                    }
                    break;
                case 4:
                    if (LoginEmail != null) {
                        registerForBanquet(scanner, conn);
                    }
                    break;
                case 5:
                    if (LoginEmail != null) {
                        new DisplayBanquet().displayAvailable(user.getConnection());
                    }
                    break;
                case 6:
                    if (LoginEmail != null) {
                        new DisplayMeal().display(user.getConnection());
                    }
                    break;
                case 7:
                    if (LoginEmail != null) {
                        user.searchByUser();
                    }
                    break;
                case 8:
                    if (LoginEmail != null){
                        updateChoice(scanner,conn);
                    }
                    break;
                case -1:
                    System.out.println("Exiting system. Goodbye!");
                    return;
                default:
                    System.out.println("Invalid command. Please enter a valid command.");
            }
        }
        } catch (InputMismatchException e) {
            System.out.println("Invalid input. Please enter an integer.");
            scanner.next();
        }
    }


    private static void createAccount(Scanner scanner, Connection conn) throws SQLException {
        System.out.println("\nCreate Account\n");
        boolean check = true;
        String firstname = "";
        while (check) {
            System.out.print("Enter your first name: ");
            firstname = scanner.nextLine().trim();
            check = false;
            if (!firstname.matches("[a-zA-Z]+")) {
                System.out.println("Invalid first name. Only English letters are allowed.");
                check = true;
            }
        }

        String lastname = "";
        while (!check) {
            System.out.print("Enter your last name: ");
            lastname = scanner.nextLine().trim();
            check = true;
            if (!lastname.matches("[a-zA-Z]+")) {
                System.out.println("Invalid last name. Only English letters are allowed.");
                check = false;
            }
        }

        System.out.print("Enter your address: ");
        String address = scanner.nextLine().trim();

        check = true;
        String attendeeType = "";
        String[] type = {"staff", "student", "alumni", "guest"};
        while (check) {
            System.out.print("Enter your attendee type (staff, student, alumni, guest): ");
            attendeeType = scanner.nextLine().trim().toLowerCase();
            for (String i : type) {
                if (i.equals(attendeeType)) {
                    check = false;
                    break;
                }
            }
            if (check) {
                System.out.println("Invalid attendee type. Please enter one of the following: staff, student, alumni, guest.");
            }
        }

        check = true;
        String email = "";
        while (check) {
            System.out.print("Enter your email: ");
            email = scanner.nextLine().trim();
            check = false;
            try {
                PreparedStatement a = conn.prepareStatement("SELECT AttendeeID FROM Attendee WHERE AttendeeID = ?");
                a.setString(1, email);
                ResultSet rs = a.executeQuery();
                while (rs.next()) {
                    System.err.println(rs.getString(1) + " was used by other people. \n");
                    check = true;
                }
                rs.close();
                a.close();
            } catch (SQLException e) {
                System.err.println("SQL error: " + e.getMessage());
            }

            if (!email.contains("@")) {
                System.out.println("Invalid email. It must contain @.");
                check = true;
            }
        }

        System.out.print("Enter your password: ");
        String password = scanner.nextLine().trim();

        check = true;
        String phoneNumber = "";
        while (check) {
            System.out.print("Enter your phone number: ");
            phoneNumber = scanner.nextLine().trim();
            check = false;
            if (!phoneNumber.matches("\\d{8}")) {
                System.out.println("Invalid phone number. Only an 8-digit number is allowed.");
                check = true;
            }
        }

        check = true;
        String affiliatedOrg = "";
        String[] org = {"PolyU", "SPEED", "HKCC", "Others"};
        while (check) {
            System.out.print("Enter your Affiliated Organization: ");
            affiliatedOrg = scanner.nextLine().trim();
            for (String i : org) {
                if (i.equals(affiliatedOrg)) {
                    check = false;
                    break;
                }
            }
            if (check) {
                System.out.println("Invalid Affiliated Organization. Please enter one of the following: PolyU, SPEED, HKCC, Others.");
            }
        }

        User user = new User(email, firstname, lastname, address, attendeeType, password, phoneNumber, affiliatedOrg);
        user.create(conn);
    }



    private static void login(Scanner scanner, Connection conn) throws SQLException {
        System.out.println("\nLogin\n");

        System.out.print("Enter your email: ");
        String email = scanner.nextLine();
        System.out.print("Enter your password: ");
        String password = scanner.nextLine();

        // Admin Login
        if (email.equals("admin@csdoor.comp.polyu.edu.hk") && password.equals("1234")) {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Attendee WHERE AttendeeID = ? AND PASSWORD = ?");
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                LoginEmail = email;
                System.out.println("Admin login successful. Welcome, admin.");
            } else {
                System.out.println("Admin login failed. Please try again.");
            }

            rs.close();
            stmt.close();
        } else {
            // User Login
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Attendee WHERE AttendeeID = ? AND PASSWORD = ?");
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                LoginEmail = email;
                System.out.println("Login successful. Welcome, " + rs.getString("FNAME") + " " + rs.getString("LNAME") + ".");
            } else {
                System.out.println("Login failed. Please try again.");
            }

            rs.close();
            stmt.close();
        }
    }




    private static void updateProfile(Scanner scanner, Connection conn) throws SQLException {
        String reqEmail = LoginEmail;
        System.out.println("Update Account details\n");
        boolean existcheck = true;
        String loop = "";
        String[] collist = {"ATTENDEEID", "FNAME", "LNAME", "PHONENUMBER", "ADDRESS", "ATTENDEETYPE", "PASSWORD", "AFFILIATEDORG"};
        String col = "";

        while (!loop.equals("-1")) {
            existcheck = true;
            while (existcheck) {
                System.err.println("Enter column name (AttendeeID/ FName/ LName/ PhoneNumber/ Address/ AttendeeType/ Password/ AffiliatedOrg): ");
                col = scanner.nextLine().toUpperCase().trim();
                existcheck = !Arrays.asList(collist).contains(col);  // Check if the input column name is valid
                if (existcheck) System.err.println("Please enter a correct column name! ");
            }

            existcheck = true;
            while (existcheck) {
                System.err.println("Enter new input: ");
                String input = scanner.nextLine().trim();
                try {
                    if (User.update(conn, reqEmail, col, input)) existcheck = false;
                } catch (SQLException e) {
                    System.err.println("SQL error: " + e.getMessage());
                }
            }

            System.err.println("Updated!\n");
            System.out.println("Type anything to update other column on this, or -1 to stop the update function.");
            loop = scanner.nextLine().trim();
        }
    }


    private static void registerForBanquet(Scanner scanner, Connection conn) throws SQLException {
        System.out.println("\nRegister for Banquet\n");

        String attendeeQuery = "SELECT COUNT(*) FROM Attendee WHERE AttendeeID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(attendeeQuery)) {
            stmt.setString(1, LoginEmail);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) == 0) {
                    System.out.println("AttendeeID not found. Please check and try again.");
                    return;
                }
            }
        }

        while (true) {
            System.out.print("Enter the BIN of the banquet you want to register for (-1 to exit): ");
            int bin = scanner.nextInt();
            scanner.nextLine();
            if (bin == -1) return;

            String banquetQuery = "SELECT * FROM Banquet WHERE BIN = ?";
            try (PreparedStatement stmt = conn.prepareStatement(banquetQuery)) {
                stmt.setInt(1, bin);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        int quota = rs.getInt("Quota");
                        System.out.printf("\nBanquet Information:\nBIN: %d\nBanquet Name: %s\nContact: %s %s\nMin Attendee: %d\nQuota: %d\nAvailable: %s\nDate and Time: %s\nAddress: %s\nLocation: %s\n\n",
                                rs.getInt("BIN"), rs.getString("BanquetName"), rs.getString("FNameContactStaff"),
                                rs.getString("LNameContactStaff"), rs.getInt("MinAttendee"), quota,
                                rs.getString("Available"), rs.getTimestamp("DateTime"), rs.getString("Address"),
                                rs.getString("Location"));
                        if (quota <= 0) {
                            System.out.println("The quota is full. Please enter another BIN.");
                            continue;
                        }
                    } else {
                        System.out.println("BIN not found. Please check and try again.");
                        continue;
                    }
                }
            }


            String mealQuery = "SELECT DishName FROM Meal WHERE BIN = ?";
            List<String> meals = new ArrayList<>();
            try (PreparedStatement stmt = conn.prepareStatement(mealQuery)) {
                stmt.setInt(1, bin);
                try (ResultSet rs = stmt.executeQuery()) {
                    System.out.println("Available meals:");
                    while (rs.next()) {
                        String dishName = rs.getString("DishName");
                        meals.add(dishName);
                        System.out.println(dishName);
                    }
                    if (meals.isEmpty()) {
                        System.out.println("No meals found for this banquet.");
                        return;
                    }
                }
            }

            System.out.print("Enter your Meal Choice, in exact letter cases (-1 to exit): ");
            String mealChoice = scanner.nextLine().trim();
            if (mealChoice.equals("-1")) return;
            if (!meals.contains(mealChoice)) {
                System.out.println("Invalid meal choice. Please choose from the available meals.");
                continue;
            }

            System.out.print("Enter your Drink Choice (-1 to exit): ");
            String drinkChoice = scanner.nextLine().trim();
            if (drinkChoice.equals("-1")) return;


            System.out.print("Enter any remarks (-1 to exit): ");
            String remarks = scanner.nextLine().trim();
            if (remarks.equals("-1")) return;

            String insertQuery = "INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(insertQuery)) {
                stmt.setString(1, LoginEmail);
                stmt.setInt(2, bin);
                stmt.setString(3, drinkChoice!= null ? drinkChoice : "no drink choice");
                stmt.setString(4, mealChoice);
                stmt.setString(5, remarks != null ? remarks : "no remarks");
                stmt.executeUpdate();
                System.out.println("Registration successful.");
            }
            break;
        }
    }
    private static void updateChoice(Scanner scanner, Connection conn) throws SQLException {
        System.out.println("\nUpdate Choice\n");

        String attendeeQuery = "SELECT BIN, DrinkChoice, MealChoice, Remarks FROM Register WHERE AttendeeID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(attendeeQuery)) {
            stmt.setString(1, LoginEmail);
            try (ResultSet rs = stmt.executeQuery()) {
                if (!rs.isBeforeFirst()) {
                    System.out.println("No banquets found for this AttendeeID.");
                    return;
                }

                System.out.println("Joined Banquets:");
                List<Integer> bins = new ArrayList<>();
                while (rs.next()) {
                    int bin = rs.getInt("BIN");
                    bins.add(bin);
                    System.out.printf("BIN: %d, Drink Choice: %s, Meal Choice: %s, Remarks: %s\n",
                            bin, rs.getString("DrinkChoice"), rs.getString("MealChoice"), rs.getString("Remarks"));
                }

                System.out.print("Enter the BIN of the banquet to update (-1 to exit): ");
                int selectedBin = scanner.nextInt();
                scanner.nextLine();
                if (selectedBin == -1) return;

                if (!bins.contains(selectedBin)) {
                    System.out.println("Invalid BIN. Please check and try again.");
                    return;
                }

                System.out.print("Enter 'DrinkChoice' or 'MealChoice' to update, or 'Remarks' to update remarks (-1 to exit): ");
                String fieldToUpdate = scanner.nextLine().trim();
                if (fieldToUpdate.equals("-1")) return;

                String newValue = "";
                switch (fieldToUpdate) {
                    case "DrinkChoice":
                        System.out.print("Enter new Drink Choice (-1 to exit): ");
                        newValue = scanner.nextLine().trim();
                        if (newValue.equals("-1")) return;
                        break;
                    case "MealChoice":
                        String mealQuery = "SELECT DishName FROM Meal WHERE BIN = ?";
                        List<String> meals = new ArrayList<>();
                        try (PreparedStatement mealStmt = conn.prepareStatement(mealQuery)) {
                            mealStmt.setInt(1, selectedBin);
                            try (ResultSet mealRs = mealStmt.executeQuery()) {
                                System.out.println("Available meals:");
                                while (mealRs.next()) {
                                    String dishName = mealRs.getString("DishName");
                                    meals.add(dishName);
                                    System.out.println(dishName);
                                }
                                if (meals.isEmpty()) {
                                    System.out.println("No meals found for this banquet.");
                                    return;
                                }
                            }
                        }

                        System.out.print("Enter new Meal Choice (exact name) (-1 to exit): ");
                        newValue = scanner.nextLine().trim();
                        if (newValue.equals("-1")) return;
                        if (!meals.contains(newValue)) {
                            System.out.println("Invalid meal choice. Please choose from the available meals.");
                            return;
                        }
                        break;
                    case "Remarks":
                        System.out.print("Enter new Remarks (-1 to exit): ");
                        newValue = scanner.nextLine().trim();
                        if (newValue.equals("-1")) return;
                        break;
                    default:
                        System.out.println("Invalid choice. Please enter 'DrinkChoice', 'MealChoice', or 'Remarks'.");
                        return;
                }

                String updateQuery = "UPDATE Register SET " + fieldToUpdate + " = ? WHERE AttendeeID = ? AND BIN = ?";
                try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                    updateStmt.setString(1, newValue);
                    updateStmt.setString(2, LoginEmail);
                    updateStmt.setInt(3, selectedBin);
                    updateStmt.executeUpdate();
                    System.out.println("Update successful.");
                }
            }
        }
    }


    static void clearScreen() throws IOException, InterruptedException {
        if (System.getProperty("os.name").contains("Windows"))
            new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
        else
            System.out.print("\033[H\033[2J");}}