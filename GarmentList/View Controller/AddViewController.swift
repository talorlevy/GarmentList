//
//  AddViewController.swift
//  iOSTechnicalAssessment
//
//  Created by Talor Levy on 2/16/23.
//

import UIKit
import CoreData

class AddViewController: UIViewController {

    // MARK: - @IBOutlet

    @IBOutlet weak var nameTextField: UITextField!
        
    var delegate: SendNewGarment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - @IBAction

    @IBAction func saveButtonAction(_ sender: Any) {
        if (nameTextField.text == "") {
            let alertController = UIAlertController(title: "Warning", message: "You did not give the garment a name!", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true,completion: nil)
        } else {
            if let delegateValue = delegate, let garmentName = nameTextField.text {
                delegateValue.sendNewGarment(garmentName: garmentName)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
}


// MARK: - SendNewGarment

protocol SendNewGarment {
    func sendNewGarment(garmentName: String)
}
