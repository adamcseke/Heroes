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
    
    var selectedHero: Avenger
    let mapView = MKMapView()
    var heroLocationMarker = MKPointAnnotation()
    let heroImageView = UIImageView()
    
    
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
    
    func setup() {
        setupNavigationController()
        setupMapView()
        showHeroPlace()
    }
    
    func setupNavigationController() {
        
        navigationItem.title = selectedHero.name
    }
    
    func setupMapView() {
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
    
    func showHeroPlace() {
        let latitude: CLLocationDegrees = Double(selectedHero.latitude)
        let longitude: CLLocationDegrees = Double(selectedHero.longitude)
        let regionDistance:CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
    
       
        heroLocationMarker.title = selectedHero.name
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
        heroImageView.sd_setImage(with: URL(string: selectedHero.imageURL))
        
        annotationView?.image = heroImageView.image
        annotationView?.layer.borderColor = UIColor(red: 200/255, green: 38/255, blue: 38/255, alpha: 0.5).cgColor
        annotationView?.layer.borderWidth = 1
        annotationView?.layer.cornerRadius = 18
        annotationView?.layer.masksToBounds = true
        annotationView?.frame = CGRect(x: 0, y: 0, width: 36, height: 36)

        annotationView?.canShowCallout = false
        return annotationView
    }
}
