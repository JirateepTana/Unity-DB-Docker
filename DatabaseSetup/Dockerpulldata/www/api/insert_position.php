<?php
// Database connection parameters
$servername = "mysql"; // Use the service name defined in docker-compose
$username = "myuser";
$password = "mypassword";
$dbname = "mydatabase";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get the JSON data from the request
$json = file_get_contents('php://input');
$data = json_decode($json, true);

// Prepare and bind
$stmt = $conn->prepare("INSERT INTO player_position_log (X, Y, Z) VALUES (?, ?, ?)");
$stmt->bind_param("ddd", $data['X'], $data['Y'], $data['Z']);

// Execute the statement
if ($stmt->execute()) {
    echo "New record created successfully";
} else {
    echo "Error: " . $stmt->error;
}

// Close the connection
$stmt->close();
$conn->close();
?>