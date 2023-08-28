//
//  ContentView.swift
//  gps-tracker
//
//  Created by muhammad Yawar on 8/27/23.
//

import SwiftUI

struct MainLocationView: View {
    
    @ObservedObject var viewModel = MainLocationViewModel()
    
    var body: some View {
        VStack {
            
            Text("Lat: \(viewModel.currentLocation.lat)")
            Text("Lon: \(viewModel.currentLocation.lon)")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainLocationView()
    }
}
