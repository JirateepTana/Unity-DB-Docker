<?php
// Database connection parameters
$servername = "mysql"; // Use the service name defined in docker-compose
$username = "1";
$password = "1";
$dbname = "mydatabase";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check the request method
$request_method = $_SERVER['REQUEST_METHOD'];

// Get the input data
$data = json_decode(file_get_contents('php://input'), true);

// Check if the data is correctly decoded
if ($data === null) {
    die("Error: Invalid JSON data");
}

if ($request_method == 'POST') {
    // Check if the required data is present
   if (isset($data['gender_ID']) && isset($data['gender_name'])) {
        // Prepare the SQL statement
        $stmt = $conn->prepare("INSERT INTO gender (gender_ID, gender_name) VALUES (?, ?)");
        $stmt->bind_param("is", $data['gender_ID'], $data['gender_name']);

        // Execute the statement
        if ($stmt->execute()) {
            echo "New map record created successfully";
        } else {
            echo "Error: " . $stmt->error;
        }

        // Close the statement
        $stmt->close();
    } else {
        echo "Error: Missing required data";
    }
}

// Close connection
$conn->close();
?>