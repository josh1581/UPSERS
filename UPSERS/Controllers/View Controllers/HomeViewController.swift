//
//  HomeViewController.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 8/5/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    lazy var userController: UserController? = UserController()
    var user = User(employeeID: 0, email: "", firstName: "", lastName: "", phoneNumber: 0, hireDate: nil, workLocation: "", district: "", assignedLocation: "", homeSort: "")
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userController?.setUserInfo()
        
        
        
        
        
        
    }
    
    //MARK: - Outlets
    
    
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK: - Actions
    
    
}
