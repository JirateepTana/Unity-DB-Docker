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


if (isset($_GET['map_ID'])) {
    $map_ID = $_GET['map_ID'];

    // Prepare the SQL statement
    $stmt = $conn->prepare("
    SELECT a.user_ID, u.name, a.score, a.TimeTaken, DATE_FORMAT(Training_Date, '%Y-%m-%d') AS Date
    FROM (
            SELECT g.user_ID, g.gamelog_ID, g.score, JSON_UNQUOTE(JSON_EXTRACT(g.`condition`, '$.TimeTaken')) AS TimeTaken, Training_Date
            FROM gamelog g
            WHERE g.map_ID = ? AND g.gamelog_ID = (
                SELECT g1.gamelog_ID
                FROM gamelog g1
                WHERE g1.user_ID = g.user_ID AND g1.map_ID = g.map_ID
                ORDER BY g1.score DESC, JSON_UNQUOTE(JSON_EXTRACT(g1.`condition`, '$.TimeTaken')) ASC
                LIMIT 1
            )
        ) a
        LEFT JOIN userid u ON a.user_ID = u.userid
        ORDER BY score DESC, TimeTaken ASC;
    ");
    
    // Bind the map_ID parameter
    $stmt->bind_param('i', $map_ID);
    
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


// Close connection
$conn->close();
?>