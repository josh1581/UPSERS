//
//  UserCalloutsTableViewController.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 2/21/23.
//

import UIKit
import Firebase
import FirebaseFirestore


class UserCalloutsTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    var user: User?
    var callOut: CallOut?
    var callOuts: [CallOut] = []
    let db = Firestore.firestore()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return callOuts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCallOutsCell", for: indexPath)
        return cell
    }
    
    
   
    //MARK: - Functions
    
    func fetchCallOuts(employeeID: Int) {
        guard let user = user else {return}
        db.collection("corporate").document(user.workLocation).collection("callOuts").whereField("employeeID", isEqualTo: user.employeeID).getDocuments { QuerySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let documents = QuerySnapshot?.documents else {
                    print("No Documents")
                    return
                }
                let callout = documents.map { QueryDocumentSnapshot -> CallOut in
                    let data = QueryDocumentSnapshot.data()
                    let assignedLocation = data["assignedLocation"] as? String ?? ""
                    let callOutDate = data["callOutDate"] as? String ?? ""
                    let employeeID = data["employeeID"] as? Int ?? 0
                    let firstName = data["firstName"] as? String ?? ""
                    let lastName = data["lastName"] as? String ?? ""
                    let homeSort = data["homeSort"] as? String ?? ""
                    self.callOut?.assignedLocation = assignedLocation
                    self.callOut?.callOutDate = callOutDate
                    self.callOut?.firstName = firstName
                    self.callOut?.lastName = lastName
                    self.callOut?.homeSort = homeSort
                    guard let callOut = callOut else {return}
                    callOuts.append(callOut)
                    print(callOuts)
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
