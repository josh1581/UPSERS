//
//  User.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 12/31/21.
//

import UIKit

class User {
    
    var employeeID: Int
    var email: String
    var firstName: String
    var lastName: String
    var phoneNumber: Int
    var hireDate: String
    var workLocation: String
    var district: String
    var assignedLocation: String
    var homeSort: String
    
    init(employeeID: Int, email: String, firstName: String, lastName: String, phoneNumber: Int, hireDate: String, workLocation: String, district: String, assignedLocation: String, homeSort: String) {
        self.employeeID = employeeID
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.hireDate = hireDate
        self.workLocation = workLocation
        self.district = district
        self.assignedLocation = assignedLocation
        self.homeSort = homeSort
    }
}
