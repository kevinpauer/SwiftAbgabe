//
//  Studio.swift
//  GymMaster
//
//  Created by Kevin Pauer on 11.06.22.
//

import Foundation

struct Studio: Identifiable, Hashable, Codable {
    
    var id: Int = 0
    var name: String = ""
    var mitgliedschaft: Double = 0.0
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var maintanence: Double = 0.0
}
