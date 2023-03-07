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
    
    var user: User?
    
    static let shared = UserController()
    
    var employeeID: Int = 0 
    
    //MARK: - Properties
    
    let db = Firestore.firestore()
    let uid = Auth.auth().currentUser?.uid
    
    
    //MARK: - CRUD Functions
    
    // Fetches the employee ID that was input when the user registered their account to pass into getEmployeeInfo method and set the user.employeeID portion of the User object.
    
    func fetchEmployeeID() async {
        //guard let uid = uid else {return}
        Firestore.firestore().collection("users").document("\(Auth.auth().currentUser?.uid ?? "")").getDocument { [weak self] document, error in
            if let document = document {
                let employeeID = document["employeeID"] as? Int ?? 0
               
                self?.user?.employeeID = employeeID
                //UserController.shared.user?.employeeID = employeeID
                //guard let user = user else {return}
                print(self?.user?.employeeID)
            }
        }
    }
    
    func setUserInfo() async {
        Task {
        }
    }
    
    //This method sets the remainder of the user object.
    
    func fetchEmployeeInfo(employeeID: Int) async {
        Firestore.firestore().collection("employees").document("\(employeeID)").getDocument { [weak self]document, error in
            if let document = document{
                let email = document["email"] as? String ?? ""
                let firstName = document["firstName"] as? String ?? ""
                let lastName = document["lastName"] as? String ?? ""
                let phoneNumber = document["phoneNumber"] as? Int ?? 0
                let hireDate = document["hireDate"] as? String ?? ""
                
                let workLocation = document["workLocation"] as? String ?? ""
                let assignedLocation = document["assignedLocation"] as? String ?? ""
                let homeSort = document["homeSort"] as? String ?? ""
                
                self?.user?.email = email
                self?.user?.firstName = firstName
                self?.user?.lastName = lastName
                self?.user?.phoneNumber = phoneNumber
                self?.user?.hireDate = hireDate
                self?.user?.workLocation = workLocation
                self?.user?.assignedLocation = assignedLocation
                self?.user?.homeSort = homeSort
                self?.user?.employeeID = employeeID
                print(homeSort)
                print(self?.user?.homeSort)
            }
        }
    }
}//end of class

