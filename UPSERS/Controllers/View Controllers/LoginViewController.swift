//
//  LoginViewController.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 8/5/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    
    var user: User?
    
    
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
        Task {
            await UserController.shared.fetchEmployeeID()
        }
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
        view.window?.makeKeyAndVisible()
    }
    
}
