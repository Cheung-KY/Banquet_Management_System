import java.sql.*;
import java.util.*;

abstract class Display {
    public abstract void display(Connection conn) throws SQLException;

    protected void displayResults(Connection conn, String query) throws SQLException {
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet rset = stmt.executeQuery(query);

        ResultSetMetaData metaData = rset.getMetaData();
        int columnCount = metaData.getColumnCount();
        List<Integer> columnWidths = new ArrayList<>();

        for (int i = 1; i <= columnCount; i++) {
            columnWidths.add(metaData.getColumnName(i).length());
        }

        while (rset.next()) {
            for (int i = 1; i <= columnCount; i++) {
                int length = rset.getString(i) != null ? rset.getString(i).length() : 4;
                columnWidths.set(i - 1, Math.max(columnWidths.get(i - 1), length));
            }
        }

        for (int i = 1; i <= columnCount; i++) {
            System.out.printf("%-" + (columnWidths.get(i - 1) + 2) + "s", metaData.getColumnName(i));
        }
        System.out.println();

        for (int width : columnWidths) {
            System.out.print(String.join("", Collections.nCopies(width + 2, "-")));
        }
        System.out.println();

        rset.beforeFirst();
        while (rset.next()) {
            for (int i = 1; i <= columnCount; i++) {
                String value = rset.getString(i) != null ? rset.getString(i) : "NULL";
                System.out.printf("%-" + (columnWidths.get(i - 1) + 2) + "s", value);
            }
            System.out.println();
        }

        rset.close();
        stmt.close();
    }
}

class DisplayBanquet extends Display {
    @Override
    public void display(Connection conn) throws SQLException {
        String query = "SELECT B.BIN, B.BanquetName, B.FNameContactStaff, B.LNameContactStaff, B.MinAttendee, B.Quota, B.Available, B.DateTime, B.Address, B.Location, M.DishName, M.Type, M.Price, M.SpecialCuisine " +
                "FROM Banquet B " +
                "LEFT JOIN Meal M ON B.BIN = M.BIN " +
                "ORDER BY B.BIN";
        displayResults(conn, query);
    }

    @Override
    protected void displayResults(Connection conn, String query) throws SQLException {
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet rset = stmt.executeQuery(query);

        ResultSetMetaData metaData = rset.getMetaData();
        int columnCount = metaData.getColumnCount();
        Map<Integer, List<String>> banquetDetails = new LinkedHashMap<>();
        Map<Integer, List<String>> banquetMeals = new LinkedHashMap<>();

        while (rset.next()) {
            int bin = rset.getInt("BIN");
            if (!banquetDetails.containsKey(bin)) {
                banquetDetails.put(bin, new ArrayList<>());
                for (int i = 1; i <= 10; i++) {
                    banquetDetails.get(bin).add(rset.getString(i));
                }
            }
            if (rset.getString("DISHNAME") != null) {
                if (!banquetMeals.containsKey(bin)) {
                    banquetMeals.put(bin, new ArrayList<>());
                }
                banquetMeals.get(bin).add(String.format("%-20s %-10s %-5s %-15s",
                        rset.getString("DISHNAME"),
                        rset.getString("TYPE"),
                        rset.getString("PRICE"),
                        rset.getString("SPECIALCUISINE")));
            }
        }

        for (int bin : banquetDetails.keySet()) {
            List<String> details = banquetDetails.get(bin);
            System.out.printf("%-4s %-20s %-20s %-20s %-10s %-6s %-10s %-19s %-15s %-10s\n",
                    details.get(0), details.get(1), details.get(2), details.get(3), details.get(4),
                    details.get(5), details.get(6), details.get(7), details.get(8), details.get(9));
            if (banquetMeals.containsKey(bin)) {
                for (String meal : banquetMeals.get(bin)) {
                    System.out.println("  " + meal);
                }
            } else {
                System.out.println("  No meals associated.");
            }
            System.out.println();
        }

        rset.close();
        stmt.close();
    }

    public void displayAvailable(Connection conn) throws SQLException {
        String query = "SELECT B.BIN, B.BanquetName, B.FNameContactStaff, B.LNameContactStaff, B.MinAttendee, B.Quota, B.Available, B.DateTime, B.Address, B.Location, M.DishName, M.Type, M.Price, M.SpecialCuisine " +
                "FROM Banquet B " +
                "LEFT JOIN Meal M ON B.BIN = M.BIN " +
                "WHERE B.Available = 'Y' " +
                "ORDER BY B.BIN";
        displayResults(conn, query);
    }
}






class DisplayAttendee extends Display {
    @Override
    public void display(Connection conn) throws SQLException {
        displayResults(conn, "SELECT * FROM Attendee");
    }
}

class DisplayMeal extends Display {
    @Override
    public void display(Connection conn) throws SQLException {
        displayResults(conn, "SELECT * FROM Meal");
    }
}

class DisplayRegister extends Display {
    @Override
    public void display(Connection conn) throws SQLException {
        displayResults(conn, "SELECT * FROM Register");}}

