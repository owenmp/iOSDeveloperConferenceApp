//
//  DBAccess.swift
//  FinalDesignProto
//
//  Created by Owen Malcolmson-Priest on 15/11/2019.
//  Copyright © 2019 Owen Malcolmson-Priest. All rights reserved.
//

import Foundation
import SQLite3

private let _hiddenSharedInstance = DBAccess()

/**
 Sessions that are read in but can also be bookmarked
 */
struct session: Codable {
    var id: String
    var content: String
    var sessionDate: String
    // var sessionOrder: Int
    var timeEnd: String
    var sessionType: String
    var speaker: String
    var title : String
    var time : String
    var location : String
    
    
    
    
    
}

//Read in from SQL
struct speakers {
    var name: String
    var photo: String
    var twitter : String
    var bio : String
    
}




class DBAccess{
    
   
    class var sharedInstance: DBAccess{
        return _hiddenSharedInstance;
    }
   
    // This is a pointer to the database
    var mySQLDB: OpaquePointer? = nil
 
    //Runs when app starts, loads bookmark strings
    init(){
        
        getBookmarks()
        //bookmarkTitle()
        openSQLDB()
    }
   

    //Opens connection to the conf.sql database
    func openSQLDB(){
        //Set up path to DB, and open
        let bundle = Bundle.main
        guard let defaultDBPath = bundle.path( forResource: "conf", ofType: "sql")
            else {
                assertionFailure( "Couldn't find database path")
                return
        }
        guard sqlite3_open_v2( defaultDBPath, &mySQLDB, SQLITE_OPEN_READONLY, nil) == SQLITE_OK
            else {
                assertionFailure( "Couldn't open database")
                return
        }
    }

    
    //Used to return string fields from the database
    func stringAtField(_ statementPointer: OpaquePointer, fieldIndex: Int ) -> String {
        var answer = "Error - DBAccess failed"
        if let rawString = sqlite3_column_text(statementPointer, Int32(fieldIndex) ) {
            answer = String(cString: rawString)
        }
        return answer
    }
    
    
    //Takes in a location name, returns the coordinates from the database
    func getCoOrds(location: String) ->[String]{
        //array will take in two values, longitude and latitude
        var coords: [String] = []
        //Query uses the location parameter to determine what coordinates are needed
        let query = "SELECT latitude,longitude FROM locations WHERE id = '" + location + "'"
        var statement: OpaquePointer? = nil  // Pointer for sql to track returns
        if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
          while(sqlite3_step(statement) == SQLITE_ROW){
            //Both taken in as strings because they can be passed into apple maps this way
            let longitude = stringAtField(statement!, fieldIndex: 0)
            let latitude = stringAtField(statement!, fieldIndex: 1)
            coords.append(longitude)
            coords.append(latitude)
            }
            
    
            }
        //When this is called, it will return an array of the long and lat values
        return coords
    }
    

    /**
     This function is used to get all the sessions from the Monday, it was easier to split this process up into days, as it was then easier to to find the amount of rows needed for each section
     */
    
    func getMonday () -> [session ]{
        //This monday array will be returned, and it is made up of all the sessions on the monday
        var Monday: [session] = []
        //This is the variable that will hold the details of the session when it is called from the database
        var myLesson: session!
        
        let query = "SELECT * FROM SESSIONS WHERE sessionDate = '2019-12-10'"
        var statement: OpaquePointer? = nil  // Pointer for sql to track returns
      if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
        while(sqlite3_step(statement) == SQLITE_ROW){
//            if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
//            if sqlite3_step(statement) == SQLITE_ROW {
                //All of these variables take in the values at each individual column.
                let id = stringAtField(statement!, fieldIndex: 0)
                let title = stringAtField(statement!, fieldIndex: 1)
                let content = stringAtField(statement!, fieldIndex: 2)
                let location = stringAtField(statement!, fieldIndex: 3)
                let sessionDate = stringAtField(statement!, fieldIndex: 4)
            let timeStart = stringAtField(statement!, fieldIndex: 6)
            let timeEnd = stringAtField(statement!, fieldIndex: 7)
               // let locationid = stringAtField(statement!, fieldIndex: 6)
            let sessionType = stringAtField(statement!, fieldIndex: 8)
            let speakerID = stringAtField(statement!, fieldIndex: 9)
            //Once all the variables are initialised, a struct is created using these values
            myLesson = session(id: id, content: content, sessionDate: sessionDate, timeEnd: timeEnd, sessionType: sessionType, speaker: speakerID, title: title, time: timeStart, location: location)
            //The struct is then added to the monday array. This will run for every row on this date.
                Monday.append(myLesson)
            
        }
        }
       // print(Monday[0])
        //print(Monday[1])
         return Monday
            }
    
    
    /**
     Gets details of a bookmarked session which will be presented in session details.
     */
    func getBookmarkDetails(name: String) -> session {
        
        var bookmarkedSession = session(id: "", content: "", sessionDate: "", timeEnd: "", sessionType: "", speaker: "", title: "", time: "", location: "")
        let query = "SELECT * FROM SESSIONS WHERE title LI)"
        var statement: OpaquePointer? = nil  // Pointer for sql to track returns
        if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
        while(sqlite3_step(statement) == SQLITE_ROW){
            
            let id = stringAtField(statement!, fieldIndex: 0)
            let title = stringAtField(statement!, fieldIndex: 1)
            let content = stringAtField(statement!, fieldIndex: 2)
            let location = stringAtField(statement!, fieldIndex: 3)
            let sessionDate = stringAtField(statement!, fieldIndex: 4)
            let timeStart = stringAtField(statement!, fieldIndex: 6)
            let timeEnd = stringAtField(statement!, fieldIndex: 7)
            // let locationid = stringAtField(statement!, fieldIndex: 6)
            let sessionType = stringAtField(statement!, fieldIndex: 8)
            let speakerID = stringAtField(statement!, fieldIndex: 9)
            //Once all the variables are initialised, a struct is created using these values
        
          
            bookmarkedSession.id = id
            bookmarkedSession.title = title
            bookmarkedSession.content = content
            bookmarkedSession.location = content
            bookmarkedSession.sessionDate = sessionDate
            bookmarkedSession.time = timeStart
            bookmarkedSession.timeEnd = timeEnd
            bookmarkedSession.sessionType = sessionType
            bookmarkedSession.speaker = speakerID
            }
             sqlite3_finalize(statement)
            
        }
       
        return bookmarkedSession
        
        
        
    }
    
    
    
    /**
        This function runs exactly the same as all of the other days, but just takes in values from a different date instead.
     */
    func getTuesday () -> [session ]{
            var Tuesday: [session] = []
            var myLesson: session!
            
            let query = "SELECT * FROM SESSIONS WHERE sessionDate = '2019-12-11'"
            var statement: OpaquePointer? = nil  // Pointer for sql to track returns
          if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
            while(sqlite3_step(statement) == SQLITE_ROW){
      let id = stringAtField(statement!, fieldIndex: 0)
                 let title = stringAtField(statement!, fieldIndex: 1)
                 let content = stringAtField(statement!, fieldIndex: 2)
                 let location = stringAtField(statement!, fieldIndex: 3)
                 let sessionDate = stringAtField(statement!, fieldIndex: 4)
             let timeStart = stringAtField(statement!, fieldIndex: 6)
             let timeEnd = stringAtField(statement!, fieldIndex: 7)
                // let locationid = stringAtField(statement!, fieldIndex: 6)
             let sessionType = stringAtField(statement!, fieldIndex: 8)
             let speakerID = stringAtField(statement!, fieldIndex: 9)
             myLesson = session(id: id, content: content, sessionDate: sessionDate, timeEnd: timeEnd, sessionType: sessionType, speaker: speakerID, title: title, time: timeStart, location: location)
                    Tuesday.append(myLesson)
                
            
            }
       
        }
             return Tuesday
                }
       
    
    /**
       This function runs exactly the same as all of the other days, but just takes in values from a different date instead.
    */
    func getWednesday () -> [session ]{
               var Wednesday: [session] = []
               var myLesson: session!
               
               let query = "SELECT * FROM SESSIONS WHERE sessionDate = '2019-12-12'"
               var statement: OpaquePointer? = nil  // Pointer for sql to track returns
             if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
               while(sqlite3_step(statement) == SQLITE_ROW){
         let id = stringAtField(statement!, fieldIndex: 0)
                    let title = stringAtField(statement!, fieldIndex: 1)
                    let content = stringAtField(statement!, fieldIndex: 2)
                    let location = stringAtField(statement!, fieldIndex: 3)
                    let sessionDate = stringAtField(statement!, fieldIndex: 4)
                let timeStart = stringAtField(statement!, fieldIndex: 6)
                let timeEnd = stringAtField(statement!, fieldIndex: 7)
                   // let locationid = stringAtField(statement!, fieldIndex: 6)
                let sessionType = stringAtField(statement!, fieldIndex: 8)
                let speakerID = stringAtField(statement!, fieldIndex: 9)
                myLesson = session(id: id, content: content, sessionDate: sessionDate, timeEnd: timeEnd, sessionType: sessionType, speaker: speakerID, title: title, time: timeStart, location: location)
                       Wednesday.append(myLesson)
                   
        }
    }
   
    return Wednesday
    }
    
    
    /**
       This function runs exactly the same as all of the other days, but just takes in values from a different date instead.
    */
    func getThursday () -> [session ]{
               var Thursday: [session] = []
               var myLesson: session!
               
               let query = "SELECT * FROM SESSIONS WHERE sessionDate = '2019-12-13'"
               var statement: OpaquePointer? = nil  // Pointer for sql to track returns
             if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
               while(sqlite3_step(statement) == SQLITE_ROW){
      let id = stringAtField(statement!, fieldIndex: 0)
                    let title = stringAtField(statement!, fieldIndex: 1)
                    let content = stringAtField(statement!, fieldIndex: 2)
                    let location = stringAtField(statement!, fieldIndex: 3)
                    let sessionDate = stringAtField(statement!, fieldIndex: 4)
                let timeStart = stringAtField(statement!, fieldIndex: 6)
                let timeEnd = stringAtField(statement!, fieldIndex: 7)
                   // let locationid = stringAtField(statement!, fieldIndex: 6)
                let sessionType = stringAtField(statement!, fieldIndex: 8)
                let speakerID = stringAtField(statement!, fieldIndex: 9)
                myLesson = session(id: id, content: content, sessionDate: sessionDate, timeEnd: timeEnd, sessionType: sessionType, speaker: speakerID, title: title, time: timeStart, location: location)
                       Thursday.append(myLesson)
                   
               }
               }
          
                return Thursday
                   }
          
    
    
    
    /**
        This function retrieves all the details of every speaker in the database. This will then be used to populate the speakers table, and will also allow the user to click on the row and find out more details from the speakersProfile. Will return a list of speaker structs.
     */
    
    func getSpeakers () -> [speakers ]{
            
            var speakerList: [speakers] = []
          //This will hold the details of a speaker and be later added into the array
            var speaker: speakers!
            //This selects every field from the speakers table.
            let query = "SELECT * FROM speakers"
            var statement: OpaquePointer? = nil  // Pointer for sql to track returns
          if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
            while(sqlite3_step(statement) == SQLITE_ROW){
                //These are the values that will make up a speaker struct
                    let name = stringAtField(statement!, fieldIndex: 1)
                    let id = stringAtField(statement!, fieldIndex: 0)
                    let twitter = stringAtField(statement!, fieldIndex: 3)
                let bio = stringAtField(statement!, fieldIndex: 2)
                speaker = speakers(name: name, photo: id, twitter: twitter, bio: bio)
                //Once the struct has all the values, it will be added into this array
                speakerList.append(speaker)
                
            }
            }
       
             return speakerList
                }
    
    
    /**
        This function is used to get all the details of a speaker when only the id is known. For example, in the session details view controller, the id of the speaker will be shown. When the user clicks that speaker button, it will take them to the speaker profile, where this has been run and will then populate all the labels with the details of the speaker. Parameter is the id of the speaker.
     */
    
    func getSpecificSpeaker(speaker: String) -> speakers {
        //Speaker struct that will gold the values
        var oneSpeaker: speakers!
        //Query to retrieve all the details of the speaker from the known id
        let query = "SELECT name,twitter,biography from speakers where id = '" + speaker + "'"
        var statement: OpaquePointer? = nil  // Pointer for sql to track returns
        if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
          while(sqlite3_step(statement) == SQLITE_ROW){
            //Holds all the values of the speaker details
            let name = stringAtField(statement!, fieldIndex: 0)
            let twitter = stringAtField(statement!, fieldIndex: 1)
            let bio = stringAtField(statement!, fieldIndex: 2)
            //Initialises the speaker struct that will be returned.
            oneSpeaker = speakers(name: name, photo: speaker, twitter: twitter, bio: bio)
            }
}
        return oneSpeaker
}
    
    

    /**
     This function returns all of the sessions that  one particular speaker holds. This will be used in the speaker profile, where there is a table that holds these values. It takes in the speakerId as a paremeter and returns the sessions that they hold.
     */
    func getSpeakersSessions(speaker: String) -> [String]{
        //Used to hold the name of one session
        var singleSession: String
        //Used to hold the sessions
        var sessions : [String] = []
        //Uses the speaker parameter as the value of speakerId to search for
        let query = "SELECT title FROM sessions WHERE speakerId = '" + speaker + "'"
        var statement: OpaquePointer? = nil  // Pointer for sql to track returns
               if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
                 while(sqlite3_step(statement) == SQLITE_ROW){
                    //Holds the name of the session
                    let title = stringAtField(statement!, fieldIndex: 0)
                    singleSession = title
                    //Adds the name of session to the array that will be returned.
                    sessions.append(singleSession)
                    
        }
                
                
        }
