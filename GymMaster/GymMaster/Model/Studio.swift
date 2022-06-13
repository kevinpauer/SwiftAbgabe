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
    var maintenance: Double = 0.0
    
    init(random: Bool = false) {
        if random {
            latitude = Double.random(in: 48...50)
            longitude = Double.random(in: 8...11)
            name = "Fitness"
            mitgliedschaft = 22.50
            maintenance = 10000
        }
    }
}
