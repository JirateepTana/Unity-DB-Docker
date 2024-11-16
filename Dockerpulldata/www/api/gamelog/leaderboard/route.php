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
// if ($data === null) {
//     die("Error: Invalid JSON data");git
// }


if ($request_method == 'GET') {
    // Check if map_ID is present
    if (isset($_GET['map_ID'])) {
        $map_ID = $_GET['map_ID'];

        // Prepare the SQL statement
        $stmt = $conn->prepare("
            SELECT DISTINCT user_ID, MAX(score) AS highest_score, MIN(JSON_UNQUOTE(JSON_EXTRACT(`condition`, '$.TimeTaken'))) AS min_TimeTaken
            FROM gamelog
            WHERE map_ID = ?
            GROUP BY user_ID
            ORDER BY highest_score DESC, min_TimeTaken ASC
        ");
        $stmt->bind_param("i", $map_ID);
        
        // Execute the statement
        if ($stmt->execute()) {
            $result = $stmt->get_result();
            $data = $result->fetch_all(MYSQLI_ASSOC);
            echo json_encode($data);
        } else {
            echo "Error: " . $stmt->error;
        }

        // Close the statement
        $stmt->close();
    }
}

// Close connection
$conn->close();
?>