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
    
    var callOut: CallOut = CallOut()
    
    var callOutDate: Date = Date()
    let db = Firestore.firestore()
    let dateFormatter = DateFormatter()
    
    
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
        callOutDate = callOutDatePicker.date
        //callOutDatePicker.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        
        
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
    
    func saveCallOutToDB(firstName: String, lastName: String, employeeID: Int, homeSort: String, assignedLocation: String, callOutDate: String) {
       
        guard let user = user else {return}
        let newCallOutRef =
        db.collection("corporate").document(user.workLocation).collection("callOuts").document()
        newCallOutRef.setData([
            "assignedLocation" : assignedLocation,
            "callOutDate" : callOutDate,
            "employeeID" : "\(employeeID)",
            "firstName" : firstName,
            "lastName" : lastName,
            "homeSort" : homeSort,
        ])
    }
    
    func saveToUserDB(){
        
    }
    
    func callOutAC() {
        guard let user = user else {return}
        let alertController = UIAlertController(title: " Please Confirm CallOut", message: "You are calling out on \(callOutDate)", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Confirm", style: .default) { [self] (_) in
            
            
            let firstName = user.firstName
            let lastName = user.lastName
            let employeeID = user.employeeID
            let homeSort = user.homeSort
            let assignedLocation = user.assignedLocation
            let callOutDate = "\(callOutDate)"
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
    
    
    
    
}
