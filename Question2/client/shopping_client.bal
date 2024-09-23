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
