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
    
    var body: some Scene {
        WindowGroup {
            VStack{
                Text("GymMaster").font(.title)
                TabView() {
                    StudiosView(studioStorage: studioStorage).tabItem(){
                        Text("Studios")
                        Image(systemName: "building")}
                    KarteView().tabItem(){
                        Text("Karte")
                        Image(systemName: "map")}
                    FinanzenView().tabItem(){
                        Text("Finanzen")
                        Image(systemName: "dollarsign.circle")}
                }
            }
        }
    }
}
