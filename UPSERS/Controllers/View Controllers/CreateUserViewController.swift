//
//  CreateUserViewController.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 8/5/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class CreateUserViewController: UIViewController {
    
    
    //MARK: - Properties
    
    var email = ""
    var password = ""
    var employeeID = 0
    var user: User?
    

    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var employeeIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK: - Actions
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let employeeIDText = employeeIDTextField.text else {return}
        let employeeID = Int(employeeIDText)
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error)
            } else {
                guard let employeeID = employeeID else {return}
               
                    UserController.shared.user?.employeeID = employeeID
                    
                self.addUserDoc(email: email, employeeID: employeeID)
                
                self.goToHome()
            }
        }
    }
    func addUserDoc(email: String, employeeID: Int){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let userDoc = Firestore.firestore().collection("users").document(uid)
        userDoc.setData([
            "email" : email,
            "employeeID" : employeeID
            
        ])
            }
    
    
    func goToHome() {
        
        let homeViewController =
        storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
}
