//
//  LocatonTracker.swift
//  gps-tracker
//
//  Created by muhammad Yawar on 8/27/23.
//

import Foundation
import CoreLocation
import Combine

protocol LocationTracker {
    
    var locationPublisher: AnyPublisher<(Double, Double), Error> { get }
}

public final class LocationTrackerImpl: NSObject, LocationTracker {
    
    private let locationManager = CLLocationManager()
    private lazy var locationSubject = PassthroughSubject<(Double, Double), Error>()
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
            
            locationSubject.send((location.coordinate.latitude, location.coordinate.longitude))
        }
    }
}

//MARK: Private

extension LocationTrackerImpl {
    
    private func setupLocationManager() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}
