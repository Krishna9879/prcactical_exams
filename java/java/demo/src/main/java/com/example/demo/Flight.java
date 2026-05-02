package com.example.demo;

import java.sql.*;
import java.util.Scanner;

public class Flight {

    // MySQL connection details
    static final String URL = "jdbc:mysql://localhost:3306/airlinedb";
    static final String USER = "root";
    static final String PASSWORD = "12345";

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        System.out.print("Enter Flight ID: ");
        int flightId = sc.nextInt();
        sc.nextLine(); // consume newline

        System.out.print("Enter Passenger Name: ");
        String passengerName = sc.nextLine();

        System.out.print("Enter Number of Seats Requested: ");
        int seatsRequested = sc.nextInt();

        Connection conn = null;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            conn.setAutoCommit(false); // Start transaction

            // Step 1: Check available seats and price for the given flight_id
            String selectSQL = "SELECT available_seats, price_per_seat FROM flights WHERE flight_id = ?";
            PreparedStatement selectStmt = conn.prepareStatement(selectSQL);
            selectStmt.setInt(1, flightId);
            ResultSet rs = selectStmt.executeQuery();

            if (rs.next()) {
                int availableSeats = rs.getInt("available_seats");
                double pricePerSeat = rs.getDouble("price_per_seat");

                if (availableSeats >= seatsRequested) {
                    // Step 2: Deduct seats from flights table
                    String updateSQL = "UPDATE flights SET available_seats = available_seats - ? WHERE flight_id = ?";
                    PreparedStatement updateStmt = conn.prepareStatement(updateSQL);
                    updateStmt.setInt(1, seatsRequested);
                    updateStmt.setInt(2, flightId);
                    updateStmt.executeUpdate();

                    // Step 3: Insert booking record
                    double totalAmount = seatsRequested * pricePerSeat;
                    String insertSQL = "INSERT INTO bookings (passenger_name, flight_id, seats_booked, total_amount) VALUES (?, ?, ?, ?)";
                    PreparedStatement insertStmt = conn.prepareStatement(insertSQL);
                    insertStmt.setString(1, passengerName);
                    insertStmt.setInt(2, flightId);
                    insertStmt.setInt(3, seatsRequested);
                    insertStmt.setDouble(4, totalAmount);
                    insertStmt.executeUpdate();

                    conn.commit(); // Commit transaction
                    System.out.println("Booking Successful!");
                    System.out.println("Passenger: " + passengerName);
                    System.out.println("Seats Booked: " + seatsRequested);
                    System.out.println("Total Amount: Rs. " + totalAmount);
                } else {
                    conn.rollback(); // Rollback transaction
                    System.out.println("Booking Failed: Not enough seats available");
                }
            } else {
                conn.rollback();
                System.out.println("Flight not found with ID: " + flightId);
            }

        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            sc.close();
        }
    }
}
