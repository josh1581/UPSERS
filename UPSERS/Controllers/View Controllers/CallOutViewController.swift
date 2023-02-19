//
//  CallOutViewController.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 8/5/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class CallOutViewController: UIViewController {
    
    
    //MARK: - Properties
    
    var user = User(employeeID: 123456, email: "josh.hoyle@outlook.com", firstName: "Josh", lastName: "Hoyle", phoneNumber: 5033307800, hireDate: "10/13/2021", workLocation: "POROR-9729", district: "Portland", assignedLocation: "SD4", homeSort: "TWI M-F")
    
    var callOut: CallOut = CallOut()
    
    var callOutDate: Date = Date()
    let db = Firestore.firestore()
    let dateFormatter = DateFormatter()
    
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        print(user.lastName)
        print(user.firstName)
        print(user.workLocation)
        super.viewDidLoad()
    }
    
    //MARK: - Outlets
    
    
    @IBOutlet weak var callOutDatePicker: UIDatePicker!
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK: - Actions
    
    
    @IBAction func callOutDatePickerChanged(_ sender: Any) {
        
        
        
        print(callOutDatePicker.date)
        
    }
    
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        dateFormatter.dateStyle = .short
        //callOutDate.formatted(date: Date.FormatStyle.sho, time: <#T##Date.FormatStyle.TimeStyle#>)
        // callOutDate = dateFormatter.date(from: "\(callOutDatePicker.date)") ?? Date()
        print(callOutDate)
        self.callOut.callOutDate = "\(callOutDate)"
        callOutAC()
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        goToHome()
    }
    
    
    //MARK: - Functions
    
    func saveCallOutToCorporateDB(firstName: String, lastName: String, empID: Int, homeSort: String, assignedLocation: String, callOutDate: String) {
        let newCallOutRef = db.collection("corporate").document(self.user.workLocation).collection("callOuts").document()
        newCallOutRef.setData([
            "assignedLocation" : assignedLocation,
            "callOutDate" : callOutDate,
            "empID" : empID,
            "firstName" : firstName,
            "lastName" : lastName,
            "homeSort" : homeSort,
        ])
    }
    
    func saveToUserDB(){
        
    }
    
    func callOutAC() {
        let alertController = UIAlertController(title: " Please Confirm CallOut", message: "You are calling out on \(callOutDate)", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Confirm", style: .default) { [self] (_) in
            let firstName = self.user.firstName
            let lastName = self.user.lastName
            let empID = self.user.employeeID
            let homeSort = self.user.homeSort
            let assignedLocation = self.user.assignedLocation
            let callOutDate = "\(callOutDate)"
            self.saveCallOutToCorporateDB(firstName: firstName, lastName: lastName, empID: empID, homeSort: homeSort, assignedLocation: assignedLocation, callOutDate: callOutDate)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func goToHome() {
        
        let homeViewController =
        storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    /*
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
     
     
     func FetchEmployeeInfo(employeeID: Int) {
     let employeeIDString = "\(employeeID)"
     Firestore.firestore().collection("Employees").document(employeeIDString).getDocument {  document, error in
     if let document = document{
     let email = document["email"] as? String ?? ""
     let firstName = document["firstName"] as? String ?? ""
     let lastName = document["lastName"] as? String ?? ""
     let phoneNumber = document["phoneNumber"] as? Int ?? 0
     let hireDate = document["hireDate"] as? String ?? ""
     
     let workLocation = document["workLocation"] as? String ?? ""
     let assignedLocation = document["assignedLocation"] as? String ?? ""
     let homeSort = document["homeSort"] as? String ?? ""
     
     self.user.email = email
     self.user.firstName = firstName
     self.user.lastName = lastName
     self.user.phoneNumber = phoneNumber
     self.user.hireDate = hireDate
     self.user.workLocation = workLocation
     self.user.assignedLocation = assignedLocation
     self.user.homeSort = homeSort
     
     
     self.user.employeeID = employeeID
     print(homeSort)
     print(self.user.homeSort)
     
     }
     }
     }
     func fetchEmployeeInfoOld(employeeID: Int) {
     print(employeeID)
     let employeeIDString = "\(employeeID)"
     print(employeeIDString)
     let docRef = db.collection("employees").document(employeeIDString)
     
     docRef.getDocument { [self] (document, error) in
     if let document = document, document.exists {
     let data = document.data()
     if let data = data{
     
     let email = data["email"] as? String ?? ""
     let firstName = data["firstName"] as? String ?? ""
     let lastName = data["lastName"] as? String   ?? ""
     let phoneNumber = data["phoneNumber"] as? Int ?? 0
     let hireDate = data["hireDate"] as? String ?? ""
     
     let workLocation = data["workLocation"] as? String ?? ""
     let assignedLocation = data["assignedLocation"] as? String ?? ""
     let homeSort = data["homeSort"] as? String ?? ""
     
     print(homeSort)
     
     self.user.email = email
     self.user.firstName = firstName
     self.user.lastName = lastName
     self.user.phoneNumber = phoneNumber
     self.user.hireDate = hireDate
     self.user.workLocation = workLocation
     self.user.assignedLocation = assignedLocation
     self.user.homeSort = homeSort
     
     
     //self.user.employeeID = employeeID
     print(homeSort)
     print(self.user.homeSort)
     }
     }
     }
     }
     
     */
    
}
