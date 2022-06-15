//
//  Personal.swift
//  GymMaster
//
//  Created by Kevin Pauer on 11.06.22.
//

import Foundation

struct Personal: Identifiable, Hashable, Codable {
    var name: String = ""
    var alter: Int = 0
    var id: Int = 0
    var adresse: String = ""
    var gehalt: Double = 0.0
    var studioId: Int = 0
    
    init(random: Bool = false, studioID: Int) {
		if random {
			name = "Bubatz Beispiel"
			alter = 69
			id = Int.random(in: 0...100000000)
			adresse = "Beispielgasse 69"
			gehalt = 187
            self.studioId = studioID
		}
    }
}
