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
                let db = Firestore.firestore()
                guard let employeeID = employeeID else {return}
                db.collection("users").addDocument(data: ["email":email, "employeeID":employeeID, "uid": result!.user.uid]) { (error) in
                    if error != nil {
                        print(error)
                    }
                }
                self.goToHome()
                
                
                
                
            }
        }
    }
    
    func goToHome() {
        
        let homeViewController =
        storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()  
    }
}
