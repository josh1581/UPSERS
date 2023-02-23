//
//  ExtraWorkController.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 1/25/23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore


class ExtraWorkController {
    
    //MARK: - SOT
    
    
    var user: User?
    var extraWork: ExtraWork?
    var extraWorks: [ExtraWork] = []
    
    //MARK: - Properties
    
    let db = Firestore.firestore()
    let uid = Auth.auth().currentUser?.uid
    
    
    
    //MARK: - Functions
    
    func saveExtraWorktoDB() {
        guard let user = user else {return}
        let extraWorkRef = db.collection("corporate").document("\(user.employeeID)").collection("extraWork").document()
        extraWorkRef.setData([
            "extraWorkDate" : extraWork?.extraWorkDate as Any,
            "firstName" : user.firstName as Any,
            "homeSort" : user.homeSort as Any,
            "lastName" : user.lastName as Any,
            "phoneNumber" : user.phoneNumber as Any,
            "workLocation" : user.workLocation as Any,
            "workRequested" : extraWork?.workRequested as Any
        ])
    }
    
    func fetchExtraWork(employeeID: Int) {
        guard let user = user else {return}
        db.collection("corporate").document(user.workLocation).collection("extraWork").whereField("employeeID", isEqualTo: user.employeeID).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No Documents")
                    return
                }
                let extaWork = documents.map { QueryDocumentSnapshot -> CallOut in
                    let data = QueryDocumentSnapshot.data()
                    let employeeID = data["employeeID"] as? Int ?? 0
                    let extraWorkDate = data["extraWorkDate"] as? String ?? ""
                    let extraWorkSort = data["extraWorkSort"] as? String ?? ""
                    let firstName = data["firstName"] as? String ?? ""
                    let hireDate = data["hireDate"] as? String ?? ""
                    let homeSort = data["homeSort"] as? String ?? ""
                    let lastName = data["lastName"] as? String ?? ""
                    let phoneNumber = data["phoneNumber"] as? Int ?? 0
                    let workLocation = data["workLocation"] as? String ?? ""
                    let workRequested = data["workRequested"] as? String ?? ""
                    self.extraWork?.employeeID = employeeID
                    self.extraWork?.extraWorkDate = extraWorkDate
                    self.extraWork?.firstName = firstName
                    self.extraWork?.lastName = lastName
                    self.extraWork?.homeSort = homeSort
                    guard let extraWork = extraWork else {return}
                    extraWorks.append(extraWork)
                    print(extraWorks)
                }
            }
        }
        
    }
    
    
    
   
}//end of class
