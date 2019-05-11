//
//  ViewController.swift
//  FancyCountryInfo
//
//  Created by macbook on 11/05/2019.
//  Copyright © 2019 jimmy. All rights reserved.
//

import UIKit

class ViewController<V: View>: UIViewController {
    
    
    override func loadView() {
        
        view = V()
        
    }
    
    
    var customView: V {
        
        return view as! V
        
    }
    
    
}
