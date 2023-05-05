//
//  UserViewModel.swift
//  UserRegistrationForm
//
//  Created by Talor Levy on 2/19/23.
//

import Foundation

class GarmentViewModel {
    
    var garmentList: [Garment] = []
    
    init() {
        garmentList = CoreDataManager.shared.fetchGarmentsFromCoreData()
    }
    
    func addGarment(name: String) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let garment = Garment(context: context)
        garment.name = name
        garment.creationTime = Date()
        garmentList.append(garment)
        CoreDataManager.shared.addGarment(garment: garment)
    }
    
    func deleteGarment(garment: Garment) {
        CoreDataManager.shared.deleteGarment(garment: garment)
        if let index = garmentList.firstIndex(of: garment) {
            garmentList.remove(at: index)
        }
    }
    
    func updateGarment(garment: Garment, name: String, creationTime: Date) {
        CoreDataManager.shared.updateGarment(garment: garment, name: name)
        if let index = garmentList.firstIndex(where: { $0.creationTime == creationTime }) {
            garmentList[index].name = name
        }
    }
}
