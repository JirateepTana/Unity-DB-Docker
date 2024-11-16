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


if ($request_method == 'POST') {
    // Check if the required data is present
    if (isset($data['score']) && isset($data['condition']) && isset($data['map_ID']) && isset($data['user_ID'])) {
        // Convert the condition array to a JSON string
        $condition_json = json_encode($data['condition']);

        // Prepare the SQL statement
        $stmt = $conn->prepare("INSERT INTO gamelog (score, `condition`, map_ID, user_ID, `Training_Date`) VALUES (?, CAST(? AS JSON), ?, ?, CONVERT_TZ(CURRENT_TIMESTAMP, @@session.time_zone, '+07:00'))");
        $stmt->bind_param("dsii", $data['score'], $condition_json, $data['map_ID'], $data['user_ID']);
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
} elseif ($request_method == 'GET') {
    // Check if user_ID and map_ID are present
    if (isset($_GET['user_ID']) && isset($_GET['map_ID'])) {
        $user_ID = $_GET['user_ID'];
        $map_ID = $_GET['map_ID'];

        // Prepare the SQL statement
        $stmt = $conn->prepare("SELECT score, JSON_UNQUOTE(JSON_EXTRACT(`condition`, '$.TimeTaken')) AS TimeTaken, `Training_Date` FROM gamelog WHERE user_ID = ? AND map_ID = ?");
        $stmt->bind_param("ii", $user_ID, $map_ID);
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
    } else {
        echo "Error: Missing user_ID or map_ID parameter";
    }
}

// Close connection
$conn->close();
?>