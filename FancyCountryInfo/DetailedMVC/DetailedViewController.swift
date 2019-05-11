//
//  DetailedViewController.swift
//  FancyCountryInfo
//
//  Created by jimmy on 01/05/2019.
//  Copyright © 2019 jimmy. All rights reserved.
//

import UIKit
import SVGKit
import MapKit

class DetailedViewController: ViewController<DetailedView>, UIGestureRecognizerDelegate, UINavigationControllerDelegate{
    
    // Variables:
    
    public var countryName = String()

    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        
        startingAnimation()
        MainViewController.model.getCountryInfo(country: setProperCounryName(), completion: { (infoArray) in
            
            DispatchQueue.main.async {
                
                self.view.backgroundColor = UIColor.white
                
                self.getFlag(infoArray)
                self.setupRightLabel(infoArray)
                self.navBarSetUp()
                self.mapSetup(infoArray)

            }
            
        })
        
    }
    
    
    
    // FUNC: setup info for rightside label
    
    func setupRightLabel(_ info: [String]){
        
        for index in 0 ..< self.customView.rightLabel.count {
            
            self.customView.rightLabel[index].text = info[index]
            if self.customView.rightLabel[index].text?.isEmpty == true {self.customView.rightLabel[index].text = "No data"}
            
        }
        
    }
    
    
    
    // FUNC: get image from url
    
    func getFlag(_ info: [String]){
        
        let url = URL(string: info[10])
        if String(url?.absoluteString ?? " ") != "https://restcountries.eu/data/shn.svg"{
            let data = try? Data(contentsOf: url!)
            let image: SVGKImage = SVGKImage(data: data!)
            let imageUi: UIImage = image.uiImage
            self.customView.imageView.image = imageUi
            
        }
        
    }
    
    
    
    // FUNC: animated start of a controller
    
    func startingAnimation() {
        
        UIView.animate(withDuration: 1, delay: 1.0, options: [.curveEaseOut], animations: {
            
            self.customView.alpha = 1
            
        })
        
    }
    
    
    
    // FUNC: center map on argument location
   
    func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance) {
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        self.customView.mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    
    
    // FUNC: change country name to fit in a link
    
    func setProperCounryName() -> String{
    
        let properCountry = countryName.replacingMultipleOccurrences(using: (of: "é", with: "e") , (of: "Å", with: "A") , (of: "ô", with: "o") , (of: "ç", with: "c") , (of: " ", with: "%20"))
        
        return properCountry
        
    }
    
    
    
    // FUNC: setup navigation bar settings
    
    func navBarSetUp(){
        
        self.navigationItem.title = countryName
        
        let backButton = UIBarButtonItem()
        
        backButton.title = " "
        
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
        
    }

    
    // FUNC: setup mapView with info from infoArray
    
    private func mapSetup(_ infoArray: [String]){
        
        // get info about coordinates from infoArray
        
        let lat = Double(infoArray[11]) ?? 12.3
        let long = Double(infoArray[12]) ?? 11.1
        let location = CLLocationCoordinate2D(latitude: lat,
                                              longitude: long)
        
        
        // set scale of a map
        
        let span = MKCoordinateSpan(latitudeDelta: 2.5, longitudeDelta: 2.5)
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.customView.mapView.setRegion(region, animated: true)
        
        
        // add pin to map, and map to view
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        annotation.title = countryName
        
        self.customView.mapView.addAnnotation(annotation)
        
        
    }
}




// EX: add new function to String

public extension String {
    
    
    // FUNC: replacing multiple occurrences based on function "replacingOccurrences"
    
    func replacingMultipleOccurrences<A: StringProtocol, B: StringProtocol>(using array: (of: A, with: B)...) -> String {
        
        var str = self
        
        for (a, b) in array {
            
            str = str.replacingOccurrences(of: a, with: b)
            
        }
        
        return str
        
    }
    
}

