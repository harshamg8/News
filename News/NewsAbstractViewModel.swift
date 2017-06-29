//
//  NewsAbstractViewModel.swift
//  News
//
//  Created by Harsha M G on 15/06/17.
//  Copyright © 2017 Harsha M G. All rights reserved.
//

import UIKit

class NewsAbstractViewModel: NSObject {

    var newsSource: NewsSource?
    var newsArticles = [NewsArticle]()
    
    
    func hasArticlesViewModelGotValue(completion: @escaping (Bool) -> ()){
        
        let newsArticlesViewModel = NewsArticlesViewModel()

        completion(true)
     
    }
    
    
    
    func getUrlForNews() -> String{
        
        return (newsSource?.url)!
    }
    
    func getDescription()-> String{
        
        return (newsSource?.discription)!
    }
    
    func getSource()-> String{
        
        return (newsSource?.id)!
        
        
    }
}
