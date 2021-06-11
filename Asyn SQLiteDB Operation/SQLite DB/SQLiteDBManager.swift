//
//  SQLiteDBManager.swift
//  Asyn SQLiteDB Operation
//
//  Created by unthinkable-mac-0025 on 11/06/21.
//


import Foundation
import SQLite3

class SQLiteManager {
    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    func deleteDataFromDB(with userName : String) {
        
        let deleteStatementString = "DELETE FROM Users WHERE userName = '\(userName)';"
        var deleteStatement: OpaquePointer?
        if sqlite3_prepare_v2(dbQueue, deleteStatementString, -1, &deleteStatement, nil) ==
            SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("\nCould not delete row.")
            }
        } else {
            print("\nDELETE statement could not be prepared")
        }
        
        sqlite3_finalize(deleteStatement)
    }//:deleteQuery
    
    func insertDataToDB(_ userName : String)  {
        //INSERT QUERY
        let insertStatementString = "INSERT INTO Users (userName) VALUES (?);"

        var insertStatementQuery : OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, insertStatementString, -1, &insertStatementQuery, nil)) == SQLITE_OK{
            sqlite3_bind_text(insertStatementQuery, 1, userName , -1 , SQLITE_TRANSIENT)
            

            if(sqlite3_step(insertStatementQuery)) == SQLITE_DONE{
                print("Successfully Inserted the Records")
            }else{
                print("Error inserting the records")
            }

            sqlite3_finalize(insertStatementQuery)
        }
    } //:insertDataToDB

}
