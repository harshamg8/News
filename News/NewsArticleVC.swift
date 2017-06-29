//
//  NewsArticleVC.swift
//  News
//
//  Created by Harsha M G on 15/06/17.
//  Copyright © 2017 Harsha M G. All rights reserved.
//

import UIKit
import SafariServices

class NewsArticleVC: UIViewController,UITableViewDataSource, UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet var newsArticleViewModel: NewsArticlesViewModel!
    
    @IBOutlet weak var newsArticleTableView: UITableView!
    
   
    
    @IBOutlet weak var sortByTextField: UITextField!
    
    let pickerView = UIPickerView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickerView.dataSource = self
        pickerView.delegate = self
        sortByTextField.inputView = pickerView
        
        newsArticleViewModel.getArticlesFromServiceClass { (hasCompleted) in
            if hasCompleted{
                if self.newsArticleViewModel.getNumberOfRows() == 0 {
                    self.present(self.newsArticleViewModel.getAlert(), animated: true, completion: nil)
                }
                DispatchQueue.main.async {
                    self.newsArticleTableView.reloadData()
                }
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.newsArticleTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.newsArticleTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticleViewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NewsArticleCell
        
        cell?.articleTitle.text = newsArticleViewModel.getTitle(index: indexPath.row)
        cell?.articleImage.loadImageFromImageurl(urlString: newsArticleViewModel.newsArticles[indexPath.row].urlToImage!, completion: { (image) in
            
        })

        return cell!
    }
 
    
   
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let svc = SFSafariViewController(url: URL(string: newsArticleViewModel.getUrlForArticle(index: indexPath.row))!)
        self.present(svc, animated: true, completion: nil)
    }
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return newsArticleViewModel.getNumberOfRowsForPickerViewComponent()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let sortBy: String = newsArticleViewModel.getTitleForRowPickerView(index: row)
        sortByTextField.text = sortBy
        newsArticleViewModel.sortBy = sortBy
        return sortBy
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sortByTextField.resignFirstResponder()
        newsArticleViewModel.getArticlesFromServiceClass { (isCompleted) in
            if isCompleted {
                
                if self.newsArticleViewModel.getNumberOfRows() == 0 {
                    
                    self.present(self.newsArticleViewModel.getAlert(), animated: true, completion: nil)
                }
                self.newsArticleTableView.reloadData()
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
