//
//  Model.swift
//  FancyCountryInfo
//
//  Created by macbook on 11/05/2019.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation

class Model{
    
    var countriesArray = [String]()
    
    
    
    // FUNC: get countries names from API and create array of them
    
    public func getCountry(completion: @escaping ([Any]) -> Void){
        
        guard let url = URL(string: "https://restcountries.eu/rest/v2/all?fields=name") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            
           
            do{
                
                // dataResponse received from a network request
                
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                
                // Response result
                
                guard let jsonArray = jsonResponse as? [[String: Any]] else { return }
                
                // Parse jsonArray to array of country names
                
                for dic in jsonArray{
                    
                    guard let countryName = dic["name"] as? String else { return }
                    self.countriesArray.append(countryName)
                    
                }
                
            } catch let parsingError {
                
                print("Error", parsingError)
                
            }
            
            // Add results of parsing to header
            
            completion(self.countriesArray)
            
        }
        
        task.resume()
        
        
    }
    
    
    
    // FUNC: get info about argument country from API
    
    public func getCountryInfo(country: String, completion: @escaping ([String]) -> Void){
        
        guard let url = URL(string: "https://restcountries.eu/rest/v2/name/"+country+"?fields=currencies;name;topLevelDomain;callingCodes;capital;subregion;region;population;languages;flag;area;latlng") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            
            do{
                
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                
                guard let jsonArray = jsonResponse as? [[String: Any]] else { return }
                
                for item in jsonArray
                    
                {
                    
                    let area = item["area"] as? Double ?? 1000000
                    var latitude = Double()
                    var longitude = Double()
                    
                    if (item["latlng"] as? NSArray)?.count != 0{
                        
                        let latlng = item["latlng"] as? NSArray
                        latitude = (latlng as? [Double])?[0] ?? 1.0
                        longitude = (latlng as? [Double])?[1] ?? 1.0
                        
                    }else{
                        
                        latitude = 1.0
                        longitude = 1.0
                        
                    }
                    
                    let flagLink = item["flag"] as? String ?? "https://restcountries.eu/data/dza.svg"
                    let subRegion = item["subregion"] as? String ?? "none"
                    let population = item["population"] as? Int ?? 10000
                    let populationStr = String(population)
                    let capital = item["capital"] as? String ?? "none"
                    let region = item["region"] as? String ?? "none"
                    let topLevelDomain = item["topLevelDomain"] as? NSArray ?? [".pl"]
                    let topLevelDomainStr = (topLevelDomain as? [String])?[0] ?? "error"
                    let currency = item["currencies"] as? NSArray ?? ["PLN"]
                    let callingCode = item["callingCodes"] as! NSArray
                    let callingCodeStr = (callingCode as? [String])?[0] ?? "error"
                    let language = item["languages"] as? NSArray ?? ["none"]
                    let languageStr = (language[0] as? [String : String])?["name"] ?? "error"
                    let currencyStrName = (currency[currency.count - 1] as? [String : String])?["name"] ?? "error"
                    let currencyStrCode = (currency[currency.count - 1] as? [String : String])?["code"] ?? "error"
                    
                    let infoArray = [region,subRegion,populationStr,capital,String(area),topLevelDomainStr,currencyStrName,currencyStrCode,callingCodeStr,languageStr, flagLink, String(latitude), String(longitude)]
                    
                    completion(infoArray)
                    
                }
                
            } catch let parsingError {
                
                print("Error", parsingError)
                
            }
            
        }
        
        task.resume()
        
    }
    
    
}
