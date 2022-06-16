//
//  MitgliederDetailView.swift
//  GymMaster
//
//  Created by Kevin Pauer on 14.06.22.
//

import SwiftUI

struct MitgliederDetailView: View {
    @State var mitglied: Mitglied
    @State var mitgliederStorage: MitgliederStorage
    @State var name: String = ""
    @State var alter: String = ""
    @State var adresse: String = ""
    
    @State var showingAlert: Bool = false
    
    func CheckIfInt (_ str: String) -> Bool {
        guard Int(str) != nil else {return false}
        return true
    }
    
    var body: some View {
        Form {
            Section(header: Text("Informationen")) {
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
                    Text("Alter")
                        .foregroundColor(alter.isEmpty ? Color(.placeholderText) : .accentColor)
                        .offset(y: alter.isEmpty ? 0 : -25)
                        .scaleEffect(alter.isEmpty ? 1 : 0.8, anchor: .leading)
                    TextField("Alter", text: $alter)
                        .onChange(of: alter){
                            newValue in if !CheckIfInt(alter) {
                                alter = String(newValue.dropLast())
                            }
                        }
                        .keyboardType(.numberPad)
                }
                .padding(.top)
                .animation(.default)
                
                ZStack(alignment: .leading) {
                    Text("Adresse")
                        .foregroundColor(adresse.isEmpty ? Color(.placeholderText) : .accentColor)
                        .offset(y: adresse.isEmpty ? 0 : -25)
                        .scaleEffect(adresse.isEmpty ? 1 : 0.8, anchor: .leading)
                    TextField("Adresse", text: $adresse)
                        .keyboardType(.numberPad)
                }
                .padding(.top)
                .animation(.default)
                
                
                Button("Speichern") {
                    var index =  mitgliederStorage.allMitglieder.firstIndex(where: {$0.id == mitglied.id})
                    if (index == nil) {
                        index = mitgliederStorage.allMitglieder.count
                        mitgliederStorage.allMitglieder.append(mitglied)
                        mitgliederStorage.saveChanges()
                    }
                    mitgliederStorage.allMitglieder[index!].name = name
                    mitgliederStorage.allMitglieder[index!].alter = Int(alter) ?? 0
                    mitgliederStorage.allMitglieder[index!].adresse = adresse
                    mitgliederStorage.saveChanges()
                    showingAlert = true
                }
            }
        }
        .lazyPop()
        .listStyle(GroupedListStyle())
        .onAppear(perform: {
            name = mitglied.name
            alter = String(mitglied.alter)
            if (alter == "0") {alter = ""}
            adresse = mitglied.adresse
        })
        .alert("Gespeichert", isPresented: $showingAlert) {
        }
    }
}
struct MitgliederDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MitgliederDetailView(mitglied: Mitglied(random: true, studioID: 0), mitgliederStorage: MitgliederStorage())
    }
}
