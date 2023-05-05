//
//  UpdateViewController.swift
//  UserRegistrationForm
//
//  Created by Talor Levy on 2/19/23.
//

import UIKit

class UpdateViewController: UIViewController {

    // MARK: - @IBOutlet

    @IBOutlet weak var nameTextField: UITextField!
    
    var delegate: SendUpdatedGarment?
    
    var garment: Garment = Garment()
    var name: String = ""
    var creationTime: Date = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGarmentData()
    }
    
    func loadGarmentData() {
        nameTextField.text = name
        creationTime = garment.creationTime ?? Date()
    }
    
    // MARK: - @IBAction

    @IBAction func updateButtonAction(_ sender: Any) {
        if let delegateValue = delegate {
            delegateValue.sendUpdatedGarment(garment: garment, name: nameTextField.text ?? "", creationTime: creationTime)
        }
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - SendUpdatedGarment

protocol SendUpdatedGarment {
    func sendUpdatedGarment(garment: Garment, name: String, creationTime: Date)
}
