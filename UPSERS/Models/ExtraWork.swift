//
//  ExtraWork.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 12/31/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
 
struct ExtraWork: Identifiable, Codable {
    @DocumentID public var id: String?
    var employeeID: Int
    var extraWorkDate: String
    var extraWorkSort: String
    var firstName: String
    var hireDate: String
    var homeSort: String
    var lastName: String
    var phoneNumber: Int
    var workRequested: String
    
    enum CodingKeys: String, CodingKey {
        case employeeID
        case extraWorkDate
        case extraWorkSort
        case firstName
        case hireDate
        case homeSort
        case lastName
        case phoneNumber
        case workRequested
    }
    
}
