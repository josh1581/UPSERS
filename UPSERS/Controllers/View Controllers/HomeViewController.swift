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
    let db = Firestore.firestore()
    var user: User?
    
    var userController = UserController()
    
    /*
    var employeedID: Int = 0{
        didSet {
            Task{
                await fetchEmployeeInfo(employeeID: employeedID)
            }
        }
    }
    
  */
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        Task{
            await userController.fetchEmployeeID()
            
        }
        
    super.viewDidLoad()
    
}

//MARK: - Outlets


// MARK: - Navigation


override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == Constants.Storyboard.callOutViewController {
        let destinationVC = segue.destination as! CallOutViewController
        //destinationVC.user = self.user
    }
    
}

//MARK: - Actions

//Delete all of these actions since they are handled via segues in Storyboard or are they needed to pass data?

@IBAction func callOutButtonTapped(_ sender: Any) {
    // goToCallOut()
}

@IBAction func viewCallOutsButtonTapped(_ sender: Any) {
}
@IBAction func extraWorkButtonTapped(_ sender: Any) {
}
@IBAction func viewExtraWorkButtonTapped(_ sender: Any) {
}



//MARK: - Functions
    
    


/*
func fetchEmployeeID() async {
    guard let uid = self.uid else {return}
    Firestore.firestore().collection("users").document(uid).getDocument { [self] document, error in
        if let document = document {
            let employeeID = document["employeeID"] as? Int ?? 0
            self.employeedID = employeeID
           
            print(employeeID)
            print(self.employeedID)
            
        }
    }
}

 //This fetchEmployee function works in VC, but I'm screwing up the User Controller.

func fetchEmployeeInfo(employeeID: Int) async {
    let employeeIDString = "\(self.employeedID)"
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
            self.user.email = email
            self.user.firstName = firstName
            self.user.lastName = lastName
            self.user.phoneNumber = phoneNumber
            self.user.hireDate = hireDate
            self.user.workLocation = workLocation
            self.user.assignedLocation = assignedLocation
            self.user.homeSort = homeSort
            
            
            self.user.employeeID = employeeID
            print(homeSort)
            print(self.user.homeSort)
            
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
 */
    
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
