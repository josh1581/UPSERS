//
//  UserCallOutsTableViewCell.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 1/29/23.
//

import UIKit

class UserCallOutsTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    var callOut: CallOut? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var userCallOutDateLabel: UILabel!
    
    @IBOutlet weak var userCallOutHomeSortLabel: UILabel!
    
    //MARK: - Functions
    
    func updateViews() {
        guard let callOut = callOut else {return}
        userCallOutDateLabel.text = callOut.callOutDate
        userCallOutHomeSortLabel.text = callOut.homeSort
    }
  
    
}// end of class
