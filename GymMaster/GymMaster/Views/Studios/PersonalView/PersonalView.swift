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
	@State var selectedPersonal: Personal = Personal()
  var body: some View {
	  Button("Add new User") {
			(indexOfPerson,_) = personalStorage.newPersonal(studioId: studioId)
	  }
	  Text("Details View tbd \(String(personal.count))")
		NavigationLink(destination: PersonalDetailView(personal: selectedPersonal)) {
												Text("Do Something")
										}
		QGrid(personal, columns: 2) {
			GridCell(personal: $0)
		}
			.onAppear(
				perform: {
					personal = personalStorage.allPersonal.filter {
					personal in return personal.studioId == studioId
				}
				print(personal)}
			)
  }
}

struct GridCell: View {
    var personal: Personal
    var body: some View {
		VStack() {
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
