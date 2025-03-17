## A Time Tracking App


![image](https://github.com/user-attachments/assets/ea58d831-86ec-4683-9aca-0260ed0a1d41)



## Database Setup

To run this project, you will need to set up the PostgreSQL database using the provided files in the example_database directory.

## Introduction

This documentation provides instructions on how to import and use the example database in DBeaver with a PostgreSQL database. This database is intended for testing and demonstration purposes.

## Prerequisites

Before proceeding, ensure you have the following installed:

PostgreSQL (Make sure the PostgreSQL server is running)

DBeaver (Community or Enterprise edition)

A valid PostgreSQL database connection in DBeaver

## Importing the Example Database

## Step 1: Connect to PostgreSQL in DBeaver

Open DBeaver.

Click on Database > New Connection.

Select PostgreSQL from the available database types.

Enter the following details:

Host: localhost (or the appropriate hostname/IP)

Port: 5432 (default PostgreSQL port)

Database: Your target database name

User: Your PostgreSQL username

Password: Your PostgreSQL password

Click Test Connection to verify the connection.

If successful, click Finish.

## Step 2: Import the Example Database

Download the example database file (dump-time_tracking-202503161325.sql) from the example_database directory.

Open DBeaver and ensure you're connected to your PostgreSQL database. See if you have any schemas named public (delete it if you have one) the script would generate that automatically, make sure to delete it, so the script can run successfully.

## Step 3: Simply Run The Script

 Execute SQL Script.

Note: In DBeaver if you wanna execute the whole script, you have to select all and then click execute.

Once completed, refresh the database schema in DBeaver to verify the imported tables and data.


## Starting The Program

## Step 1:
Open the project on a code editor, idealy IntelliJ for simplicity. On IntelliJ navigate to this location GrassauTime/src/main/resources/ and then open application.properties.
## Step 2:
In application.properties find this line:
spring.datasource.url=jdbc:postgresql://localhost:5432/time_tracking
In here replace the time_tracking with your database name.
Note: if you just installed DBeaver and didn't sepcified any name for your database connection yourself it's probably gonna be postgres, if thats the case your code would look like this:
spring.datasource.url=jdbc:postgresql://localhost:5432/postgres
Also add your password for your connection in this line, in case you have one:
spring.datasource.password=

## Step 3: Run The Program
After running the program, open a browser and type: http://localhost:8080/

## How To Login:
You can login with the accounts below:
## user Account
username: test
password: 1234
## Admin Account
username: administrator
password: Test2020#


## Troubleshooting
If for some reason you get the package not found error you can try the solution below:
Open the maven tab on the right side of the screen, click execute maven and then choose mvn package, now your program should work.
If for some reason you still have problem starting the program, here is a link that might help you: https://stackoverflow.com/questions/20137020/why-does-intellij-give-me-package-doesnt-exist-error
