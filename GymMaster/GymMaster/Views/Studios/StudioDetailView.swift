//
//  StudioDetailView.swift
//  GymMaster
//
//  Created by Kevin Pauer on 11.06.22.
//

import SwiftUI

struct StudioDetailView: View {
    
    @State var name: String = ""
    @State var mitgliedschaft: String = "40"
    @State var latitude: String = ""
    @State var longitude: String = ""
    @State var maintenance: String = ""
    @State var showingAlert: Bool = false
    
    @StateObject var studioStorage: StudioStorage
    @StateObject var personalStorage: PersonalStorage
    @StateObject var mitgliederStorage: MitgliederStorage
    var studioID: Int
    
    @State var studio: Studio = Studio()
    @State var personal: [Personal] = []
    @State var mitglieder: [Mitglied] = []
    @State var personalKosten: Double = 0.0
    @State var mitgliederEinnahmen: Double = 0.0
    
    func CheckIfDouble (_ str: String) -> Bool {
        guard Double(str) != nil else {return false}
        return true
    }
    
    
    var body: some View {
        Form {
            Section(header: Text("Generelle Daten")) {
                ZStack(alignment: .leading) {
                    Text("Name")
                        .foregroundColor(name.isEmpty ? Color(.placeholderText) : .accentColor)
                        .offset(y: name.isEmpty ? 0 : -25)
                        .scaleEffect(name.isEmpty ? 1 : 0.8, anchor: .leading)
                    TextField("Name", text: $name)
                }
                .padding(.top)
                .animation(.default)
                
                ZStack(alignment: .leading) {
                    Text("Mitgliedschaft in € / Monat")
                        .foregroundColor(mitgliedschaft.isEmpty ? Color(.placeholderText) : .accentColor)
                        .offset(y: mitgliedschaft.isEmpty ? 0 : -25)
                        .scaleEffect(mitgliedschaft.isEmpty ? 1 : 0.8, anchor: .leading)
                    TextField("Mitgliedschaft in € / Monat", text: $mitgliedschaft)
                        .onChange(of: mitgliedschaft){
                            newValue in if !CheckIfDouble(mitgliedschaft) {
                                mitgliedschaft = String(newValue.dropLast())
                            } else {
                                mitgliederEinnahmen = Double(round(100 * Double(mitglieder.count) * (Double(mitgliedschaft) ?? 0)) / 100)
                            }
                        }
                        .keyboardType(.numberPad)
                }
                .padding(.top)
                .animation(.default)
                
                ZStack(alignment: .leading) {
                    Text("Latitude")
                        .foregroundColor(latitude.isEmpty ? Color(.placeholderText) : .accentColor)
                        .offset(y: latitude.isEmpty ? 0 : -25)
                        .scaleEffect(latitude.isEmpty ? 1 : 0.8, anchor: .leading)
                    TextField("Latitude", text: $latitude)
                        .onChange(of: latitude){
                            newValue in if !CheckIfDouble(latitude) {
                                latitude = String(newValue.dropLast())
                            }
                        }
                        .keyboardType(.numberPad)
                }
                .padding(.top)
                .animation(.default)
                
                ZStack(alignment: .leading) {
                    Text("Longitude")
                        .foregroundColor(longitude.isEmpty ? Color(.placeholderText) : .accentColor)
                        .offset(y: longitude.isEmpty ? 0 : -25)
                        .scaleEffect(longitude.isEmpty ? 1 : 0.8, anchor: .leading)
                    TextField("Longitude", text: $longitude)
                        .onChange(of: longitude){
                            newValue in if !CheckIfDouble(longitude) {
                                longitude = String(newValue.dropLast())
                            }
                        }
                        .keyboardType(.numberPad)
                }
                .padding(.top)
                .animation(.default)
                
                ZStack(alignment: .leading) {
                    Text("Maintenance in € / Monat")
                        .foregroundColor(maintenance.isEmpty ? Color(.placeholderText) : .accentColor)
                        .offset(y: maintenance.isEmpty ? 0 : -25)
                        .scaleEffect(maintenance.isEmpty ? 1 : 0.8, anchor: .leading)
                    TextField("Maintenance in € / Monat", text: $maintenance)
                        .onChange(of: maintenance){
                            newValue in if !CheckIfDouble(maintenance) {
                                maintenance = String(newValue.dropLast())
                            }
                        }
                        .keyboardType(.numberPad)
                }
                .padding(.top)
                .animation(.default)
                
                Button("Speichern") {
                    let index =  studioStorage.allStudios.firstIndex(where: {$0.id == studioID})
                    studioStorage.allStudios[index!].name = name
                    studioStorage.allStudios[index!].mitgliedschaft = Double(mitgliedschaft) ?? 0
                    studioStorage.allStudios[index!].latitude = Double(latitude) ?? 0
                    studioStorage.allStudios[index!].longitude = Double(longitude) ?? 0
                    studioStorage.allStudios[index!].maintenance = Double(maintenance) ?? 0
                    studioStorage.saveChanges()
                    showingAlert = true
                }
            }
            
            Section(header: Text("Information")) {
                Text("Personalkosten: \(String(format: "%.2f", personalKosten)) € / Monat")
                Text("Gesamtkosten: \(String(format: "%.2f", personalKosten + (Double(maintenance) ?? 0))) € / Monat")
                Text("Mitgliedschaftseinnahmen: \(String(format: "%.2f", mitgliederEinnahmen)) € / Monat")
                Text("Profit: \(String(format: "%.2f", mitgliederEinnahmen - (personalKosten + (Double(maintenance) ?? 0)))) € / Monat")
            }
            
            Section(header: Text("Verwaltung")) {
                NavigationLink(destination: MitgliederView()){
                    Text("Mitglieder")
                }
				NavigationLink(destination: PersonalView(personalStorage: personalStorage, studioId: studioID)){
                    Text("Personal")
                }
            }
        }
        .lazyPop()
        .listStyle(GroupedListStyle())
        .onAppear(perform: {
            let index =  studioStorage.allStudios.firstIndex(where: {$0.id == studioID})
            name = studioStorage.allStudios[index!].name
            mitgliedschaft = String(studioStorage.allStudios[index!].mitgliedschaft)
            latitude = String(studioStorage.allStudios[index!].latitude)
            longitude = String(studioStorage.allStudios[index!].longitude)
            maintenance = String(studioStorage.allStudios[index!].maintenance)
            
            personal = personalStorage.allPersonal.filter {
                personal in return personal.studioId == studioID
            }
            mitglieder = mitgliederStorage.allMitglieder.filter {
                mitglied in return mitglied.studioId == studioID
            }
            
            personalKosten = personal.map({$0.gehalt}).reduce(0, +)
            mitgliederEinnahmen = Double(round(100 * Double(mitglieder.count) * (Double(mitgliedschaft) ?? 0)) / 100)
        })
        .alert("Gespeichert", isPresented: $showingAlert) {
        }
    }
}

struct StudioDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StudioDetailView(studioStorage: StudioStorage(), personalStorage: PersonalStorage(), mitgliederStorage: MitgliederStorage(), studioID: 0)
    }
}
