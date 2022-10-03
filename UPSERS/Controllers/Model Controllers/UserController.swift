//
//  UserController.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 7/27/22.
//


import Firebase
import FirebaseAuth
import FirebaseFirestore
import UIKit

class UserController {
    
    //MARK: - SOT
    
    
    
    
     var user = User(employeeID: 0, email: "", firstName: "", lastName: "", phoneNumber: 0, hireDate: nil, workLocation: "", district: "", assignedLocation: "", homeSort: "")
    
    //MARK: - Properties
    
    let db = Firestore.firestore()
    let uid = Auth.auth().currentUser?.uid
    var date = Calendar.current
    var employeedID: Int = 0
    var email: String = ""
    
    
    //MARK: - CRUD Functions
    
    
    
    // Fetches the employee ID that was input when the user signed up for use to pass into getEmployeeInfo method.

    func setUserInfo() {
    guard let uid = self.uid else {return}
    Firestore.firestore().collection("users").document(uid).getDocument { document, error in
        if let document = document {
            let employeeID = document["employeeID"] as? Int ?? 0
            self.getEmployeeInfo(employeeID: employeeID) { [weak self] user in
                self?.user = user
            }
           
            
            
        }
    }
}
/*
func getUserInfo(completion: @escaping) (_ result: Int) -> Void) {
    Firestore.firestore().collection("users").document(String(uid)).addSnapshotListener { QuerySnapshot, Error in
        guard let document = QuerySnapshot?.document else {
            print("No documents")
            return
        }
        let document = document.map { QueryDocumentSnapshot in
            let data = QueryDocumentSnapshot.data()
            //let employeeID = data["empID"] as? Int ?? 0
            
            
            
            
            
            
            
        }
        
    }
 
  */
    //This method sets the remainder of the user object and keeps the user object updated in real time.
    
    func getEmployeeInfo(employeeID: Int, completion: @escaping (_ result: User) -> Void){
        let employeeIDString = "\(employeeID)"
        let docRef = db.collection("employees").document(employeeIDString)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                if let data = data{
                    self.user.employeeID = employeeID
                    self.user.email = data["email"] as? String ?? ""
                    self.user.firstName = data["firstName"] as? String ?? ""
                    self.user.lastName = data["lastName"] as? String ?? ""
                    self.user.phoneNumber = data["phoneNumber"] as? Int ?? 0
                    //self.user.hireDate = data[""] as? NSDate ??
                    self.user.workLocation = data["workLocation"] as? String ?? ""
                    self.user.assignedLocation = data["assignedLocation"] as? String ?? ""
                    self.user.homeSort = data["homeSort"] as? String ?? ""
                    completion(self.user)
                }

               
                
                //print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
        
    }
    
    
  
}//end of class
