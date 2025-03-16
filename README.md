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

## Step 2: Just run the script

 Execute SQL Script.

Note: In DBeaver if you wanna execute the whole script, you have to select all and then click execute.

Once completed, refresh the database schema in DBeaver to verify the imported tables and data.
