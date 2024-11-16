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

if ($request_method == 'POST') {

    //check if there is a json data that send from the client
    if ($data === null) {
        http_response_code(400); // Bad Request
        die(json_encode(["error" => "Invalid JSON data"]));
    }
    // Check if the required data is present
    if (isset($data['google_mail']) && isset($data['email']) && isset($data['password']) && isset($data['name']) && isset($data['surname']) && isset($data['address']) && isset($data['age']) && isset($data['gender']) && isset($data['pin'])) {
        // Prepare the SQL statement
        $stmt = $conn->prepare("INSERT INTO userid (google_mail, email, password, name, surname, address, age, gender, pin) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("ssssssisi", $data['google_mail'], $data['email'], $data['password'], $data['name'], $data['surname'], $data['address'], $data['age'], $data['gender'], $data['pin']);

        // Execute the statement
       if ($stmt->execute()) {
            http_response_code(200); // Created
            echo json_encode(["message" => "New record created successfully"]);
        } else {
            http_response_code(500); // Internal Server Error
            echo json_encode(["error" => $stmt->error]);
        }

        // Close the statement
        $stmt->close();
    } else {
        http_response_code(400); // Bad Request
        echo json_encode(["error" => "Missing required data"]);
    }
} elseif ($request_method == 'GET') {
    // Check if the email parameter is present
    if (isset($_GET['email'])) {
        $email = $_GET['email'];

        // Prepare the SQL statement
        $stmt = $conn->prepare("SELECT * FROM userid WHERE email = ?");
        $stmt->bind_param("s", $email);

        if ($stmt->execute()) {
            $result = $stmt->get_result();
            if ($result->num_rows > 0) {
                // User found
                http_response_code(200); // OK
                echo json_encode($result->fetch_assoc());
            } else {
                // No user found
                http_response_code(404); // Not Found
                echo json_encode(["error" => "No user found with the provided email"]);
            }
        } else {
            // Error executing statement
            http_response_code(500); // Internal Server Error
            echo json_encode(["error" => $stmt->error]);
        }

        // Close the statement
        $stmt->close();
    } else {
        // Missing email parameter
        http_response_code(400); // Bad Request
        echo json_encode(["error" => "Missing email parameter"]);
    }
}

// Close connection
$conn->close();
?>