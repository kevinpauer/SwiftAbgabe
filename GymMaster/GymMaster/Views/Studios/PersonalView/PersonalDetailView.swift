//
//  PersonalDetailView.swift
//  GymMaster
//
//  Created by Kevin Pauer on 14.06.22.
//

import SwiftUI

struct PersonalDetailView: View {
    @State var personal: Personal
    @State var personalStorage: PersonalStorage
    @State var name: String = ""
    @State var alter: String = ""
    @State var adresse: String = ""
    @State var gehalt: String = ""
    
    @State var showingAlert: Bool = false
    
    func CheckIfInt (_ str: String) -> Bool {
        guard Int(str) != nil else {return false}
        return true
    }
    
    
    func CheckIfDouble (_ str: String) -> Bool {
        guard Double(str) != nil else {return false}
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
                
                ZStack(alignment: .leading) {
                    Text("Gehalt in € / Monat")
                        .foregroundColor(gehalt.isEmpty ? Color(.placeholderText) : .accentColor)
                        .offset(y: gehalt.isEmpty ? 0 : -25)
                        .scaleEffect(gehalt.isEmpty ? 1 : 0.8, anchor: .leading)
                    TextField("Gehalt in € / Monat", text: $gehalt)
                        .onChange(of: gehalt){
                            newValue in if !CheckIfDouble(gehalt) {
                                gehalt = String(newValue.dropLast())
                            }
                        }
                        .keyboardType(.numberPad)
                }
                .padding(.top)
                .animation(.default)
                
                Button("Speichern") {
                    var index =  personalStorage.allPersonal.firstIndex(where: {$0.id == personal.id})
                    if (index == nil) {
                        index = personalStorage.allPersonal.count
                        personalStorage.allPersonal.append(personal)
                        personalStorage.saveChanges()
                    }
                    personalStorage.allPersonal[index!].name = name
                    personalStorage.allPersonal[index!].alter = Int(alter) ?? 0
                    personalStorage.allPersonal[index!].adresse = adresse
                    personalStorage.allPersonal[index!].gehalt = Double(gehalt) ?? 0
                    personalStorage.saveChanges()
                    showingAlert = true
                }
            }
        }
        .lazyPop()
        .listStyle(GroupedListStyle())
        .onAppear(perform: {
            name = personal.name
            alter = String(personal.alter)
            if (alter == "0") {alter = ""}
            adresse = personal.adresse
            gehalt = String(personal.gehalt)
            if (gehalt == "0.0") {gehalt = ""}
        })
        .alert("Gespeichert", isPresented: $showingAlert) {
        }
    }
}
struct PersonalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDetailView(personal: Personal(random: true, studioID: 0), personalStorage: PersonalStorage())
    }
}
