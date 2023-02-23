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
    
    var callOut: CallOut?
    
    
    //MARK: - Properties
    
    
    
    
    var callOuts: [CallOut] = []
    var user: User
    
    let db = Firestore.firestore()
    let uid = Auth.auth().currentUser?.uid
    
    //MARK: - Initailiation
    
    
    
    //MARK: - CRUD Functions
    
    func saveCallOutDB() {
        let newCallOutRef = db.collection("corporate").document(user.workLocation).collection("callOuts").document()
        newCallOutRef.setData([
            "assignedLocation" : user.assignedLocation,
            "callOutDate" : callOut?.callOutDate,
            "employeeID" : "\(user.employeeID)",
            "firstName" : user.firstName,
            "lastName" : user.lastName,
            "homeSort" : user.homeSort,
        ])
    }
    
    func fetchCallOuts(employeeID: Int) {
        
        db.collection("corporate").document(user.workLocation).collection("callOuts").whereField("employeeID", isEqualTo: user.employeeID).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No Documents")
                    return
                }
                let callout = documents.map { QueryDocumentSnapshot -> CallOut in
                    let data = QueryDocumentSnapshot.data()
                    let assignedLocation = data["assignedLocation"] as? String ?? ""
                    let callOutDate = data["callOutDate"] as? String ?? ""
                    let employeeID = data["employeeID"] as? Int ?? 0
                    let firstName = data["firstName"] as? String ?? ""
                    let lastName = data["lastName"] as? String ?? ""
                    let homeSort = data["homeSort"] as? String ?? ""
                    self.callOut?.assignedLocation = assignedLocation
                    self.callOut?.callOutDate = callOutDate
                    self.callOut?.firstName = firstName
                    self.callOut?.lastName = lastName
                    self.callOut?.homeSort = homeSort
                    guard let callOut = callOut else {return}
                    callOuts.append(callOut)
                    print(callOuts)
                }
            }
        }
        
    }
    */
    
}//end of class
