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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        guard let user = user else {return}
        Task {
            await fetchExtraWork(employeeID: user.employeeID)
        }
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return extraWorks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userExtraWorkCell", for: indexPath) as? UserExtraWorkTableViewCell
        let extraWork = extraWorks[indexPath.row]
        cell?.extraWork = extraWork
        return cell ?? UITableViewCell()
        
    }
    
    
    
    
    //MARK: - Functions
    
    func fetchExtraWork(employeeID: Int) async {
        guard let user = user else {return}
        db.collection("corporate").document(user.workLocation).collection("extraWork").whereField("employeeID", isEqualTo: user.employeeID).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No documents.")
                    return
                }
                self.extraWorks = documents.compactMap { queryDocumentSnapshot -> ExtraWork? in
                    return try? queryDocumentSnapshot.data(as: ExtraWork.self)
                }
            }
        }
    }
    /*
    func fetchExtraWork(employeeID: Int) async {
        guard let user = user else {return}
        db.collection("corporate").document(user.workLocation).collection("extraWork").whereField("employeeID", isEqualTo: user.employeeID).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error).")
                
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No Documents.")
                    return
                }
                
                self.extraWorks = documents.compactMap { queryDocumentSnapshot -> ExtraWork? in
                    return try? queryDocumentSnapshot.data(as: ExtraWork.self)
                }
                print(self.extraWorks)
                print(self.extraWorks.count)
                self.tableView.reloadData()
                
            }
        }
    }
    
   */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}//end of class
