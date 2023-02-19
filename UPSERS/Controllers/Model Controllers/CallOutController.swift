//
//  CallOutController.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 8/18/22.
//

import UIKit
import Firebase

class CallOutController {
    
/*
    //MARK: - SOT
    
    private var callout: CallOut
  
    
    //MARK: - Properties
    
   
    
    
    var callouts: [CallOut] = []
    var user: User
   
    let db = Firestore.firestore()
    let uid = Auth.auth().currentUser?.uid
    
    //MARK: - Initailiation
    
    init(callout: CallOut) {
        self.callout = callout
        
    }
    
    //MARK: - CRUD Functions
    
    func saveCallOutToCorporateDB() {
        let newCallOutRef = db.collection("corporate").document(user.workLocation).collection("callOuts").document()
        newCallOutRef.setData([
            "assignedLocation" : user.assignedLocation,
            "callOutDate" : callout.callOutDate,
            "empID" : user.employeeID,
            "firstName" : user.firstName,
            "lastName" : user.lastName,
            "homeSort" : user.homeSort,
        ])
    }
    
    func saveCallOutToUserDB(calloutDate: NSDate) {
        
        let docRef = db.collection("user").document("\(user.employeeID)").collection("callOuts").document()
        
        let newCallOutRef = self.db.collection("callouts").document("\(user.employeeID)")
        newCallOutRef.setData([
            "firstName" : user.firstName,
            "lastName" : user.lastName,
            "empID" : user.employeeID,
            "callOutDate" : calloutDate
            
        ])
        
    }
   */
}//end of class
