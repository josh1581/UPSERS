//
//  HomeViewController.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 8/5/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    let uid = Auth.auth().currentUser?.uid
    let email = Auth.auth().currentUser?.email
    let db = Firestore.firestore()
    var user: User = User(employeeID: 0, email: "", firstName: "", lastName: "", phoneNumber: 0, hireDate: "", workLocation: "", district: "", assignedLocation: "", homeSort: "")
    var userController = UserController()
    var employeedID: Int = 0
    
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        Task {
            await fetchEmployeeID()
        }
        super.viewDidLoad()
    }
    
    //MARK: - Outlets
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    
    
    //MARK: - Actions
    
    
    
    @IBAction func callOutButtonTapped(_ sender: Any) {
        let callOutViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.callOutViewController) as? CallOutViewController
        callOutViewController?.user = user
        view.window?.rootViewController = callOutViewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func viewCallOutsButtonTapped(_ sender: Any) {
        
        let userCallOutTableViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.userCalloutsTableViewController) as? UserCalloutsTableViewController
        userCallOutTableViewController?.user = user
        view.window?.rootViewController = userCallOutTableViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    @IBAction func extraWorkButtonTapped(_ sender: Any) {
        let extraWorkViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.extraWorkViewController) as? ExtraWorkViewController
        extraWorkViewController?.user = user
        view.window?.rootViewController = extraWorkViewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func viewExtraWorkButtonTapped(_ sender: Any) {
        let userExtraWorkTableViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.userExtraWorkTableViewController) as? UserExtraWorkTableViewController
        userExtraWorkTableViewController?.user = user
        view.window?.rootViewController = userExtraWorkTableViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    //MARK: - Functions
    
    
    func fetchEmployeeID() async {
        guard let uid = self.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument { [weak self] document, error in
            if let document = document {
                let employeeID = document["employeeID"] as? Int ?? 0
                self?.employeedID = employeeID
                print(self?.employeedID as Any)
                Task {
                    await self?.fetchEmployeeInfo(employeeID:employeeID)
                }
            }
        }
    }
    
    //This fetchEmployee function works in VC, but I'm screwing up the User Controller.
    
    func fetchEmployeeInfo(employeeID: Int) async {
        let employeeIDString = "\(self.employeedID)"
        print("Employee ID String is: \(employeeIDString)")
        Firestore.firestore().collection("employees").document(employeeIDString).getDocument {  [weak self] document, error in
            if let document = document{
                let email = document["email"] as? String ?? ""
                let firstName = document["firstName"] as? String ?? ""
                let lastName = document["lastName"] as? String ?? ""
                let phoneNumber = document["phoneNumber"] as? Int ?? 0
                let hireDate = document["hireDate"] as? String ?? ""
                
                let workLocation = document["workLocation"] as? String ?? ""
                let assignedLocation = document["assignedLocation"] as? String ?? ""
                let homeSort = document["homeSort"] as? String ?? ""
                print(homeSort)
                //guard let self.user = user else {return}
                self?.user.assignedLocation = assignedLocation
                self?.user.email = email
                self?.user.firstName = firstName
                self?.user.hireDate = hireDate
                self?.user.homeSort = homeSort
                self?.user.lastName = lastName
                self?.user.phoneNumber = phoneNumber
                self?.user.workLocation = workLocation
                self?.user.employeeID = employeeID
                print(homeSort)
                print("Hire date is: \(self?.user.hireDate)")
                print(self?.user.homeSort)
            }
        }
    }
    
    
}//end of class
