//
//  UserCallOutModelController.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 1/29/23.
//

import Foundation
import Firebase

class UserCallOutModelController {
    
    //MARK: - Proerties
    
    var userCallOut: UserCallOut?
    
    var userCallOuts: [UserCallOut?] = []
    
    let uid = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
    
    //MARK: - CRUD Functions
    
    
    
    func fetchCallOutsFromUserDB() {
        guard let uid = uid else {
            return
        }
        db.collection("users").document(uid).collection("callOuts").addSnapshotListener { QuerySnapshot, Error in
            guard let documents = QuerySnapshot?.documents else {
                return
            }
            let calloutdata = documents.map {QueryDocumentSnapshot -> UserCallOut in
                let data = QueryDocumentSnapshot.data()
                let callOutDate = data["callOutDate"] as? String ?? ""
                let homeSort = data["homeSort"] as? String ?? ""
                self.userCallOut?.callOutDate = callOutDate
                self.userCallOut?.homeSort = homeSort
                self.userCallOuts.append(self.userCallOut)
                return UserCallOut(callOutDate: callOutDate, homeSort: homeSort)
            }
        }
    
    }
    
    
    
}//end of class

