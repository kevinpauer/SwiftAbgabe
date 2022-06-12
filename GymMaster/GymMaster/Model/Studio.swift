//
//  Studio.swift
//  GymMaster
//
//  Created by Kevin Pauer on 11.06.22.
//

import Foundation

struct Studio: Identifiable, Hashable, Codable {
    
    var id: Int = Int.random(in: 0...10000000)
    var name: String = ""
    var mitgliedschaft: Double = 0.0
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var maintanence: Double = 0.0
    
    init(random: Bool = false) {
        if random {
            latitude = drand48() * Double.random(in: 6...15)
            longitude = drand48() * Double.random(in: 47...55)
            name = "Gym"
            mitgliedschaft = 22.50
            maintanence = 10000
        }
    }
}
