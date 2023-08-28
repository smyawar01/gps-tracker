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
        
        ZStack {
            
            VStack {
                
                if case .updateLocation(let location) = viewModel.viewState {
                    
                    Text("Lat: \(location.lat)")
                    Text("Lon: \(location.lon)")
                }
            }
            if case .permissionError = viewModel.viewState {
                
                VStack {
                    
                    PermissionErrorView { viewModel.askPermission() }
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainLocationView()
    }
}
