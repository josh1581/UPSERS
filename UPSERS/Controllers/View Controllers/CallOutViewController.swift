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
    
    var user: User?
    
    var callOut: CallOut?
    
    var datePicker: String = ""
    let db = Firestore.firestore()
    
    
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    //MARK: - Outlets
    
    
    @IBOutlet weak var callOutDatePicker: UIDatePicker!
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK: - Actions
    
    
    @IBAction func callOutDatePickerChanged(_ sender: Any) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let stringFromDate: String = dateFormatter.string(from: self.callOutDatePicker.date)
        datePicker = stringFromDate
        print(callOutDatePicker.date)
    }
    
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        print(datePicker)
        callOutAC()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        goToHome()
    }
    
    
    //MARK: - Functions
    
    func saveCallOutToDB(firstName: String, lastName: String, employeeID: Int, homeSort: String, assignedLocation: String, callOutDate: String) {
        guard let user = user else {return}
        let newCallOutRef =
        db.collection("corporate").document(user.workLocation).collection("callOuts").document()
        newCallOutRef.setData([
            "assignedLocation" : assignedLocation,
            "callOutDate" : datePicker,
            "employeeID" : employeeID,
            "firstName" : firstName,
            "lastName" : lastName,
            "homeSort" : homeSort,
        ])
    }
    
    
    func callOutAC() {
        guard let user = user else {return}
        let alertController = UIAlertController(title: " Please Confirm CallOut", message: "You are calling out on \(datePicker)", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Confirm", style: .default) { [self] (_) in
            let firstName = user.firstName
            let lastName = user.lastName
            let employeeID = user.employeeID
            let homeSort = user.homeSort
            let assignedLocation = user.assignedLocation
            let callOutDate = datePicker
            self.saveCallOutToDB(firstName: firstName, lastName: lastName, employeeID: employeeID, homeSort: homeSort, assignedLocation: assignedLocation, callOutDate: callOutDate)
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
    
    
} //end of class
