//
//  PersonalStorage.swift
//  GymMaster
//
//  Created by Kevin Pauer on 11.06.22.
//

import Foundation
import Combine

class PersonalStorage: ObservableObject {
    @Published var allPersonal: [Personal] = []
    
    let PersonalStorageURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("PersonalStorage.archieve")
    }()
    
    init(){
        do {
            let data = try Data(contentsOf: PersonalStorageURL)
            if let allPersonal = try PropertyListDecoder().decode([Personal]?.self, from: data){
                self.allPersonal = allPersonal
            }
            print("Successfully loaded all personal")
        } catch {
            print("PersonalStorage init err: \(error)")
        }
    }
	
	@discardableResult func createPersonal() -> Personal {
		let newPersonal = Personal(random: true)
		allPersonal.append(newPersonal)
		saveChanges()
		return newPersonal
	}
    
	@discardableResult func newPersonal(studioId: Int) -> (Int, Personal) {
        var newPersonal = Personal()
		newPersonal.studioId = studioId
        allPersonal.append(newPersonal)
		saveChanges()
        let index: Int = allPersonal.firstIndex(of: newPersonal)!
        return(index, newPersonal)
    }
    
    func removePersonal(indexSet: IndexSet) {
        allPersonal.remove(atOffsets: indexSet)
    }
    
    func movePersonal(from source: IndexSet, to destination: Int) {
        allPersonal.move(fromOffsets: source, toOffset: destination)
    }
    
    func saveChanges() -> Bool {
        print("Saving personal to \(PersonalStorageURL.path)")
        do {
            let data = try PropertyListEncoder().encode(allPersonal)
            try data.write(to: PersonalStorageURL)
            return true
        } catch {
            print("Error saving personal: \(error)")
        }
        return false
    }
  
    init(numberOfRandomPersonal: Int = 10) {
        for _ in 0..<numberOfRandomPersonal {
            createPersonal()
        }
    }
}
