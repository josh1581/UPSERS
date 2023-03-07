//
//  CallOut.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 12/31/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


struct CallOut: Identifiable, Codable {
   @DocumentID public var id: String?
    var assignedLocation: String
    var callOutDate: String
    var employeeID: Int
    var firstName: String
    var homeSort: String
    var lastName: String
    
    enum CodingKeys: String, CodingKey {
        case assignedLocation
        case callOutDate
        case employeeID
        case firstName
        case homeSort
        case lastName
    }
}
