import mysql.connector
import json

# Database connection parameters
conn_params = {
    'database': 'mydatabase',  # Changed from 'dbname' to 'database'
    'user': 'myuser',
    'password': 'mypassword',
    'host': 'localhost',  # Connect to the Docker container
    'port': '3306'
}

# Connect to the MySQL database
conn = mysql.connector.connect(**conn_params)
cur = conn.cursor()


# Load JSON data from file
with open('C:\\UnityBuild\\datalogging\\player_position_log.json', 'r') as file:  # Adjusted path for local machine
    data = json.load(file)

# Insert data into the table
for record in data:
    # Assuming the table and columns are named appropriately
    cur.execute(
        "INSERT INTO player_position_log (X, Y, Z) VALUES (%s, %s, %s)",
        (record['X'], record['Y'], record['Z'])
    )

# Commit the transaction
conn.commit()

# Close the cursor and connection
cur.close()
conn.close()