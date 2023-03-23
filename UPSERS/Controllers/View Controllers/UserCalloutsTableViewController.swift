//
//  UserCalloutsTableViewController.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 2/21/23.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


class UserCalloutsTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    var user: User?
    var callOut: CallOut?
    var callOuts: [CallOut] = []
    let db = Firestore.firestore()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        guard let user = user else {return}
        Task {
            await  fetchCallOuts(employeeID: user.employeeID)
        }
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.callOuts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCallOutsCell", for: indexPath) as? UserCallOutsTableViewCell
        let callOut = callOuts[indexPath.row]
        cell?.callOut = callOut
        return cell ?? UITableViewCell()
    }
    
    
    //MARK: - Functions
    
    func fetchCallOuts(employeeID: Int) async {
        guard let user = user else {return}
        db.collection("corporate").document(user.workLocation).collection("callOuts").whereField("employeeID", isEqualTo: user.employeeID).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error).")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No documents.")
                    return
                }
                self.callOuts = documents.compactMap { queryDocumentSnapshot -> CallOut? in
                    return try? queryDocumentSnapshot.data(as: CallOut.self)
                    
                }
                print(self.callOuts)
                print(self.callOuts.count)
                self.tableView.reloadData()
            }
        }
    }
    
    
    
}// end of class
