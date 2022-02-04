//
//  MapViewController.swift
//  Heroes
//
//  Created by Adam Cseke on 2022. 02. 02..
//

import UIKit
import MapKit
import SDWebImage

class MapViewController: UIViewController {
    
    private var selectedHero: Avenger?
    private var mapView: MKMapView!
    private var heroLocationMarker: MKPointAnnotation!
    private var imageContentView: MarkerView!
    
    init(selectedHero: Avenger) {
        self.selectedHero = selectedHero
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupNavigationController()
        setupMapView()
        showHeroPlace()
    }
    
    private func setupNavigationController() {
        navigationItem.title = selectedHero?.name
        navigationItem.titleView?.tintColor = .label
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupMapView() {
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mapView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])
    }
    
    private func showHeroPlace() {
        let latitude: CLLocationDegrees = Double(selectedHero?.latitude ?? 0.0)
        let longitude: CLLocationDegrees = Double(selectedHero?.longitude ?? 0.0)
        let regionDistance:CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
    
        heroLocationMarker = MKPointAnnotation()

        heroLocationMarker.title = selectedHero?.name
        heroLocationMarker.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.addAnnotation(heroLocationMarker)
        mapView.setRegion(regionSpan, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "heroAnnotationView")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "heroAnnotationView")
        }
        imageContentView = MarkerView(width: 36, radius: 18)
        imageContentView.setImageURL(imageURL: selectedHero?.imageURL ?? "")
        imageContentView.translatesAutoresizingMaskIntoConstraints = false
        annotationView?.addSubview(imageContentView)

        annotationView?.canShowCallout = false
        return annotationView
    }
}
