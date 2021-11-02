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
    
    private var currentFilter = Filter.all {
        didSet {
            self.filteredTheaters = getFilteredTheaters(type: currentFilter.rawValue)
        }
    }
    
    private var filteredTheaters: [TheaterLocation] = [] {
        didSet {
            showAnnotations(with: currentFilter)
        }
    }

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
        configureNavigationItem()
        initialRegion()
        showAnnotations()
    }
    
    // MARK: - obcj methods
    
    @objc
    private func triggerFilter() {
        let alert = UIAlertController(title: "분류", message: nil, preferredStyle: .actionSheet)
        let lotteAction = UIAlertAction(title: Filter.lotte.rawValue, style: .default) { [weak self] _ in
            self?.currentFilter = .lotte
        }
        let megaAction = UIAlertAction(title: Filter.mega.rawValue, style: .default) { [weak self] _ in
            self?.currentFilter = .mega
        }
        let cgvAction = UIAlertAction(title: Filter.cgv.rawValue, style: .default) { [weak self]  _ in
            self?.currentFilter = .cgv
        }
        let allAction = UIAlertAction(title: "전체 보기", style: .default) { [weak self] _ in
            self?.currentFilter = .all
        }
        
        alert.addActions(lotteAction, megaAction, cgvAction, allAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private functions
    
    private func configureNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Filter",
            style: .plain,
            target: self,
            action: #selector(triggerFilter)
        )
    }
    
    private func initialRegion() {
        let center = CLLocationCoordinate2D(latitude: theaters[0].latitude, longitude: theaters[0].longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1 )
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    private func applyFilter(with filter: Filter, from theaters: [TheaterLocation]) -> [TheaterLocation] {
        switch filter {
        case .all:
            return theaters
        default:
            return theaters.filter { $0.type == filter.rawValue }
        }
    }
    
    private func getFilteredTheaters(type: String) -> [TheaterLocation] {
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
        let prevAnnotations = mapView.annotations
        mapView.removeAnnotations(prevAnnotations)
        
        let annotations: [MKPointAnnotation]
        
        switch filter {
        case .all:
            annotations = self.theaters.map{ setAnnotation(for: $0) }
        default:
            annotations = self.filteredTheaters.map{ setAnnotation(for: $0) }
        }
        mapView.addAnnotations(annotations)
    }
}

// MARK: - CLLocatonManagerDelegate

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
            showAlert(
                title: "위치 정보 접근 권한 거절",
                message: "위치 정보 접근 권한을 설정에서 켜주세요",
                okTitle: "설정으로 이동") {
                    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }
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


