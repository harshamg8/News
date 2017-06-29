//
//  NewsSourceViewModel.swift
//  News
//
//  Created by Harsha M G on 14/06/17.
//  Copyright © Harsha M G. All rights reserved.
//

import UIKit



class NewsSourceViewModel: NSObject {

    var newsSource: [NewsSource] = []
    
    var categoryArray :[String] = []
    
    var arrayOfarrys: [[NewsSource]] = []
    
    func getDataFromServiceClass(completion: @escaping (Bool) -> ()){
        
        let obj = NewsSourceService()
        
        obj.getNewsSources(urlString: "\(Constants.url)" + "/" + "sources?language=en") { (newsSources) in
            self.newsSource = newsSources
            
            var categoriesSet = Set<String>()
            for source in self.newsSource {
                
                let category = source.value(forKey: "category")
                categoriesSet.insert(category as! String)
            }
            self.categoryArray = Array(categoriesSet)
        
            for cat in self.categoryArray {
                 var arrayss: [NewsSource] = []
                for source in self.newsSource{
                    if cat == source.value(forKey: "category") as! String{
                        arrayss.append(source)
                    }
                }
              
                self.arrayOfarrys.insert(arrayss, at: self.categoryArray.index(of: cat)!)
                
            }
            
            completion(true)
        }
    }
    
    func getNumberOfItems(index: Int)-> Int{
    
      
        return arrayOfarrys[index].count
        
    }
  
    func getId(index1: Int, index2: Int) -> String {
        
        return arrayOfarrys[index1][index2].id!

    }
    
    func getNumberOfSections() -> Int {
        
        return categoryArray.count

    }
    
    func getNamesForSections(index: Int) -> String  {
        return categoryArray[index]
    }
    
    func getNewsSourceObject(index1: Int, index2: Int)-> NewsSource{
        
        return arrayOfarrys[index1][index2]
        
    }
    
    
    
    
    
    
    
}
