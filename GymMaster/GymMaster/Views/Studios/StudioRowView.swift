//
//  StudioRowView.swift
//  GymMaster
//
//  Created by Kevin Pauer on 11.06.22.
//

import SwiftUI

struct StudioRowView: View {
    let studio: Studio
    var body: some View {
        HStack {
            Text("\(studio.name)")
        }
    }
}

struct StudioRowView_Previews: PreviewProvider {
    static var previews: some View {
        StudioRowView(studio: Studio())
    }
}
