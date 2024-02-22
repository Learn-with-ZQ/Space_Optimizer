import requests

# URL of your friend's API
api_url = "http://:5000/optimize"  # Replace with the actual IP address

# Sample data to send to the API
data = {
    "dataList": [
        {"ShapeName": "Rectangle", "ShapeLength": 5, "ShapeWidth": 3, "Shape_Type": "Rectangle", "Quantity": 2},
        {"ShapeName": "Square", "ShapeLength": 4, "Shape_Type": "Square", "Quantity": 1}
    ],
    "shapeArray": [10, 10],  # Dimensions of the container
    "userID": 123  # Your user ID
}

try:
    # Make a POST request to the API
    response = requests.post(api_url, json=data)

    # Check if the request was successful (status code 200)
    if response.status_code == 200:
        # Print the response from the API
        print(response.json())
    else:
        print("Error:", response.text)

except Exception as e:
    print("Error:", e)
