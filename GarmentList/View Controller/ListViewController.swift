//
//  ViewController.swift
//  iOSTechnicalAssessment
//
//  Created by Talor Levy on 2/16/23.
//

import UIKit
import CoreData

class ListViewController: UIViewController {

    // MARK: - @IBOutlet

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var garmentTableView: UITableView!
    
    var garmentViewModel = GarmentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - @IBAction

    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex
        switch selectedSegmentIndex {
        case 0:
            garmentViewModel.garmentList = garmentViewModel.garmentList.sorted(by: { $0.creationTime ?? Date() < $1.creationTime ?? Date() })
        case 1:
            garmentViewModel.garmentList = garmentViewModel.garmentList.sorted(by: { ($0.name?.lowercased() ?? "") < ($1.name?.lowercased() ?? "") })
        default:
            break
        }
        garmentTableView.reloadData()
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
        guard let addVC = storyboard?.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController else { return }
        addVC.delegate = self
        self.navigationController?.pushViewController(addVC, animated: true)
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        garmentViewModel.garmentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "garmentCell") else { return UITableViewCell() }
        let garment = garmentViewModel.garmentList[indexPath.row]
        cell.textLabel?.text = garment.name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Update", style: .default, handler: { (action) in
            let garment = self.garmentViewModel.garmentList[indexPath.row]
            guard let updateVC = self.storyboard?.instantiateViewController(withIdentifier: "UpdateViewController") as? UpdateViewController else { return }
            updateVC.delegate = self
            updateVC.garment = garment
            updateVC.name = garment.name ?? ""
            updateVC.creationTime = garment.creationTime ?? Date()
            self.navigationController?.pushViewController(updateVC, animated: true)}))
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action) in
            let garment = self.garmentViewModel.garmentList[indexPath.row]
            self.garmentViewModel.deleteGarment(garment: garment)
            self.garmentTableView.reloadData()}))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
}

// MARK: - SendNewGarment

extension ListViewController: SendNewGarment {
    func sendNewGarment(garmentName: String) {
        garmentViewModel.addGarment(name: garmentName)
        garmentTableView.reloadData()
    }
}

// MARK: - SendUpdatedGarment

extension ListViewController: SendUpdatedGarment {
    func sendUpdatedGarment(garment: Garment, name: String, creationTime: Date) {
        garmentViewModel.updateGarment(garment: garment, name: name, creationTime: creationTime)
        garmentTableView.reloadData()
    }
}
