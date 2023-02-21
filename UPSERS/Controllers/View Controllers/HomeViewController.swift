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
    /*
     : Int = 0{
     didSet {
     Task{
     await fetchEmployeeInfo(employeeID: employeedID)
     }
     }
     }
     */
    
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
        

        if segue.identifier == Constants.Storyboard.callOutViewController {
            let destinationVC = segue.destination as! CallOutViewController
            
            
           
            
            destinationVC.user = user
            
        }
        
        else if segue.identifier == Constants.Storyboard.extraWorkViewController {
            let destinationVC = segue.destination as? ExtraWorkViewController
        }
        else if segue.identifier == Constants.Storyboard.userExtraWorkTableViewController{
            let destinationVC = segue.destination as? UserExtraWorkTableViewController
        }
        
    }
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     if segue.identifier == Constants.Storyboard.callOutViewController {
     let destinationVC = segue.destination as! CallOutViewController
     
     guard let user = user else {return}
     destinationVC.user = user
     
     }
     
     else if segue.identifier == Constants.Storyboard.userCalloutsTableViewController{
     let destincationVC = segue.destination as? UserCalloutsTableViewController
     }
     else if segue.identifier == Constants.Storyboard.extraWorkViewController {
     let destinationVC = segue.destination as? ExtraWorkViewController
     }
     else if segue.identifier == Constants.Storyboard.userExtraWorkTableViewController{
     let destinationVC = segue.destination as? UserExtraWorkTableViewController
     }
     
     }
     */
    //MARK: - Actions
    
    //Delete all of these actions since they are handled via segues in Storyboard or are they needed to pass data?
    
    @IBAction func callOutButtonTapped(_ sender: Any) {
        let callOutViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.callOutViewController) as? CallOutViewController
        callOutViewController?.user = user
        view.window?.rootViewController = callOutViewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func viewCallOutsButtonTapped(_ sender: Any) {
        
    }
    @IBAction func extraWorkButtonTapped(_ sender: Any) {
        let extraWorkViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.extraWorkViewController) as? ExtraWorkViewController
        extraWorkViewController?.user = user
        view.window?.rootViewController = extraWorkViewController
        view.window?.makeKeyAndVisible()
    }
    @IBAction func viewExtraWorkButtonTapped(_ sender: Any) {
    }
    
    
    
    //MARK: - Functions
    
    
    func fetchEmployeeID() async {
        guard let uid = self.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument { [weak self] document, error in
            if let document = document {
                let employeeID = document["employeeID"] as? Int ?? 0
                self?.employeedID = employeeID
                print(self?.employeedID)
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
                self?.user.email = email
                self?.user.lastName = lastName
                self?.user.phoneNumber = phoneNumber
                self?.user.hireDate = hireDate
                self?.user.workLocation = workLocation
                self?.user.assignedLocation = assignedLocation
                self?.user.homeSort = homeSort
                
                
                self?.user.employeeID = employeeID
                print(homeSort)
                print(self?.user.homeSort)
                
            }
            
        }
    }
    
    
    
    func setUserInfo() {
        Task{
            await fetchEmployeeID()
            Task{
                await fetchEmployeeInfo(employeeID: employeedID)
            }
        }
        
    }
    
    
    /*
     func goToCallOut() {
     //print(user.homeSort)
     let callOutViewController =
     storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.callOutViewController) as? CallOutViewController
     
     view.window?.rootViewController = callOutViewController
     view.window?.makeKeyAndVisible()
     //callOutViewController?.user = self.user
     }
     
     func goToExtraWork() {
     let extraWorkViewController =
     storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.extraWorkViewController) as? ExtraWorkViewController
     
     view.window?.rootViewController = extraWorkViewController
     view.window?.makeKeyAndVisible()
     }
     
     func goToViewCallouts() {
     let myCalloutsViewController =
     storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.userCalloutsViewController) as? UserCallOutsTableViewController
     
     view.window?.rootViewController = myCalloutsViewController
     view.window?.makeKeyAndVisible()
     }
     
     func goToViewExtraWork() {
     let myExtraWorkViewController =
     storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.userExtraWorkViewController) as? UserExtraWorkTableViewController
     
     view.window?.rootViewController = myExtraWorkViewController
     view.window?.makeKeyAndVisible()
     }
     
     */
}//end of class