return sessions
    }
    
    
    
    /**
    This function is used to get all of the details from a session when only the title is known. This is used on the speaker profile page, where the title of the session the speaker holds is shown, and this will run when that is clicked to take the user to the session details page. It takes in the name as a parameter and returns a session struct.
     */
    func getSessionDetails(sessionName: String) -> session {
        var sessionDetails: session!
        //Retrieves all the fields where the title is what the speaker is holding.
        let query = "SELECT * FROM sessions WHERE title = '" + sessionName + "'"
        var statement: OpaquePointer? = nil  // Pointer for sql to track returns
        if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
        while(sqlite3_step(statement) == SQLITE_ROW){
           let id = stringAtField(statement!, fieldIndex: 0)
            let title = stringAtField(statement!, fieldIndex: 1)
                let content = stringAtField(statement!, fieldIndex: 2)
                let location = stringAtField(statement!, fieldIndex: 3)
                let sessionDate = stringAtField(statement!, fieldIndex: 4)
            let timeStart = stringAtField(statement!, fieldIndex: 6)
            let timeEnd = stringAtField(statement!, fieldIndex: 7)
               // let locationid = stringAtField(statement!, fieldIndex: 6)
            let sessionType = stringAtField(statement!, fieldIndex: 8)
            let speakerID = stringAtField(statement!, fieldIndex: 9)
            //struct of the session that will be returned
            sessionDetails = session(id: id, content: content, sessionDate: sessionDate, timeEnd: timeEnd, sessionType: sessionType, speaker: speakerID, title: title, time: timeStart, location: location)
    }
          }
        return sessionDetails
}
    /**
     Gets bookmarked sessions by taking bookmarked names.
     */
    
    func getBookmarkedSession (name: [String]) -> [session] {
        var sessionDetails: session!
        var details: [session] = []
        var idForSearch = ""
        
        var statement: OpaquePointer? = nil  // Pointer for sql to track returns

        for i in name {
            idForSearch = i
            let query = "SELECT * FROM sessions WHERE id = '\(idForSearch)';"
            if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
            while(sqlite3_step(statement) == SQLITE_ROW){

                let id = stringAtField(statement!, fieldIndex: 0)
                let title = stringAtField(statement!, fieldIndex: 1)
                let content = stringAtField(statement!, fieldIndex: 2)
                let location = stringAtField(statement!, fieldIndex: 3)
                let sessionDate = stringAtField(statement!, fieldIndex: 4)
                let timeStart = stringAtField(statement!, fieldIndex: 6)
                let timeEnd = stringAtField(statement!, fieldIndex: 7)
                // let locationid = stringAtField(statement!, fieldIndex: 6)
                let sessionType = stringAtField(statement!, fieldIndex: 8)
                let speakerID = stringAtField(statement!, fieldIndex: 9)
            
            
             sessionDetails = session(id: id, content: content, sessionDate: sessionDate, timeEnd: timeEnd, sessionType: sessionType, speaker: speakerID, title: title, time: timeStart, location: location)
                details.append(sessionDetails)
            
        }
            }
            sqlite3_finalize(statement)
        
               
              
        
    }
        return details

    }
    
    
    
   
    var readList : [String] = []
    /**
     Function to write details about a session to the bookmark.list file.
     */
   
    func bookmarkTitle(){
        
        let readListURL = urlToFileInDocuments("bookmarkList.list")
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        if let data = try? encoder.encode(readList){
            print("Encoded Data To Be Written:")
            print(String(data: data,encoding: .utf8)!)
            try? data.write(to: readListURL, options: .noFileProtection)
        } else{
            print("Does not work")}
        
    }
    
    func removeBookmark(indexPath: Int) {
        
        let readListURL = urlToFileInDocuments("bookmarkList.list")
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        if let data = try? encoder.encode(readList){
           
        }
        
        
    }
    /**
     Reads in the bookmarks
     */
    func getBookmarks(){
        if fileExistsInDocuments("bookmarkList.list"){
            let readListURL = urlToFileInDocuments("bookmarkList.list")
            if let dataFromFile = try? Data(contentsOf: readListURL){
                let decoder = PropertyListDecoder()
                if let title = try? decoder.decode([String].self, from: dataFromFile){
                    readList = title

                }
            }
        } else {
            bookmarkTitle()
        }
    }
    
    /**
     Iterates through bookmarks to see if it already exists.
     */
    func searchIfBookmarkExists(name: String) -> Bool {
        var answer = false
        
        for i in readList {
            if i == name {
                answer = true
            }
        }
        
        return answer
    }
    
    /**
     Removes bookmark. by iterating through the array to find it.
     */
    func removeBookmark(name: String) {
        var count = 0
        for i in readList {
            if i == name {
                readList.remove(at: count)
            }
            count += 1
        }
        
        bookmarkTitle()
        
    }
    
    
    /**
     Finds if the file for bookmark already exists
     */
    func fileExistsInDocuments( _ fileName: String ) -> Bool {
        let fileManager = FileManager.default
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0]
        let filepathName = docsDir + "/\(fileName)"
        return fileManager.fileExists(atPath: filepathName)
    }
    
    func urlToFileInDocuments( _ fileName: String ) -> URL {
        let docDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = docDirectory.appendingPathComponent(fileName)
        print(fileURL)
        return fileURL
    }
        
    
    
    
    
    
    
    
    

}





    


    

