//
//  CreditsViewController.swift
//  ProgrammerQuiz
//
//  Created by Matteo Minardi on 27/06/17.
//  Copyright © 2017 Matteo Minardi. All rights reserved.
//

import UIKit
import MapKit

//Class that implements a 2d location
class Location {
    var location : CLLocationCoordinate2D
    var subtitle : String
    var title : String
    var description : String
    
    init(longitude: Double, latitude: Double, title: String, subtitle: String, description : String ) {
        self.location = CLLocationCoordinate2DMake(latitude, longitude)
        self.title = title
        self.subtitle = subtitle
        self.description = description
    }
}

class CreditsViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var placeSelector: UISegmentedControl!
    @IBOutlet var descriptionLabel: UILabel!
    
    //Setup of the 2 displayed locations
    var uniLocation = Location(longitude: 12.243219, latitude: 44.139761, title: "Via Sacchi 3, Cesena", subtitle: "Ingegneria e Scienze Informatiche", description: "App develpoed in Via Sacchi 3, Cesena. Ingegneria e scienze informatiche.")
    var homeLocation = Location(longitude: 12.198461, latitude: 44.360398, title: "Vicolo del Merlo 105, Ravenna", subtitle: "Home", description: "Lives in Vicolo del Merlo 105, Ravenna.")
    
    let zoomLevel : Double = 3000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImage()
        placeSelector.selectedSegmentIndex = -1;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMap()
    }
    
    func setupImage() {
        profileImage.layer.cornerRadius = profileImage.bounds.height/2
        profileImage.clipsToBounds = true
    }
    //Selector event handler
    @IBAction func controlValueChanged(_ sender: Any) {
        if (placeSelector.selectedSegmentIndex == 0){
            updatePosition(location: uniLocation, zoomLevel: zoomLevel)
            descriptionLabel.text = uniLocation.description
        } else if (placeSelector.selectedSegmentIndex == 1){
            updatePosition(location: homeLocation, zoomLevel: zoomLevel)
            descriptionLabel.text = homeLocation.description
        }
    }
    
    func setupMap() {
        //Creating the home annotation
        let homeAnnotation = MKPointAnnotation()
        homeAnnotation.coordinate = homeLocation.location
        homeAnnotation.title = homeLocation.title
        homeAnnotation.subtitle = homeLocation.subtitle
        mapView.addAnnotation(homeAnnotation)
        //Creating the uni annotation
        let uniAnnotation = MKPointAnnotation()
        uniAnnotation.coordinate = uniLocation.location
        uniAnnotation.title = uniLocation.title
        uniAnnotation.subtitle = uniLocation.subtitle
        mapView.addAnnotation(uniAnnotation)
        //Inital setup of the location
        if (placeSelector.selectedSegmentIndex == 0){
            updatePosition(location: uniLocation, zoomLevel: zoomLevel)
            descriptionLabel.text = uniLocation.description
        } else if (placeSelector.selectedSegmentIndex == 1) {
            updatePosition(location: homeLocation, zoomLevel: zoomLevel)
            descriptionLabel.text = homeLocation.description
        }
        
        self.mapView.isZoomEnabled = false;
        self.mapView.isScrollEnabled = false;
        
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    func updatePosition(location : Location, zoomLevel : Double) {
        let region = MKCoordinateRegionMakeWithDistance(location.location, zoomLevel, zoomLevel)
        mapView.setRegion(region, animated: true)
        mapView.selectAnnotation(mapView.annotations[placeSelector.selectedSegmentIndex], animated: true)
    }
    
}
