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
    
//    init(random: Bool = false) {
//        <#code#>
//    }
}
