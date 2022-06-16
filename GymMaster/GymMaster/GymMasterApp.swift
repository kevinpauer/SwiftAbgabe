//
//  GymMasterApp.swift
//  GymMaster
//
//  Created by Kevin Pauer on 11.06.22.
//

import SwiftUI

@main
struct GymMasterApp: App {
    
    @StateObject var studioStorage = StudioStorage(numberOfRandomStudios: 10)
    @StateObject var mitgliederStorage = MitgliederStorage(numberOfRandomMitglieder: 0)
    @StateObject var personalStorage = PersonalStorage(numberOfRandomPersonal: 0)
    
    var body: some Scene {
        WindowGroup {
            VStack{
                Text("GymMaster").font(.title)
                TabView() {
                    StudiosView(studioStorage: studioStorage, mitgliederStorage: mitgliederStorage, personalStorage: personalStorage).tabItem(){
                        Text("Studios")
                        Image(systemName: "building")}
                    KarteView(studioStorage: studioStorage).tabItem(){
                        Text("Karte")
                        Image(systemName: "map")}
                    FinanzenView(studioStorage: studioStorage, mitgliederStorage: mitgliederStorage, personalStorage: personalStorage).tabItem(){
                        Text("Finanzen")
                        Image(systemName: "dollarsign.circle")}
                }
            }
        }
    }
}
