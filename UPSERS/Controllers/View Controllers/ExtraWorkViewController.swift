//
//  ExtraWorkViewController.swift
//  UPSERS
//
//  Created by Joshua Hoyle on 8/5/22.
//

import UIKit

class ExtraWorkViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: - Properties
    
    var user: User?
    var pickerDataSource: [String] = ["ALDOR-9739 PRE", "ALDOR-9739 DAY","ALDOR-9739 TWI", "ALDOR-9739 NIT", "POROR-9729 PRE", "POROR-9729 DAY" ,"POROR-9729 TWI", "POROR-9729 NIT", "HILOR-9712 PRE", "HILOR-9712 TWI", "PDXAP-NIT"]
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sortPIckerView.dataSource = self
        self.sortPIckerView.delegate = self
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var sortPIckerView: UIPickerView!
    
    @IBOutlet weak var extraWorkDatePicker: UIDatePicker!
    
    
    //MARK: - Actions
    
    @IBOutlet weak var sortPickerSelected: UIPickerView!
    
    @IBAction func datePickerSelected(_ sender: Any) {
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        goToHome()
    }
    
    
    //MARK: - Functions
    
    func goToHome() {
        
        let homeViewController =
        storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
