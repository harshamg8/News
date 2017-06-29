//
//  NewsSourceService.swift
//  News
//
//  Created by Harsha M G on 14/06/17.
//  Copyright © 2017 Harsha M G. All rights reserved.
//

import UIKit

class NewsSourceService: NSObject {

    var newsSources = [NewsSource]()
    
    func getNewsSources(urlString:String , completion: @escaping ([NewsSource]) -> ()){
        
        guard let url = URL(string: urlString) else{
            
            print("Error in converting string to URL")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error!)
            }
            
            do{
                if let d = data , let jsonDict = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? [String:Any] {
                  
                    let sources = jsonDict["sources"] as? [[String:Any]]
                    if let s = sources{
                        for source in s{
                            
                            if let sourceDict = source as? [String:Any] {
                                let ns = NewsSource(id: sourceDict["id"] as! String, name: sourceDict["name"] as! String, discription: sourceDict["description"] as! String, url: sourceDict["url"] as! String, category: sourceDict["category"] as! String, language: sourceDict["language"] as! String, country: sourceDict["country"] as! String, sortByAvailable: sourceDict["sortBysAvailable"] as! Array<Any>)
                            self.newsSources.append(ns)
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completion(self.newsSources)
                    }
                }
            } catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
        
        
    }
    
    
    
    
}
