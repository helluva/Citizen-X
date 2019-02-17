//
//  SetLocationViewController.swift
//  AR Planes
//
//  Created by Cal Stephens on 10/5/17.
//  Copyright © 2017 Hack the North. All rights reserved.
//

import UIKit
import MapKit


struct Location {
    
    let city: String
    let coordinate: CLLocation
    
    static let sanFrancisco = Location(
        city: "San Francisco, CA",
        coordinate: CLLocation(
            latitude: CLLocationDegrees(37.771820),
            longitude: CLLocationDegrees(-122.405080)))
}


// MARK: - SetLocationViewController

class SetLocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    private let feedbackGenerator = UISelectionFeedbackGenerator()
    var resetOverlay: OverlayView!
    var cityOverlay: OverlayView!
    
    var location: CLLocation!
    var address: String!
    
    var userLocation: CLLocation?
    var viewpointLocationIsUserLocation: Bool {
        guard let userLocation = self.userLocation else {
            return true
        }
        
        //within half a kilometer is good enough
        return location.distance(from: userLocation) < 500
    }
    
    var userLocationAnnotation: UserLocationAnnotation? {
        return mapView.annotations.first(where: { $0 is UserLocationAnnotation }) as? UserLocationAnnotation
    }
    
    var completion: ((Location) -> Void)!
    
    
    // MARK: Presentation
    
    static func present(
        at viewpointLocation: Location,
        userLocation: Location,
        over source: UIViewController,
        completion: @escaping (Location) -> Void)
    {
        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Set Location Navigation Controller") as! UINavigationController
        navigationController.modalPresentationStyle = .formSheet
        
        let viewController = navigationController.viewControllers.first! as! SetLocationViewController
        
        viewController.location = viewpointLocation.coordinate
        viewController.address = viewpointLocation.city
        viewController.userLocation = userLocation.coordinate
        viewController.completion = completion
        
        source.present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        setUpMapView()
        addResetButton()
        addGestureRecognizers()
        configureCityOverlay()
        updateCityOverlayContent()
    }
    
    func setUpMapView() {
        let annotation = UserLocationAnnotation(at: location)
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: false)
        
        let visibleRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1_500_000, longitudinalMeters: 1_500_000)
        mapView.region = visibleRegion
    }
    
    func addResetButton() {
        let overlay = OverlayView()
        overlay.contentBackgroundColor = navigationController?.navigationBar.barTintColor ?? .black
        
        let button = UIButton(type: .system)
        button.setTitle("Use Current Location", for: .normal)
        button.setTitleColor(.applicationPrimary2, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.heightAnchor.constraint(equalToConstant: 18).isActive = true
        button.addTarget(self, action: #selector(useActualLocation), for: .touchUpInside)
        overlay.addRightAccessory(button)
        
        view.addSubview(overlay)
        overlay.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        overlay.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        resetOverlay = overlay
        
        overlay.alpha = (viewpointLocationIsUserLocation) ? 0.0 : 1.0
    }
    
    func addGestureRecognizers() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(_:)))
        view.addGestureRecognizer(longPress)
    }
    
    func configureCityOverlay() {
        cityOverlay = OverlayView(
            text: "San Francisco, CA",
            font: .systemFont(ofSize: 14, weight: .medium))
        
        view.addSubview(cityOverlay)
        
        NSLayoutConstraint.activate([
            cityOverlay.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            cityOverlay.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            cityOverlay.rightAnchor.constraint(lessThanOrEqualTo: resetOverlay.leftAnchor, constant: -10)
        ])
    }
    
    func updateCityOverlayContent(withHapticBounce playHapticBounce: Bool = false) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first,
                let city = placemark.locality,
                let state = placemark.administrativeArea,
                placemark.country == "United States" else
            {
                self.address = "Unknown"
                self.cityOverlay.label.text = "Unknown"
                return
            }
            
            self.address = "\(city), \(state)"
            self.cityOverlay.label.text = self.address ?? "Unknown"
            
            if playHapticBounce {
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
                self.cityOverlay.bounce()
            }
            
            if self.viewpointLocationIsUserLocation {
                self.resetOverlay.playDisappearAnimation()
            } else {
                self.resetOverlay.playAppearAnimation(matchingBounce: true)
            }
        }
    }
    
    private func milesToMeters(_ miles: Double) -> Double {
        return miles / 0.000621371
    }
    
    private func metersToMiles(_ meters: Double) -> Double {
        return meters * 0.000621371
    }
    
    
    // MARK: User Interaction
    
    @IBAction func cancelPressed() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveChosenLocation() {
        completion(Location(city: address, coordinate: location))
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func useActualLocation() {
        guard let userLocation = userLocation else { return }
        
        location = userLocation
        resetOverlay.playDisappearAnimation()
        
        //reset annotation
        mapView.removeAnnotations(mapView.annotations)
        
        let newAnnotation = UserLocationAnnotation(at: userLocation)
        mapView.addAnnotation(newAnnotation)
        
        let visibleRegion = MKCoordinateRegion(
            center: userLocation.coordinate,
            latitudinalMeters: 1_500_000,
            longitudinalMeters: 1_500_000)
        
        mapView.setRegion(visibleRegion, animated: true)
        self.mapView.selectAnnotation(newAnnotation, animated: false)
        self.updateCityOverlayContent(withHapticBounce: true)
    }
    
    @objc func longPressGestureRecognized(_ recognizer: UILongPressGestureRecognizer) {
        guard recognizer.state == .began,
            let existingAnnotation = self.userLocationAnnotation else
        {
            return
        }
        
        //if the tap if close to the pin, select it
        let screenLocation = recognizer.location(in: mapView)
        let pinLocation = mapView.convert(existingAnnotation.coordinate, toPointTo: mapView)
        let distanceToPin = sqrt(pow(screenLocation.x - pinLocation.x, 2) + pow(screenLocation.y - pinLocation.y, 2))
        if distanceToPin < 35 {
            //mapView.selectAnnotation(existingAnnotation, animated: false)
            recognizer.isEnabled = false
            recognizer.isEnabled = true
            return
        }
        
        //otherwise, move the pin to the touch
        let coordinate = mapView.convert(screenLocation, toCoordinateFrom: mapView)
        self.location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let newAnnotation = UserLocationAnnotation(with: coordinate)
        mapView.addAnnotation(newAnnotation)
        mapView.removeAnnotation(existingAnnotation)
        
        self.feedbackGenerator.selectionChanged()
        mapView.selectAnnotation(newAnnotation, animated: false)
        mapView.setCenter(location.coordinate, animated: true)
        updateCityOverlayContent(withHapticBounce: true)
    }
    
}

