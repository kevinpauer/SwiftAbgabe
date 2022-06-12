//
//  KarteView.swift
//  GymMaster
//
//  Created by Kevin Pauer on 11.06.22.
//  source: https://www.appcoda.com/swiftui-map/
//

import SwiftUI
import MapKit
import CoreLocation

struct AnnotatedItem: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct MapButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(Color.gray)
            .opacity(0.4)
            .cornerRadius(10)
    }
}

struct KarteView: View {

    @State var studioStorage = StudioStorage()
    var annotatedItems: [AnnotatedItem] = []
    @State var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.783333, longitude: 9.183333), span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20))
    @State var currentZoom: Double = 10

    mutating func fillAnnotatedItems(studioStorage: StudioStorage) {
        for item in studioStorage.allStudios {
            annotatedItems.append(AnnotatedItem(name: item.name, coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)))
        }
    }
    
    init() {
        fillAnnotatedItems(studioStorage: studioStorage)
    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true,
                annotationItems: annotatedItems) { item in
                MapMarker(coordinate: item.coordinate)}
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            if (currentZoom >= 10) {
                                withAnimation {
                                    region.span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
                                }
                                currentZoom = 5
                            } else if (currentZoom < 10) {
                                withAnimation {
                                    region.span = MKCoordinateSpan(latitudeDelta: currentZoom - 0.5, longitudeDelta: currentZoom - 0.5)
                                }
                                currentZoom = currentZoom - 0.5
                            } else if (currentZoom < 1) {
                                withAnimation {
                                    region.span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                                }
                                currentZoom = 0.2
                            }
                            
                        }, label: {
                            HStack {
                                Image(systemName: "plus.magnifyingglass")
                            }
                        }).buttonStyle(MapButtonStyle())
                        
                        Button(action: {
                            if (currentZoom < 20) {
                                withAnimation {
                                    region.span = MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
                                    currentZoom = 20
                                }
                            } else {
                                withAnimation {
                                    region.span = MKCoordinateSpan(latitudeDelta: currentZoom + 10, longitudeDelta: currentZoom + 10)
                                }
                                currentZoom = currentZoom + 10
                            }
                            
                        }, label: {
                            HStack {
                                Image(systemName: "minus.magnifyingglass")
                            }
                        }).buttonStyle(MapButtonStyle())
                    }
                }
                Spacer()
            }
        }
    }
}


struct KarteView_Previews: PreviewProvider {
    static var previews: some View {
        KarteView()
    }
}



