//
//  UserExtraWorkTableViewController.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 2/21/23.
//

import UIKit
import Firebase
import FirebaseFirestore

class UserExtraWorkTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    var user: User?
    var extraWork: ExtraWork?
    var extraWorks: [ExtraWork] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return extraWorks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userExtraWorkCell", for: indexPath)
        
        
        
        return cell
    }
    
    
    
    
  //MARK: - Functions
    
    func fetchExtraWork(employeeID: Int) {
        guard let user = user else {return}
        db.collection("corporate").document(user.workLocation).collection("extraWork").whereField("employeeID", isEqualTo: user.employeeID).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No Documents")
                    return
                }
                let extaWork = documents.map { QueryDocumentSnapshot -> CallOut in
                    let data = QueryDocumentSnapshot.data()
                    let employeeID = data["employeeID"] as? Int ?? 0
                    let extraWorkDate = data["extraWorkDate"] as? String ?? ""
                    let extraWorkSort = data["extraWorkSort"] as? String ?? ""
                    let firstName = data["firstName"] as? String ?? ""
                    let hireDate = data["hireDate"] as? String ?? ""
                    let homeSort = data["homeSort"] as? String ?? ""
                    let lastName = data["lastName"] as? String ?? ""
                    let phoneNumber = data["phoneNumber"] as? Int ?? 0
                    let workLocation = data["workLocation"] as? String ?? ""
                    let workRequested = data["workRequested"] as? String ?? ""
                    self.extraWork?.employeeID = employeeID
                    self.extraWork?.extraWorkDate = extraWorkDate
                    self.extraWork?.firstName = firstName
                    self.extraWork?.lastName = lastName
                    self.extraWork?.homeSort = homeSort
                    guard let extraWork = extraWork else {return}
                    extraWorks.append(extraWork)
                    print(extraWorks)
                }
            }
        }
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}
