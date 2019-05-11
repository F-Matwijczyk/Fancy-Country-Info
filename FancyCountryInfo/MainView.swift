//
//  MainView.swift
//  FancyCountryInfo
//
//  Created by macbook on 11/05/2019.
//  Copyright © 2019 jimmy. All rights reserved.
//

import UIKit

class MainView: View {
    
    
    // Variables:

    public var myTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.gray
        tableView.separatorColor = UIColor.yellow
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        return tableView
    }()
    
    
    
    // OR FUNC: add subView
    
    override func setViews() {
        
        addSubview(myTableView)
        
    }
    
    
    
    // OR FUNC: set up tableView
    
    override func layoutViews() {

        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        myTableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        myTableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    
    }
    
}
