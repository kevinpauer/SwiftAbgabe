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
    
//    init(random: Bool = false) {
//        <#code#>
//    }
}
