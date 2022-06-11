//
//  ContentView.swift
//  GymMaster
//
//  Created by Kevin Pauer on 11.06.22.
//

import SwiftUI

struct StudiosView: View {
    @StateObject var studioStorage: StudioStorage
    @State private var indexNewStudio: Int?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(studioStorage.allStudios.enumerated()), id: \.0) {i, studio in
                    
                    NavigationLink(destination: StudioDetailView(), tag: i, selection: $indexNewStudio) {
                        StudioDetailView()
                    }
                }
                .onDelete(perform: { indexSet in
                    studioStorage.removeStudio(indexSet: indexSet)
                })
                .onMove(perform: { indices, newOffset in
                    studioStorage.moveStudio(from: indices, to: newOffset)
                })
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) {_ in
                    let success = studioStorage.saveChanges()
                    if (success) {
                        print("Saved all studios.")
                    } else {
                        print("Could not save any of the studios.")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Studios")
            .toolbar{
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Button(action: {
                            (indexNewStudio,_) = studioStorage.newStudio()
                        
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct StudiosView_Previews: PreviewProvider {
    static var previews: some View {
        StudiosView(studioStorage: StudioStorage())
    }
}
