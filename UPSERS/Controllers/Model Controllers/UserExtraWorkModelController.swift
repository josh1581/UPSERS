//
//  UserExtraWorkModelController.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 1/29/23.
//

import Foundation
import Firebase


class UserExtraWorkModelController {
    
    //MARK: - Properties
    
    var userExtraWork: UserExtraWork?
    var userExtraWorks: [UserExtraWork?] = []
    
    let uid = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
    
    //MARK: - CRUD Functions
    
    func fetchExtraWorkFromUserDB() {
        guard let uid = uid else {
            return
        }
        db.collection("users").document(uid).collection("extraWork").addSnapshotListener { QuerySnapshot, Error in
            guard let documents = QuerySnapshot?.documents else {
                return
            }
            let calloutdata = documents.map {QueryDocumentSnapshot -> UserExtraWork in
                let data = QueryDocumentSnapshot.data()
                let extraWorkDate = data["extraWorkDate"] as? String ?? ""
                let extraWorkSort = data["extraWorkSort"] as? String ?? ""
                self.userExtraWork?.extraWorkSort = extraWorkSort
                self.userExtraWork?.extraWorkDate = extraWorkDate
                self.userExtraWorks.append(self.userExtraWork)
                
                return UserExtraWork(extraWorkDate: extraWorkDate, extraWorkSort: extraWorkSort)
                
            }
            
        }
        
        
    }
    
    
}//end of class
