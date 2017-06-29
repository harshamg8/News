//
//  News.swift
//  News
//
//  Created by Harsha M G on 14/06/17.
//  Copyright © 2017 Harsha M G. All rights reserved.
//

import UIKit

class NewsSource: NSObject {
    
    var id: String?
    var name: String?
    var discription: String?
    var url: String?
    var category: String?
    var language: String?
    var country: String?
    var sortBysAvailable: Array<Any>?

    init(id:String, name:String, discription:String, url:String, category: String, language: String, country: String, sortByAvailable: Array<Any>) {
        self.id = id
        self.name = name
        self.discription = discription
        self.url = url
        self.category = category
        self.language = language
        self.country = country
        self.sortBysAvailable = sortByAvailable
    }
}
