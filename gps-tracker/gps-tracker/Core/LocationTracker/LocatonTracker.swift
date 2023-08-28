//
//  LocatonTracker.swift
//  gps-tracker
//
//  Created by muhammad Yawar on 8/27/23.
//

import Foundation
import CoreLocation
import Combine
import UIKit

public struct Location {
    
    public let lat: Double
    public let lon: Double
}

protocol LocationTracker {
    
    var locationPublisher: AnyPublisher<Result<Location, Error>, Never> { get }
}

public final class LocationTrackerImpl: NSObject, LocationTracker {
    
    private let locationManager = CLLocationManager()
    private lazy var locationSubject = PassthroughSubject<Result<Location, Error>, Never>()
    private(set) public lazy var locationPublisher = locationSubject.eraseToAnyPublisher()
    
    public override init() {
        
        super.init()
        setupLocationManager()
    }
}

//MARK: CLLocationManagerDelegate

extension LocationTrackerImpl: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            
            let tempLocation = Location(lat: location.coordinate.latitude,
                                        lon: location.coordinate.longitude)
            locationSubject.send(.success(tempLocation))
        }
    }
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    
        locationSubject.send(.failure(error))
    }
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if manager.authorizationStatus == CLAuthorizationStatus.authorizedAlways ||
            manager.authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
        }
    }
}

//MARK: Private

extension LocationTrackerImpl {
    
    private func setupLocationManager() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
    }
}
