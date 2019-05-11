//
//  ViewController.swift
//  FancyCountryInfo
//
//  Created by jimmy on 01/05/2019.
//  Copyright © 2019 jimmy. All rights reserved.
//

import UIKit

class MainViewController: ViewController<MainView>, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    // Variables:
    
    static var model = Model()
    var filteredTableData = [String]()
    var resultSearchController = UISearchController() { didSet {
        resultSearchController.searchResultsUpdater = self
        }}
    var myArray = [String]()
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        startingAnimation(whichAlpha: 1)

    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Setup our searchController delegate and position
        self.resultSearchController = ({
            
            let controller = UISearchController(searchResultsController: nil)
            
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            navigationItem.searchController = controller
            
            return controller
            
        })()
        
        // settting up the tableView delegate and dataSource
        self.customView.myTableView.dataSource = self
        self.customView.myTableView.delegate = self
        
        // Get countries array from API and reload data after it finishes
        MainViewController.model.getCountry(completion: { (countriesArray) in
            
            self.myArray = countriesArray as! [String]
            
            // Reload data must be in main queue
            DispatchQueue.main.async {
                
                self.customView.myTableView.reloadData()
                
            }
            
        })
        
    }
    
    
    
    
    // FUNC: set country name in new opened detailed VC
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var choosenCell = String()
        
        if (resultSearchController.isActive) {
            
            resultSearchController.dismiss(animated: false) { }
            
            choosenCell = filteredTableData[indexPath.row]
            
        }else{
            
            choosenCell = myArray[indexPath.row]
       
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        let detailedVC = DetailedViewController()
        
        detailedVC.countryName = choosenCell
        
        startingAnimation(whichAlpha: 0)
        
        self.navigationController?.pushViewController(detailedVC, animated: true)
        
    }
    
    
    
    // FUNC: return the number of rows
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if  (resultSearchController.isActive) {
            
            return filteredTableData.count
            
        } else {
            
            return myArray.count
            
        }
        
    }
    
    
    
    // FUNC: assign selected cell to data from countries array
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        cell.textLabel!.text = "\(myArray[indexPath.row])"
        cell.backgroundColor = UIColor.clear
        
        if (resultSearchController.isActive) {
            
            cell.textLabel?.text = filteredTableData[indexPath.row]
            return cell
            
        } else {
            
            cell.textLabel?.text = myArray[indexPath.row]
            return cell
            
        }
        
    }
    
    
    
    // FUNC: reload data after typing in search bar
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filteredTableData.removeAll(keepingCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (myArray as NSArray).filtered(using: searchPredicate)
        
        filteredTableData = array as! [String]
        
        self.customView.myTableView.reloadData()
        
    }
    
    
    
    // FUNC: animate transfer between controllers
    
    func startingAnimation(whichAlpha: CGFloat) {
        UIView.animate(withDuration: 1, delay: 0.0, options: [.curveEaseOut], animations: {
            if whichAlpha == 0 {
                self.customView.transform = CGAffineTransform(translationX: -self.customView.center.x*2, y: 0)
            }
            self.customView.alpha = whichAlpha
        })
    }
    
    
    
}



