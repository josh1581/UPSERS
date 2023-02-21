//
//  UserModelController.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 1/14/23.
//


import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class UserModelController {
    //MARK: - SOT
 /*
    var user: User?
    
    //MARK: - Properties
    
    
    var employeeID: Int = 0 {
        didSet {
            Task {
                await self?.fetchEmployeeInfo(employeeID: employeeID)
                print(employeeID)
            }
        }
        
    }
    
    //MARK: - Initialization
   
    let uid = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
    
    
    //MARK: - Functions
    
    func fetchEmployeeID() async {
        guard let uid = self.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument { [self] document, error in
            if let document = document {
                let employeeID = document["employeeID"] as? Int ?? 0
                self.employeeID = employeeID
                
                print(employeeID)
                print(self.employeeID)
                
            }
        }
    }
    
    func fetchEmployeeInfo(employeeID: Int) async {
        let employeeIDString = "\(employeeID)"
        Firestore.firestore().collection("employees").document(employeeIDString).getDocument { [self] document, error in
            if let document = document {
                let email = document["email"] as? String ?? ""
                let firstName = document["firstName"] as? String ?? ""
                let lastName = document["lastName"] as? String ?? ""
                let phoneNumber = document["phoneNumber"] as? Int ?? 0
                let hireDate = document["hireDate"] as? String ?? ""
                
                let workLocation = document["workLocation"] as? String ?? ""
                let assignedLocation = document["assignedLocation"] as? String ?? ""
                let homeSort = document["homeSort"] as? String ?? ""
                
                self.user?.email = email
                self.user?.firstName = firstName
                self.user?.lastName = lastName
                self.user?.phoneNumber = phoneNumber
                self.user?.hireDate = hireDate
                self.user?.workLocation = workLocation
                self.user?.assignedLocation = assignedLocation
                self.user?.homeSort = homeSort
                print(self.user?.homeSort)
            }
        }
    }
    
    
    
    func fetchEmployeeInfo(employeeID: Int) async {
        let employeeIDString = "\(employeeID)"
        let docRef = db.collection("employees").document(employeeIDString)
        
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                if let data = data{
                    
                    let email = data["email"] as? String ?? ""
                    let firstName = data["firstName"] as? String ?? ""
                    let lastName = data["lastName"] as? String ?? ""
                    let phoneNumber = data["phoneNumber"] as? Int ?? 0
                    let hireDate = data["hireDate"] as? String ?? ""
                    
                    let workLocation = data["workLocation"] as? String ?? ""
                    let assignedLocation = data["assignedLocation"] as? String ?? ""
                    let homeSort = data["homeSort"] as? String ?? ""
                    
                    self.user?.email = email
                    self.user?.firstName = firstName
                    self.user?.lastName = lastName
                    self.user?.phoneNumber = phoneNumber
                    self.user?.hireDate = hireDate
                    self.user?.workLocation = workLocation
                    self.user?.assignedLocation = assignedLocation
                    self.user?.homeSort = homeSort
                    
                    //self.user.employeeID = employeeID
                    
                    print(self.user?.district)
                }
            }
        }
    }
    
    
    
    func setUserInfo() {
        Task {
            await fetchEmployeeID()
            print(employeeID)
        }
        Task {
            await fetchEmployeeInfo(employeeID: employeeID)
        }
    }
    */
}//end of class
