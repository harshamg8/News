//
//  NewsArticlesViewModel.swift
//  News
//
//  Created by Harsha M G on 15/06/17.
//  Copyright © 2017 Harsha M G. All rights reserved.
//

import UIKit

class NewsArticlesViewModel: NSObject {

    var newsArticles = [NewsArticle]()
    var articleImage = UIImage()
    var images: [UIImage] = []
    let sortByArray: [String] = ["latest", "top", "popular"]
    var id: String = ""
    var sortBy: String = ""
    
    func getArticlesFromServiceClass(completion: @escaping (Bool) -> ()){
        
        let newsArticleService = NewsArticlesService()
      
        newsArticleService.getArticles(urlString: "\(Constants.url)" + "/articles?source=" + "\(self.id)" + "&sortBy=" + "\(self.sortBy)" + "&apiKey=" + "\(Constants.apiKey)") { (articles) in
            self.newsArticles = articles
            DispatchQueue.main.async {
                completion(true)
            }
        }
    }
    
    
    func getNumberOfRows() -> Int {
        return self.newsArticles.count
    }
    
    
    
    
    func getTitle(index: Int) -> String {
        return self.newsArticles[index].title!
    }
    
    func getImage() -> UIImage {
        return self.articleImage
    }
    
    func getUrlForArticle(index: Int) -> String {
        return newsArticles[index].url!
    }
    
    func getNumberOfRowsForPickerViewComponent() -> Int {
        return self.sortByArray.count
    }
    
    func getTitleForRowPickerView(index: Int) -> String {
        return sortByArray[index]
    }
    
    func getAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Alert", message: "The news source" + " " + "(\(self.id))" + " " + "you've selected isn't available sorted by" + " " + "\(self.sortBy)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        return alert
    }
   
    
    
    
    func getImageFromServiceClass(index: Int, completion: @escaping (Bool) -> ()){
        let customImage = CustomImageView()
        print(index)
        customImage.loadImageFromImageurl(urlString: newsArticles[index].urlToImage!) { (image) in
        self.articleImage = image
    }
        DispatchQueue.main.async {
            completion(true)
        }
    }
    
}
