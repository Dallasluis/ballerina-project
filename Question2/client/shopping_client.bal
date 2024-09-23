import ballerina/io;

// Initialize the gRPC client to connect to the Shopping service at localhost:9090
ShoppingClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    // Continuously display the menu and prompt for user input
    while true {
        // Print the shopping system menu
        io:println("\n--- Online Shopping System ---");
        io:println("1. List Products");
        io:println("2. Add Product");
        io:println("3. Update Product");
        io:println("4. Delete Product");
        io:println("5. Get Product");
        io:println("6. Add to Cart");
        io:println("7. Create User");
        io:println("8. Place Order");
        io:println("9. Exit");

        // Read user input and convert to integer to choose an option
        int choice = check int:fromString(io:readln());

        // Match the user's choice and perform the corresponding operation
        match choice {
            1 => {
                // List all products by calling the ListProducts service
                ListProductsResponse listProductsResponse = check ep->ListProducts();
                io:println("Available Products: ", listProductsResponse);
            }
            2 => {
                // Add a new product by prompting the user for product details
                io:println("Enter Product Name:");
                string name = io:readln();
                string sku =  io:readln("Enter Product SKU:");
                string description = io:readln("Enter Product Description:");
                int price = check int:fromString(io:readln("Enter Product Price:"));
                int stock_quantity = check int:fromString(io:readln("Enter Stock Quantity"));
                string status = io:readln("Enter Product Status:");

                // Create a new product object with the provided details
                Product newProduct = {
                    name: name,
                    description: description,
                    price: price,
                    stock_quantity: stock_quantity,
                    status: status,
                    sku: sku
                };


                // Call the AddProduct service and print the response
                ProductMessage response = check ep->AddProduct(newProduct);
                io:println("Response: ", response.message);
            }
            3 => {
                // Update an existing product by prompting for SKU and new details
                io:println("Enter Product SKU to Update:");
                string sku =  io:readln();
                string name = io:readln();
                string description = io:readln();
                int price = check int:fromString(io:readln());
                int stock_quantity = check int:fromString(io:readln());
                string status = io:readln();

                // Create an updated product object
                Product updatedProduct = {
                    name: name,
                    description: description,
                    price: price,
                    stock_quantity: stock_quantity,
                    status: status,
                    sku: sku
                };

                // Call the UpdateProduct service and print the response
                ProductMessage response = check ep->UpdateProduct(updatedProduct);
                io:println("Response: ", response.message);
            }
            4 => {
                // Delete a product by prompting for the SKU
                io:println("Enter Product SKU to Delete:");
                string sku =  io:readln();

                // Call the DeleteProduct service and print the response
                ProductMessage response = check ep->DeleteProduct(sku);
                io:println("Response: ", response.message);
            }
            5 => {
                // Retrieve product details by SKU
                io:println("Enter Product SKU to Retrieve:");
                string sku = io:readln();

                // Call the GetProduct service and print the product details
                Product product = check ep->GetProduct(sku);
                io:println("Product Details: ", product);
            }
            6 => {
                // Add a product to the cart by providing SKU and Cart ID
                io:println("Enter Product SKU to Add to Cart:");
                string sku = io:readln();
                string cart_id = io:readln("Enter Cart ID:");

                // Create a Cart object and call the addtoCart service
                Cart cartItem = {sku: sku, id: cart_id};
                CartMessage response = check ep->addtoCart(cartItem);
                io:println("Response: ", response.message);
            }
            7 => {
                // Create a new user by prompting for user ID
                io:println("Enter User ID to Create:");
                string userId = io:readln();

                // Create a new Users object and call the createUsers service
                Users newUser = {id: userId, role: "customer"};
                userCreationMessage response = check ep->createUsers(newUser);
                io:println("Response: ", response.message);
            }
            8 => {
                // Place an order by providing the Order ID (user's ID)
                io:println("Enter Order ID to Place:");
                string userId = io:readln();

                // Create a placeOrder object and call the PlaceOrder service
                placeOrder orderRequest = {message: "Order for "+ userId};
                CartMessage response = check ep->PlaceOrder(orderRequest);
                io:println("Response: ", response.message);
            }
            9 => {
                // Exit the program
                io:println("Exiting...");
                break;
            }
            // Handle invalid option input
            _ => {io:println("Invalid choice! Please try again.");}
        }
    }
}
