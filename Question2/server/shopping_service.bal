import ballerina/grpc;

// Define a gRPC listener on port 9090
listener grpc:Listener ep = new (9090);

// Arrays to store product, user, and cart data
Product[] products_data = [];
Users[] users_data = [];
Cart[] carts_data = [];

// Define the gRPC service descriptor for "Shopping"
@grpc:Descriptor {value: SHOP_DESC}
service "Shopping" on ep {

    // Remote function to list all products
    remote function ListProducts() returns ListProductsResponse|error {
        // Return all products stored in the products_data array
        return { products: products_data };
    }

    // Remote function to add a new product
    remote function AddProduct(Product value) returns ProductMessage|error {
        // Add the new product to the products_data array
        products_data.push(value);
        // Return success message
        return { message: "Product added successfully" };
    }

    // Remote function to update an existing product
    remote function UpdateProduct(Product value) returns ProductMessage|error {
        // Loop through the products_data array to find the product to update
        Product[] products = products_data;
        foreach var product in products {
            // If the product SKU matches, update the product details
            if product.sku == value.sku {
                product.name = value.name;
                product.description = value.description;
                product.price = value.price;
                // Return success message
                return { message: "Product updated successfully" };
            }
        }
        // If product is not found, return an error
        return error("Product not found");        
    }

    // Remote function to delete a product by SKU
    remote function DeleteProduct(string value) returns ProductMessage|error {
        // Variable to store the removed product, if found
        Product? removedProduct = null;
        // Loop through the products_data array to find the product to delete
        foreach Product product in products_data {
            int i = 0;
            // If SKU matches, remove the product
            if product.sku == value {
                removedProduct = products_data.remove(i);
            }
            i = i + 1;
        }
        // If product was successfully removed, return success message
        if removedProduct != null {
            return { message: "Product deleted successfully" + removedProduct.name };
        }
        else {
            // If product is not found, return an error
            return error("Product not found");
        }
    }

    // Remote function to get product details by SKU
    remote function GetProduct(string value) returns Product|error {
        // Loop through the products_data array to find the product by SKU
        foreach Product product in products_data {
            if product.sku == value {
                // Return the product details if found
                return product;
            }
        }
        // If product is not found, return an error
        return error("Product not found");
    }

    // Remote function to add a product to the cart
    remote function addtoCart(Cart value) returns CartMessage|error {
        // Add the product to the cart_data array
        carts_data.push(value);
        // Return success message
        return { message: "Product added to cart successfully" };
    }

    // Remote function to create a new user
    remote function createUsers(Users value) returns userCreationMessage|error {
        // Add the new user to the users_data array
        users_data.push(value);
        // Return success message
        return { message: "User created successfully" };
    }

    // Remote function to place an order
    remote function PlaceOrder(placeOrder value) returns CartMessage|error {
        // Return success message for placing an order
        return { message: "Order placed successfully" };
    }
}
