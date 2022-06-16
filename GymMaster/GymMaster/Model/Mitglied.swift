//
//  Mitglied.swift
//  GymMaster
//
//  Created by Kevin Pauer on 11.06.22.
//

import Foundation

struct Mitglied: Identifiable, Hashable, Codable {
    var name: String = ""
    var alter: Int = 0
    var id: Int = 0
    var adresse: String = ""
    var studioId: Int = 0
    
    init(random: Bool = false, studioID: Int) {
        id = Int.random(in: 0...100000000)
        self.studioId = studioID
        if random {
            name = "Bubatz Beispiel"
            alter = 69
            adresse = "Beispielgasse 69"
        }
    }
}
