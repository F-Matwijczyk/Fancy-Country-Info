//
//  DetailedView.swift
//  FancyCountryInfo
//
//  Created by macbook on 11/05/2019.
//  Copyright © 2019 jimmy. All rights reserved.
//

import UIKit
import MapKit

class DetailedView: View {
    
    
    // Variables:
    
    private var leftLabel:[UILabel] = []
    public var rightLabel:[UILabel] = []
    public var mapView = MKMapView()
    public var imageView = UIImageView()

    // Constans:
    
    let centerView = UIView()
    let scrollView = UIScrollView()
    
    
    
    // OR FUNC: add subveiws
    
    override func setViews() {
        
        self.alpha = 0
        
        addSubview(scrollView)
        
        scrollView.addSubview(centerView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(mapView)

    }
    
    
    
    // OR FUNC: setup layout for scroll, center, image and labels
    
    override func layoutViews() {
        
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        centerView.translatesAutoresizingMaskIntoConstraints = false
        centerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        centerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        centerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9).isActive = true
        centerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.9).isActive = true
        
        setupLabelsProperties()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: centerView.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerView.centerXAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
        
        
        for index in 0...leftLabel.count-1{
            
            scrollView.addSubview(leftLabel[index])
            scrollView.addSubview(rightLabel[index])
            
            leftLabel[index].translatesAutoresizingMaskIntoConstraints = false
            rightLabel[index].translatesAutoresizingMaskIntoConstraints = false
            
            index == 0 ? (leftLabel[index].topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true) : (leftLabel[index].topAnchor.constraint(equalTo: rightLabel[index-1].bottomAnchor).isActive = true)
            
            rightLabel[index].topAnchor.constraint(equalTo: leftLabel[index].topAnchor).isActive = true
            
            
            leftLabel[index].rightAnchor.constraint(equalTo: centerView.centerXAnchor, constant: -5).isActive = true
            leftLabel[index].leftAnchor.constraint(equalTo: centerView.leftAnchor).isActive = true
            rightLabel[index].leftAnchor.constraint(equalTo: centerView.centerXAnchor, constant: 5).isActive = true
            rightLabel[index].rightAnchor.constraint(equalTo: centerView.rightAnchor).isActive = true
            
        }
        
        mapSetup()
        
    }
    
    
    
    // FUNC: setup left labels
    
    private func setupLabelsProperties(){
        
        let leftText = ["Region:","Subregion:","Population:","Capital:","Area:","Domain:","Currency:","Currency Code:","Calling Code:","Language:"]
        
        for index in 0...leftText.count-1{
            
            let leftlabel = UILabel()
            
            leftlabel.text = leftText[index]
            leftLabel.append(leftlabel)
            leftlabel.textAlignment = .right
            leftlabel.textColor = .black
            
            
            let rightlabel = UILabel()
            rightlabel.text = " "
            rightlabel.textColor = .darkGray
            rightlabel.textAlignment = .left
            rightlabel.lineBreakMode = .byWordWrapping
            rightlabel.numberOfLines = 2
            rightLabel.append(rightlabel)
            
        }
        
    }
    
    
    
    // FUNC: setup map view
    
    private func mapSetup() {
        
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: rightLabel.last!.bottomAnchor, constant: 20).isActive = true
        mapView.heightAnchor.constraint(equalTo: mapView.widthAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
    }
    
}
