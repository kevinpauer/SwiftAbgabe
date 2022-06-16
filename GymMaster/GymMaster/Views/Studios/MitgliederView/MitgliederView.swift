//
//  MitgliederView.swift
//  GymMaster
//
//  Created by Calvin Friedrich on 13.06.22.
//

import SwiftUI
import QGrid

struct MitgliederView: View {
    @StateObject var mitgliederStorage: MitgliederStorage
    @State var studioId: Int
    @State var mitglieder: [Mitglied] = []
    @State var indexOfMitglied: Int = 0
    var body: some View {
        QGrid(mitglieder, columns: 2) {mitglied in
            NavigationLink(destination: MitgliederDetailView(mitglied: mitglied, mitgliederStorage: mitgliederStorage)) {
                    MitgliederGridCell(mitglied: mitglied)
            }
        }
        .lazyPop()
        .onAppear(
            perform: {
                mitglieder = mitgliederStorage.allMitglieder.filter {
                    mitglied in return mitglied.studioId == studioId
                }
            }
        )
        .toolbar{
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                NavigationLink(destination: MitgliederDetailView(mitglied: Mitglied(studioID: studioId), mitgliederStorage: mitgliederStorage)) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct MitgliederGridCell: View {
    var mitglied: Mitglied
    var body: some View {
        VStack {
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .shadow(color: .primary, radius: 3)
                .padding([.horizontal, .top], 7)
            Text(mitglied.name).lineLimit(1)
        }
    }
}

struct MitgliederView_Previews: PreviewProvider {
    static var previews: some View {
        MitgliederView(mitgliederStorage: MitgliederStorage(), studioId: 1)
    }
}
