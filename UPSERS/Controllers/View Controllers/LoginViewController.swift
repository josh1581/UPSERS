//
//  LoginViewController.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 8/5/22.
//

import UIKit
import Firebase
import FirebaseFirestore

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    
    var user: User?
    var employeeID: Int = 0
    var email: String = ""
    let uid = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK: - Actions
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        //guard let email = emailTextField.text else {return}
        //guard let password = passwordTextField.text else {return}
        signIn(email: "josh.hoyle@outlook.com", password: "password")
        
    }
    
    func signIn(email: String, password: String) {
        
        print(email)
        print(password)
        Auth.auth().signIn(withEmail: "josh.hoyle@outlook.com", password: "password") { [weak self]  authResult, error in
            guard let strongSelf = self else { return }
            print(strongSelf)
            
            self?.goToHome()
        }
    }
    
    func goToHome() {
        
        let homeViewController =
        storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        //homeViewController?.user = self.user
        view.window?.makeKeyAndVisible()
    }
    
    func fetchEmployeeIDandEmail() async {
        guard let uid = self.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument { [self] document, error in
            if let document = document {
                let employeeID = document["employeeID"] as? Int ?? 0
                let email = document["email"] as? String ?? ""
                self.employeeID = employeeID
                self.email = email
               
                print(employeeID)
                print(self.employeeID)
                
            }
        }
    }

     //This fetchEmployee function works in VC, but I'm screwing up the User Controller.

    func fetchEmployeeInfo(employeeID: Int) async {
        let employeeIDString = "\(self.employeeID)"
        print("Employee ID String is: \(employeeIDString)")
        Firestore.firestore().collection("employees").document(employeeIDString).getDocument {  [self] document, error in
            if let document = document {
                let email = document["email"] as? String ?? ""
                let firstName = document["firstName"] as? String ?? ""
                let lastName = document["lastName"] as? String ?? ""
                let phoneNumber = document["phoneNumber"] as? Int ?? 0
                let hireDate = document["hireDate"] as? String ?? ""
                
                let workLocation = document["workLocation"] as? String ?? ""
                let assignedLocation = document["assignedLocation"] as? String ?? ""
                let homeSort = document["homeSort"] as? String ?? ""
                print(homeSort)
                self.user?.email = self.email
                self.user?.firstName = firstName
                self.user?.lastName = lastName
                self.user?.phoneNumber = phoneNumber
                self.user?.hireDate = hireDate
                self.user?.workLocation = workLocation
                self.user?.assignedLocation = assignedLocation
                self.user?.homeSort = homeSort
                
                
                self.user?.employeeID = employeeID
                print(homeSort)
                print(self.user?.homeSort)
                
            }
        }
    }
    
} //end of class

