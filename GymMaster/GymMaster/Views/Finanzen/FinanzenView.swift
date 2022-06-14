//
//  Finanzen.swift
//  GymMaster
//
//  Created by Kevin Pauer on 11.06.22.
//

import SwiftUI

struct FinanzenView: View {
    @StateObject var studioStorage: StudioStorage
    @StateObject var mitgliederStorage: MitgliederStorage
    @StateObject var personalStorage: PersonalStorage
    @State var values: [Double] = [0.1, 0.1]
    @State var mitglieder: [Mitglied] = []
    @State var personal: [Personal] = []
    @State var einnahmen: Double = 0
    @State var ausgaben: Double = 0
    var body: some View {
        PieChartView(values: values, names: ["Ausgaben", "Einnahmen"], formatter: {value in String(format: "%.2f €", value)})
            .onAppear(perform: {
                values = []
                einnahmen = 0
                ausgaben = 0
                for studio in studioStorage.allStudios {
                    mitglieder = mitgliederStorage.allMitglieder.filter {
                        mitglied in return mitglied.studioId == studio.id
                    }
                    einnahmen += Double(mitglieder.count) *  Double(studio.mitgliedschaft)
                    ausgaben += studio.maintenance
                }
                ausgaben += personalStorage.allPersonal.map({$0.gehalt}).reduce(0, +)
                
                values.append(ausgaben)
                
                einnahmen = 100000
                
                values.append(einnahmen)
            })
    }
}

struct FinanzenView_Previews: PreviewProvider {
    static var previews: some View {
        FinanzenView(studioStorage: StudioStorage(), mitgliederStorage: MitgliederStorage(), personalStorage: PersonalStorage())
    }
}
