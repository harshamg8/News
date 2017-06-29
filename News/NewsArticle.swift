//
//  NewsArticle.swift
//  News
//
//  Created by Harsha M G on 15/06/17.
//  Copyright © 2017 Harsha M G. All rights reserved.
//

import UIKit

class NewsArticle: NSObject {

    var authror: String?
    var title: String?
    var discription: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    
    init(author: String, title: String, description: String, url: String, urlToImage: String, publishedAt: String) {
        self.authror = author
        self.title = title
        self.discription = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
    
    
}
