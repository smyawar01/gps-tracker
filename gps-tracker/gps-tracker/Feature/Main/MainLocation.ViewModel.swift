//
//  MainLocation.ViewModel.swift
//  gps-tracker
//
//  Created by muhammad Yawar on 8/28/23.
//

import Foundation
import Combine
import UIKit

enum LocationViewState {
    
    case `default`
    case updateLocation(Location)
    case permissionError
}

public final class MainLocationViewModel: ObservableObject {
    
    private var locationTracker = LocationTrackerImpl()
    @Published private (set) var viewState: LocationViewState = .default
    private var cancellables = Set<AnyCancellable>()
    private var lastKnownLocation: Location = .init(lat: 24.867618674995303,
                                                    lon: 67.08086348465902)
    
    public init() { bindLocation() }
    
    public func askPermission() {
        
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
    
    deinit { cancellables.removeAll() }
}

//MARK: Private
private extension MainLocationViewModel {
    
    private func bindLocation() {
        
        locationTracker.locationPublisher
            .sink { [weak self] result in
                
                guard let self else { return }
                
                switch result {
                    
                case .success(let location):
                    
                    self.lastKnownLocation = location
                    Task { await self.updateState(state: .updateLocation(location)) }
                    
                case .failure(let error):
                    
                    debugPrint(error)
                    Task { await self.updateState(state: .permissionError) }
                }
            }
            .store(in: &cancellables)
    }
    @MainActor
    private func updateState(state: LocationViewState) {
        
        self.viewState = state
    }
}
