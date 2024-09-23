import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;
import ballerina/protobuf.types.wrappers;

public const string SHOP_DESC = "0A0A73686F702E70726F746F120873686F7070696E671A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22A6010A0750726F6475637412120A046E616D6518012001280952046E616D6512200A0B6465736372697074696F6E180220012809520B6465736372697074696F6E12140A0570726963651803200128055205707269636512250A0E73746F636B5F7175616E74697479180420012805520D73746F636B5175616E7469747912160A06737461747573180520012809520673746174757312100A03736B751806200128095203736B75222B0A055573657273120E0A0269641801200128095202696412120A04726F6C651802200128095204726F6C65222A0A0E50726F647563744D65737361676512180A076D65737361676518012001280952076D657373616765222F0A13757365724372656174696F6E4D65737361676512180A076D65737361676518012001280952076D65737361676522450A144C69737450726F6475637473526573706F6E7365122D0A0870726F647563747318012003280B32112E73686F7070696E672E50726F64756374520870726F647563747322280A044361727412100A03736B751801200128095203736B75120E0A0269641802200128095202696422270A0B436172744D65737361676512180A076D65737361676518012001280952076D65737361676522260A0A706C6163654F7264657212180A076D65737361676518012001280952076D6573736167653281040A0853686F7070696E6712460A0C4C69737450726F647563747312162E676F6F676C652E70726F746F6275662E456D7074791A1E2E73686F7070696E672E4C69737450726F6475637473526573706F6E736512390A0A41646450726F6475637412112E73686F7070696E672E50726F647563741A182E73686F7070696E672E50726F647563744D657373616765123C0A0D55706461746550726F6475637412112E73686F7070696E672E50726F647563741A182E73686F7070696E672E50726F647563744D65737361676512470A0D44656C65746550726F64756374121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A182E73686F7070696E672E50726F647563744D657373616765123D0A0A47657450726F64756374121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A112E73686F7070696E672E50726F6475637412320A09616464746F43617274120E2E73686F7070696E672E436172741A152E73686F7070696E672E436172744D657373616765123D0A0B6372656174655573657273120F2E73686F7070696E672E55736572731A1D2E73686F7070696E672E757365724372656174696F6E4D65737361676512390A0A506C6163654F7264657212142E73686F7070696E672E706C6163654F726465721A152E73686F7070696E672E436172744D657373616765620670726F746F33";

public isolated client class ShoppingClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, SHOP_DESC);
    }

    isolated remote function ListProducts() returns ListProductsResponse|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeSimpleRPC("shopping.Shopping/ListProducts", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListProductsResponse>result;
    }

    isolated remote function ListProductsContext() returns ContextListProductsResponse|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeSimpleRPC("shopping.Shopping/ListProducts", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListProductsResponse>result, headers: respHeaders};
    }

    isolated remote function AddProduct(Product|ContextProduct req) returns ProductMessage|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.Shopping/AddProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductMessage>result;
    }

    isolated remote function AddProductContext(Product|ContextProduct req) returns ContextProductMessage|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.Shopping/AddProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductMessage>result, headers: respHeaders};
    }

    isolated remote function UpdateProduct(Product|ContextProduct req) returns ProductMessage|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.Shopping/UpdateProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductMessage>result;
    }

    isolated remote function UpdateProductContext(Product|ContextProduct req) returns ContextProductMessage|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.Shopping/UpdateProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductMessage>result, headers: respHeaders};
    }

    isolated remote function DeleteProduct(string|wrappers:ContextString req) returns ProductMessage|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.Shopping/DeleteProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductMessage>result;
    }

    isolated remote function DeleteProductContext(string|wrappers:ContextString req) returns ContextProductMessage|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.Shopping/DeleteProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductMessage>result, headers: respHeaders};
    }

    isolated remote function GetProduct(string|wrappers:ContextString req) returns Product|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.Shopping/GetProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Product>result;
    }

    isolated remote function GetProductContext(string|wrappers:ContextString req) returns ContextProduct|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.Shopping/GetProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Product>result, headers: respHeaders};
    }

    isolated remote function addtoCart(Cart|ContextCart req) returns CartMessage|grpc:Error {
        map<string|string[]> headers = {};
        Cart message;
        if req is ContextCart {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.Shopping/addtoCart", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CartMessage>result;
    }

    isolated remote function addtoCartContext(Cart|ContextCart req) returns ContextCartMessage|grpc:Error {
        map<string|string[]> headers = {};
        Cart message;
        if req is ContextCart {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.Shopping/addtoCart", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CartMessage>result, headers: respHeaders};
    }

    isolated remote function createUsers(Users|ContextUsers req) returns userCreationMessage|grpc:Error {
        map<string|string[]> headers = {};
        Users message;
        if req is ContextUsers {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.Shopping/createUsers", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <userCreationMessage>result;
    }

    isolated remote function createUsersContext(Users|ContextUsers req) returns ContextUserCreationMessage|grpc:Error {
        map<string|string[]> headers = {};
        Users message;
        if req is ContextUsers {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.Shopping/createUsers", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <userCreationMessage>result, headers: respHeaders};
    }

    isolated remote function PlaceOrder(placeOrder|ContextPlaceOrder req) returns CartMessage|grpc:Error {
        map<string|string[]> headers = {};
        placeOrder message;
        if req is ContextPlaceOrder {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.Shopping/PlaceOrder", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CartMessage>result;
    }

    isolated remote function PlaceOrderContext(placeOrder|ContextPlaceOrder req) returns ContextCartMessage|grpc:Error {
        map<string|string[]> headers = {};
        placeOrder message;
        if req is ContextPlaceOrder {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.Shopping/PlaceOrder", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CartMessage>result, headers: respHeaders};
    }
}

public isolated client class ShoppingUserCreationMessageCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendUserCreationMessage(userCreationMessage response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextUserCreationMessage(ContextUserCreationMessage response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingProductCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendProduct(Product response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextProduct(ContextProduct response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingProductMessageCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendProductMessage(ProductMessage response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextProductMessage(ContextProductMessage response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingListProductsResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendListProductsResponse(ListProductsResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextListProductsResponse(ContextListProductsResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingCartMessageCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCartMessage(CartMessage response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCartMessage(ContextCartMessage response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextCartMessage record {|
    CartMessage content;
    map<string|string[]> headers;
|};

public type ContextPlaceOrder record {|
    placeOrder content;
    map<string|string[]> headers;
|};

public type ContextListProductsResponse record {|
    ListProductsResponse content;
    map<string|string[]> headers;
|};

public type ContextProduct record {|
    Product content;
    map<string|string[]> headers;
|};

public type ContextUsers record {|
    Users content;
    map<string|string[]> headers;
|};

public type ContextUserCreationMessage record {|
    userCreationMessage content;
    map<string|string[]> headers;
|};

public type ContextProductMessage record {|
    ProductMessage content;
    map<string|string[]> headers;
|};

public type ContextCart record {|
    Cart content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type CartMessage record {|
    string message = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type placeOrder record {|
    string message = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type Product record {|
    string name = "";
    string description = "";
    int price = 0;
    int stock_quantity = 0;
    string status = "";
    string sku = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type ListProductsResponse record {|
    Product[] products = [];
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type Users record {|
    string id = "";
    string role = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type userCreationMessage record {|
    string message = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type ProductMessage record {|
    string message = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type Cart record {|
    string sku = "";
    string id = "";
|};

