//
//  StudioStorage.swift
//  GymMaster
//
//  Created by Kevin Pauer on 11.06.22.
//

import Foundation

class StudioStorage: ObservableObject {
    @Published var allStudios: [Studio] = []
    
    let StudioStorageURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("StudioStorage.archieve")
    }()
    
    init(){
        do {
            let data = try Data(contentsOf: StudioStorageURL)
            if let allStudios = try PropertyListDecoder().decode([Studio]?.self, from: data){
                self.allStudios = allStudios
            }
            print("Successfully loaded all studios")
        } catch {
            print("StudioStorage init err: \(error)")
        }
    }
    
    @discardableResult func newStudio() -> (Int, Studio) {
        let newStudio = Studio()
        allStudios.append(newStudio)
        let index: Int = allStudios.firstIndex(of: newStudio)!
        return(index, newStudio)
    }
    
    func removeStudio(indexSet: IndexSet) {
        allStudios.remove(atOffsets: indexSet)
    }
    
    func moveStudio(from source: IndexSet, to destination: Int) {
        allStudios.move(fromOffsets: source, toOffset: destination)
    }
    
    func saveChanges() -> Bool {
        print("Saving studios to \(StudioStorageURL.path)")
        do {
            let data = try PropertyListEncoder().encode(allStudios)
            try data.write(to: StudioStorageURL)
            return true
        } catch {
            print("Error saving studios: \(error)")
        }
        return false
    }
}
