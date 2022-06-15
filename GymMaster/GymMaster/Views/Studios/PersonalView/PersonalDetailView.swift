//
//  PersonalDetailView.swift
//  GymMaster
//
//  Created by Kevin Pauer on 14.06.22.
//

import SwiftUI

struct PersonalDetailView: View {
    @State var personal: Personal
    var body: some View {
        Text("Details View tbd \(personal.id)")
    }
}

struct PersonalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDetailView(personal: Personal(random: true, studioID: 0))
    }
}
