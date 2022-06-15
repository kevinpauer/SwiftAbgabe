//
//  PersonalView.swift
//  GymMaster
//
//  Created by Calvin Friedrich on 13.06.22.
//

import SwiftUI
import QGrid

struct PersonalView: View {
    @StateObject var personalStorage: PersonalStorage
    @State var studioId: Int
    @State var personal: [Personal] = []
    @State var indexOfPerson: Int = 0
    @State var newPersonal: Personal = Personal(studioID: 0)
    var body: some View {
        QGrid(personal, columns: 2) {person in
            NavigationLink(destination: PersonalDetailView(personal: person, personalStorage: personalStorage)) {
                    GridCell(personal: person)
            }
        }
        .lazyPop()
        .onAppear(
            perform: {
                personal = personalStorage.allPersonal.filter {
                    personal in return personal.studioId == studioId
                }
            }
        )
        .toolbar{
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                NavigationLink(destination: PersonalDetailView(personal: Personal(random: false, studioID: studioId), personalStorage: personalStorage)) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct GridCell: View {
    var personal: Personal
    var body: some View {
        VStack {
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .shadow(color: .primary, radius: 3)
                .padding([.horizontal, .top], 7)
            Text(personal.name).lineLimit(1)
        }
    }
}

struct PersonalView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalView(personalStorage: PersonalStorage(), studioId: 1)
    }
}
