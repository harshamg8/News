//
//  NewsAbstractVC.swift
//  News
//
//  Created by Harsha M G on 15/06/17.
//  Copyright © 2017 Harsha M G. All rights reserved.
//

import UIKit
import SafariServices

class NewsAbstractVC: UIViewController {

    @IBOutlet var newsAbstractViewModel: NewsAbstractViewModel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        descriptionLabel.text = newsAbstractViewModel.getDescription()
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newsButtonClicked(_ sender: UIButton) {
        
        let svc = SFSafariViewController(url: URL(string: newsAbstractViewModel.getUrlForNews())!)
        
        self.present(svc, animated: true, completion: nil)
        
    }

    @IBAction func articlesButtonClicked(_ sender: UIButton) {
        

        self.performSegue(withIdentifier: "articles", sender: self)
        
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "articles" {
            let articleVC = segue.destination as? NewsArticleVC
            articleVC?.newsArticleViewModel.id = self.navigationItem.title!
            
        }
    
    }
    

}
