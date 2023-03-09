//
//  ExtraWorkViewController.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 8/5/22.
//

import UIKit
import Firebase
import FirebaseFirestore

class ExtraWorkViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: - Properties
    
    var user: User?
    var datePicker: String = ""
    var sortPicker: String = ""
    var workRequested: String = ""
    let db = Firestore.firestore()
    var pickerDataSource: [String] = ["ALDOR-9739 PRE", "ALDOR-9739 DAY","ALDOR-9739 TWI", "ALDOR-9739 NIT", "POROR-9729 PRE", "POROR-9729 DAY" ,"POROR-9729 TWI", "POROR-9729 NIT", "HILOR-9712 PRE", "HILOR-9712 TWI", "PDXAP-NIT"]
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
     
        
        super.viewDidLoad()
        self.sortPIckerView.dataSource = self
        self.sortPIckerView.delegate = self
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sortPicker = pickerDataSource[row] as String
        print(sortPicker)
    }
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var sortPIckerView: UIPickerView!
    
    @IBOutlet weak var extraWorkDatePicker: UIDatePicker!
    
    @IBOutlet weak var extraWorkRequestedTextField: UITextField!
    
    
    //MARK: - Actions
    
    
    
    @IBAction func datePickerSelected(_ sender: Any) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let stringFromDate: String = dateFormatter.string(from: self.extraWorkDatePicker.date)
        datePicker = stringFromDate
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        extraWorkAC()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        goToHome()
    }
    
    
    //MARK: - Functions
    
    func saveExtraWorkToDB(employeeID: Int, extraWorkDate: String, extraWorkSort: String, firstName: String, hireDate: String, homeSort: String, lastName: String, phoneNumber: Int, workRequested: String){
        guard let user = user else {return}
        let newExtraWorkRef = db.collection("corporate").document(user.workLocation).collection("extraWork").document()
        newExtraWorkRef.setData([
            "employeeID": employeeID,
            "extraWorkDate" : extraWorkDate,
            "extraWorkSort" : extraWorkSort,
            "firstName" : firstName,
            "hireDate" : hireDate,
            "homeSort" : homeSort,
            "lastName" : lastName,
            "phoneNumber" : phoneNumber,
            "workRequested" : workRequested
        ])
    }
    
    func extraWorkAC() {
        guard let user = user else {return}
        
        let alertController = UIAlertController(title: "Please Confirm Extra Work", message: "You are signing up for extra work on \(datePicker) at \(sortPicker)", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Confirm", style: .default) { [self] (_) in
            workRequested = extraWorkRequestedTextField.text ?? "All"
            let employeeID = user.employeeID
            let extraWorkDate = datePicker
            let extraWorkSort = sortPicker
            let firstName = user.firstName
            let hireDate = user.hireDate
            let homeSort = user.homeSort
            let lastName = user.lastName
            let phoneNumber = user.phoneNumber
            let workRequested = workRequested
            self.saveExtraWorkToDB(employeeID: employeeID, extraWorkDate: extraWorkDate, extraWorkSort: extraWorkSort, firstName: firstName, hireDate: hireDate, homeSort: homeSort, lastName: lastName, phoneNumber: phoneNumber, workRequested: workRequested)
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
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}//end of class
