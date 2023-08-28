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
    @Published var currentLocation: Location = .init(lat: 1, lon: 1)
    private var cancellables = Set<AnyCancellable>()
        
        init() {
            
            bindLocation()
        }
}

private extension MainLocationViewModel {
    
    private func bindLocation() {
        
        locationTracker.locationPublisher
            .receive(on: DispatchQueue.main)
            .sink { result in
                
                switch result {
                    
                case .success(let location):
                    
                    self.currentLocation = location
                case .failure(let error):
                    
                    print(error)
                }
            }
            .store(in: &cancellables)
    }
}