// MARK: MKMapViewDelegate

extension SetLocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is UserLocationAnnotation {
            let view = MKPinAnnotationView()
            view.isDraggable = true
            view.canShowCallout = false
            view.pinTintColor = .applicationPrimary2
            return view
        }
        
        return nil
    }
    
    func mapView(
        _ mapView: MKMapView,
        annotationView view: MKAnnotationView,
        didChange newState: MKAnnotationView.DragState,
        fromOldState oldState: MKAnnotationView.DragState)
    {
        
        if newState == .starting {
            // pass
        }
            
        else if newState == .ending || newState == .canceling,
            let newLocation = (view.annotation as? UserLocationAnnotation)?.location
        {
            location = newLocation
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.33, execute: {
                self.updateCityOverlayContent(withHapticBounce: true)
            })
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        for view in views {
            if view.annotation is UserLocationAnnotation {
                view.layer.zPosition = 10
            } else {
                view.layer.zPosition = 0
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // force the pin to always be selected so it's always on top
        if !(view.annotation is UserLocationAnnotation),
            let userLocationAnnotation = userLocationAnnotation
        {
            mapView.selectAnnotation(userLocationAnnotation, animated: false)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        // force the pin to always be selected so it's always on top
        if let userLocation = view.annotation as? UserLocationAnnotation {
            mapView.selectAnnotation(userLocation, animated: false)
        }
    }
    
}

// MARK: UIGestureRecognizerDelegate

extension SetLocationViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true
    }
    
}

// MARK: UserLocationAnnotation

class UserLocationAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    var location: CLLocation {
        return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
    init(at location: CLLocation) {
        coordinate = location.coordinate
    }
    
    init(with coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
}

