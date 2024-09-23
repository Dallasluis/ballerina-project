import ballerina/http;
import ballerina/io;

string baseUrl = "http://localhost:8080/pdu";
http:Client pduclient = check new (baseUrl);

public type Programme record {|
    string programme_code;
    int nqf_level;
    string faculty_name;
    string department_name;
    string programme_title;
    string reg_date;
    //string review_date;
    Course[] courses;
|};

public type Course record {|
    string courseCode;
    string courseName;
    int nqf_level;
|};

public type FacultyNamesResponse record {
    string[] faculty_names;
};

public type ErrorMsg record {|
    string errmsg;
|};

// Helper function to read user input
function getInput(string prompt) returns string {
    io:print(prompt);
    string? userInput = io:readln();
    return userInput ?: "";
}

function addProgramme() returns Programme|ErrorMsg|error {
    io:println("\n***** Programme Info *****");

    // Capture programme details
    string programmeCode = getInput("\nEnter Programme Code: ");
    int nqfLevel = check getValidatedIntegerInput("Enter NQF Level (integer): ");
    string facultyName = getInput("Enter Faculty Name: ");
    string departmentName = getInput("Enter Department Name: ");
    string programmeTitle = getInput("Enter Programme Title: ");
    string regDate = getInput("Enter Registration Date (YYYY-MM-DD): ");

    io:println("\n***** Course Info *****");

    // Capture course details, handle errors if any
    Course[] courses = check collectCourses();

    // Programme creation
    Programme programme = {
        programme_code: programmeCode,
        nqf_level: nqfLevel,
        faculty_name: facultyName,
        department_name: departmentName,
        programme_title: programmeTitle,
        reg_date: regDate,
        courses: courses
    };

    // POST request to add the programme
    Programme|error response = pduclient->/programme.post(programme);
    if (response is Programme) {
        return response;
    } else {
        ErrorMsg errorMsg = {errmsg: "Failed to add the programme."};
        return errorMsg;
    }
}

// Function to retrieve all programmes from the server
function retrieveProgrammes() returns Programme[]|ErrorMsg|error {
    // Send a GET request to retrieve all programmes
    Programme[]|error response = pduclient->/programmes.get();

    // Check if the response is successful or contains an error
    if (response is Programme[]) {
        return response;
    } else {
        ErrorMsg errorMsg = {errmsg: "Failed to retrieve programmes."};
        return errorMsg;
    }
}

// Function to get a programme by code
function getProgrammeByCode(string programmeCode) returns Programme|ErrorMsg|error {
    Programme|error response = pduclient->get(string `/programme/${programmeCode}`);

    if (response is Programme) {
        return response;
    } else {
        ErrorMsg errorMsg = {errmsg: "Failed to retrieve programmes."};
        return errorMsg;
    }
}
