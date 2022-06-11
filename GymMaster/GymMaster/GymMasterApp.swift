//
//  GymMasterApp.swift
//  GymMaster
//
//  Created by Kevin Pauer on 11.06.22.
//

import SwiftUI

@main
struct GymMasterApp: App {
    var body: some Scene {
        WindowGroup {
            VStack{
                Text("GymMaster").font(.title)
                TabView() {
                    StudiosView(studioStorage: StudioStorage()).tabItem(){
                        Text("Studios")
                        Image(systemName: "building")}
                    FinanzenView().tabItem(){
                        Text("Finanzen")
                        Image(systemName: "dollarsign.circle")}
                }
            }
        }
    }
}
