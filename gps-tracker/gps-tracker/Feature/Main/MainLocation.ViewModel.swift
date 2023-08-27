//
//  MainLocation.ViewModel.swift
//  gps-tracker
//
//  Created by muhammad Yawar on 8/28/23.
//

import Foundation
import Combine

class MainLocationViewModel: ObservableObject {
    
    private var locationTracker = LocationTrackerImpl()
    @Published var currentLocation: (Double, Double) = (1,1)
    private var cancellables = Set<AnyCancellable>()
        
        init() {
            
            bindLocation()
        }
}

private extension MainLocationViewModel {
    
    private func bindLocation() {
        
        locationTracker.locationPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                
            }, receiveValue: { [weak self] (lat, lon) in
                
                self?.currentLocation.0 = lat
                self?.currentLocation.1 = lon
            })
            .store(in: &cancellables)
    }
}
