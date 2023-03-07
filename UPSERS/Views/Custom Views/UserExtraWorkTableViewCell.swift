//
//  UserExtraWorkTableViewCell.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 3/7/23.
//

import UIKit

class UserExtraWorkTableViewCell: UITableViewCell {
    
    //MARK: - Properties

    var extraWork: ExtraWork? {
        didSet {
            updateViews()
        }
    }
    

    //MARK: - Outlets
    
    
    @IBOutlet weak var extraWorkDateLabel: UILabel!
    @IBOutlet weak var extraWorkSortLabel: UILabel!
    
    
    //MARK: - Functions
    
    func updateViews() {
        guard let extraWork = extraWork else {return}
        extraWorkDateLabel.text = extraWork.extraWorkDate
        extraWorkDateLabel.text = extraWork.extraWorkSort
    }

}//end of class
