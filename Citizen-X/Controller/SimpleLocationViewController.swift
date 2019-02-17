//
//  SimpleLocationViewController.swift
//  Citizen-X
//
//  Created by Cal Stephens on 2/17/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SimpleLocationViewController: UIViewController {
    
    let location: Location
    
    init(for location: Location) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Unimplemented")
    }
    
    override func loadView() {
        let mapView = MKMapView(frame: .zero)
        self.view = mapView
        self.view.cornerRadius = 12
        self.view.layer.masksToBounds = true
        self.view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.view.isUserInteractionEnabled = false
        
        mapView.region = MKCoordinateRegion(
            center: location.coordinate.coordinate,
            latitudinalMeters: 15_000,
            longitudinalMeters: 15_000)
    }
    
}
