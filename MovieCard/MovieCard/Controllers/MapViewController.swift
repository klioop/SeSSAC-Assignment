//
//  MapViewController.swift
//  MovieCard
//
//  Created by klioop on 2021/10/21.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI
import Kingfisher

class MapViewController: UIViewController {
    
    enum Filter: String, CaseIterable {
        case lotte = "롯데시네마"
        case mega = "메가박스"
        case cgv = "CGV"
        case all
    }
    
    static let sbID = "MapViewController"
    
    private let locationManager = CLLocationManager()
    
    private lazy var theaters = TheaterLocation.testData
    
    private var filteredTheaters: [TheaterLocation] = []

    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Filter",
            style: .plain,
            target: self,
            action: #selector(triggerFilter)
        )
        showAnnotations()
    }
    
    @objc
    private func triggerFilter() {
        let alert = UIAlertController(title: "분류", message: nil, preferredStyle: .actionSheet)
        let lotteAction = UIAlertAction(title: Filter.lotte.rawValue, style: .default, handler: { _ in
//            self.filteredTheaters = self.filteredTheater(type: Filter.lotte.rawValue)
            print("Lotte")
        })
        alert.addAction(lotteAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private functions
    
    private func applyFilter(with filter: Filter, from theaters: [TheaterLocation]) -> [TheaterLocation] {
        switch filter {
        case .all:
            return theaters
        default:
            return theaters.filter { $0.type == filter.rawValue }
        }
    }
    
    private func filteredTheater(type: String) -> [TheaterLocation] {
        let filter = Filter(rawValue: type) ?? .all
        return applyFilter(with: filter, from: self.theaters)
    }
    
    private func setAnnotation(for theater: TheaterLocation) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(
            latitude: theater.latitude,
            longitude: theater.longitude
        )
        annotation.title = theater.location
        
        return annotation
    }
    
    private func showAnnotations(with filter: Filter = .all) {
        let annotations = theaters.map { setAnnotation(for: $0) }
        mapView.addAnnotations(annotations)
    }
    
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func checkiOSLoacionServiceAuthorization() {
        let authorizationStauts: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStauts = locationManager.authorizationStatus
        } else {
            authorizationStauts = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(with: authorizationStauts)
        }
        
    }
    
    func checkCurrentLocationAuthorization(with authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            print("설정으로 이동")
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            let center = CLLocationCoordinate2D(
                latitude: coordinate.latitude,
                longitude: coordinate.longitude
            )
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: center, span: span)
            mapView.setRegion(region, animated: true)
            
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkiOSLoacionServiceAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkiOSLoacionServiceAuthorization()
    }
    
    
}

extension MapViewController: MKMapViewDelegate {
    
    
}


