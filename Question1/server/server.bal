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

    //Update an existing programme's information according to the programme code
    resource function put updateProgramme/[string programme_code](@http:Payload Programme programme) returns InvalidProgrammeCodeError|error|Programme {
        Programme? existingProgramme = programmeTable[programme_code];

        if (existingProgramme is Programme) {
            // Update the existing programme details
            existingProgramme.nqf_level = programme.nqf_level;
            existingProgramme.faculty_name = programme.faculty_name;
            existingProgramme.department_name = programme.department_name;
            existingProgramme.courses = programme.courses;

            // Update programme_title only if provided and not empty
            if (programme.programme_title != "") {
                existingProgramme.programme_title = programme.programme_title;
            }

            // Update reg_date only if provided and not empty
            if (programme.reg_date != "") {
                existingProgramme.reg_date = programme.reg_date;
            }
            // Put the updated programme back into the table
            programmeTable.put(existingProgramme);

            return existingProgramme;
        } else {
            return {
                body: {
                    errmsg: string `Invalid code: ${programme_code}`
                }
            };
        }
    }

    // Delete a specific programme by programme code
    resource function delete deleteProgram/[string programme_code]() returns http:Ok|error {

        Programme? removed = programmeTable.remove(programme_code);

        if (removed is Programme) {
            return http:OK;
        } else {
            return {
                body: {
                    errmsg: string `Invalid code: ${programme_code}`
                }
            };
        }
    }

    //Retrieve all the programmes that belong to the same faculty
    resource function get programmes/faculty/[string faculty_name]() returns Programme[]|ErrorMsg {
        Programme[] facultyProgrammes = from Programme programme in programmeTable
            where programme.faculty_name == faculty_name
            select programme;

        if facultyProgrammes.length() > 0 {
            return facultyProgrammes;
        } else {
            return {
                errmsg: "No programmes found."
            };
        }
    }
