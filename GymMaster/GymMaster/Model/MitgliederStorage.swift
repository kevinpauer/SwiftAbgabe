//
//  MitgliederStorage.swift
//  GymMaster
//
//  Created by Kevin Pauer on 11.06.22.
//

import Foundation

class MitgliederStorage: ObservableObject {
    @Published var allMitglieder: [Mitglied] = []
    
    let MitgliederStorageURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("MitgliederStorage.archieve")
    }()
    
    init(){
        do {
            let data = try Data(contentsOf: MitgliederStorageURL)
            if let allMitglieder = try PropertyListDecoder().decode([Mitglied]?.self, from: data){
                self.allMitglieder = allMitglieder
            }
            print("Successfully loaded all mitglieder")
        } catch {
            print("MitgliederStorage init err: \(error)")
        }
    }
    
    @discardableResult func newMitglied() -> (Int, Mitglied) {
        let newMitglied = Mitglied()
        allMitglieder.append(newMitglied)
        let index: Int = allMitglieder.firstIndex(of: newMitglied)!
        return(index, newMitglied)
    }
    
    func removeMitglied(indexSet: IndexSet) {
        allMitglieder.remove(atOffsets: indexSet)
    }
    
    func moveMitglied(from source: IndexSet, to destination: Int) {
        allMitglieder.move(fromOffsets: source, toOffset: destination)
    }
    
    func saveChanges() -> Bool {
        print("Saving mitglieder to \(MitgliederStorageURL.path)")
        do {
            let data = try PropertyListEncoder().encode(allMitglieder)
            try data.write(to: MitgliederStorageURL)
            return true
        } catch {
            print("Error saving mitglieder: \(error)")
        }
        return false
    }
    
    @discardableResult func createMitglied() -> Mitglied {
        let newMitglied = Mitglied(random: true)
        allMitglieder.append(newMitglied)
        return newMitglied
    }
    
    init(numberOfRandomMitglieder: Int = 10) {
        for _ in 0..<numberOfRandomMitglieder {
            createMitglied()
        }
    }
}
