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
            
            Text("Lat: \(viewModel.currentLocation.0)")
            Text("Lon: \(viewModel.currentLocation.1)")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainLocationView()
    }
}
