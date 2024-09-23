import ballerina/http;
import ballerina/time;

listener http:Listener httpListener = new (8080);

public type Programme record {|
    readonly string programme_code;
    int nqf_level;
    string faculty_name;
    string department_name;
    string programme_title;
    string reg_date;
    Course[] courses;
|};

public type Course record {|
    readonly string courseCode;
    string courseName;
    int nqf_level;
|};

public type FacultyNamesResponse record {
    string[] faculty_names;
};

public type ConflictingProgrammeCodesError record {|
    *http:Conflict;
    ErrorMsg body;
|};

public type InvalidProgrammeCodeError record {|
    *http:NotFound;
    ErrorMsg body;
|};

public type ErrorMsg record {|
    string errmsg;
|};

public final table<Programme> key(programme_code) programmeTable = table [
    {
        programme_code: "07BACS",
        nqf_level: 7,
        faculty_name: "Computing",
        department_name: "Software Engineering",
        programme_title: "Computer Science",
        reg_date: "2023-01-21",
        courses: [
            {
                courseCode: "WAD",
                courseName: "WEB APPLICATIONS AND DEVELOPMENT",
                nqf_level: 7
            },
            {
                courseCode: "PRG",
                courseName: "PROGRAMMING",
                nqf_level: 7
            },
            {
                courseCode: "WAS",
                courseName: "WEB APLLICATION SECURITY",
                nqf_level: 7
            }
        ]
    },
    {
        programme_code: "08HR",
        nqf_level: 8,
        faculty_name: "HUMAN RESOURCE",
        department_name: "Business",
        programme_title: "Bachelor of human resource",
        reg_date: "2018-09-15",
        courses: [
            {
                courseCode: "PG101",
                courseName: "public management",
                nqf_level: 8
            },
            {
                courseCode: "CV201",
                courseName: "CIVIL ENGINEERING",
                nqf_level: 7
            },
            {
                courseCode: "DBF301",
                courseName: "DATABASE FUNDAMENTALS",
                nqf_level: 8
            }
        ]
    }

];

service /pdu on httpListener {

    //Add a new programme
    resource function post programme(@http:Payload Programme programme) returns Programme|ConflictingProgrammeCodesError|error {
        if (programmeTable.hasKey(programme.programme_code)) {
            return {
                body: {
                    errmsg: "Programme exists"
                }
            };
        } else {

            //string reviewDate = check calculateReviewDate(programme.reg_date, 5); // 5 years from reg_date
            //programme.review_date = reviewDate;
            programmeTable.add(programme);
            return programme;
        }
    }

    //Retrieve a list of all programmes within the Programme Development Unit (PDU)
    resource function get programmes() returns Programme[] {
        return programmeTable.toArray();
    }

    //Retrieve details of a specific programme by programme code
    resource function get programme/[string programme_code]() returns Programme|InvalidProgrammeCodeError {
        Programme? programme = programmeTable[programme_code];
        if programme is () {
            return {
                body: {
                    errmsg: string `Invalid code: ${programme_code}`
                }
            };
        }
        return programme;
    }
