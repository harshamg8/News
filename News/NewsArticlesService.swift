//
//  NewsArticlesService.swift
//  News
//
//  Created by Harsha M G on 15/06/17.
//  Copyright © 2017 Harsha M G. All rights reserved.
//

import UIKit

class NewsArticlesService: NSObject {

    var articles = [NewsArticle]()

    
    
    func getArticles(urlString: String, completion: @escaping ([NewsArticle])-> ()){
        
        guard let url = URL(string: urlString) else{
            print("Error converting string to URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil{
                print("Error occured")
            }
            
            do{
                if let d = data, let jsonDict = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? [String:Any]{
                    
                    let articlesArray = jsonDict["articles"] as? [[String:Any]]
                    
                    if let a = articlesArray{
                        for article in a{
                            if let articleDict = article as? [String:Any]{
                               
                               var n = NSNull()
                                 var author = ""
                                var title = ""
                                var description = ""
                                var url = ""
                                var urlToImage = ""
                                var publishedAt = ""
                                
                                if let athr = articleDict["author"] as? NSNull {
                                    author = ""
                                    n = athr
                                }
                                if let athr = articleDict["author"] as? String {
                                    author = athr
                                }
                                
                                if let ttl = articleDict["title"] as? NSNull{
                                    title = ""
                                    n = ttl
                                }
                                if let ttl = articleDict["title"] as? String{
                                    title = ttl
                                }
                                
                                if let desc = articleDict["description"] as? NSNull {
                                    description = ""
                                    n = desc
                                }
                                
                                if let desc = articleDict["description"] as? String{
                                    description = desc
                                }
                                
                                if let urlString = articleDict["url"] as? NSNull {
                                    url = ""
                                    n = urlString
                                }
                                
                                if let urlString = articleDict["url"] as? String{
                                    url = urlString
                                }
                                
                                if let urlToImageString = articleDict["urlToImage"] as? NSNull {
                                    urlToImage = ""
                                    n = urlToImageString
                                }
                                
                                if let urlToImageString = articleDict["urlToImage"] as? String{
                                    urlToImage = urlToImageString
                                }
                                
                                if let publishedAtString = articleDict["publishedAt"] as? NSNull {
                                    publishedAt = ""
                                    n = publishedAtString
                                }
                                
                                if let publishedAtString = articleDict["publishedAt"] as? String{
                                    publishedAt = publishedAtString
                                }
                                
                                let articleObject = NewsArticle(author:author , title:title, description: description,  url:url , urlToImage:urlToImage , publishedAt:publishedAt)
                                
                                self.articles.append(articleObject)
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completion(self.articles)
                    }
                    
                }
                
            } catch let jsonError{
                print(jsonError)
            }
            
        }.resume()
        
        
    }
 
}

let imageCache = NSCache<AnyObject, AnyObject>()


class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageFromImageurl(urlString: String, completion: @escaping (UIImage) -> ()){
        let url = URL(string: urlString)
        imageUrlString = urlString
        image = nil
        print(urlString)
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
           DispatchQueue.main.async {
                self.image = imageFromCache
            
                completion(self.image!)
            }
            
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if error != nil{
                print(error)
                return
            }
            DispatchQueue.main.async {
                let imageTocache = UIImage(data: data!)
                if self.imageUrlString == urlString {
                    self.image = imageTocache
                    completion(self.image!)
                }
                
                imageCache.setObject(imageTocache!, forKey: urlString as AnyObject)
            }
        }).resume()
    }
    

    
}















