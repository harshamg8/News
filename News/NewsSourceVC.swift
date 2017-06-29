//
//  ViewController.swift
//  News
//
//  Created by Harsha M G on 09/06/17.
//  Copyright © 2017 Harsha M G. All rights reserved.
//

import UIKit

class NewsSourceVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet var viewModel: NewsSourceViewModel!

    @IBOutlet weak var collectionView: UICollectionView!
    
    var tappedItem: Int = 0
    var tappedSection: Int = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //collectionView.backgroundColor = UIColor.lightGray

        viewModel.getDataFromServiceClass { (hasValue) in
            if hasValue {
                self.collectionView.reloadData()
                
            }
        }
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.getNumberOfSections()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView = UICollectionReusableView()
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as? NewsSourceHeaderViewCollectionReusableView
            
            headerView?.sectionName.text = viewModel.getNamesForSections(index: indexPath.section)
            reusableView = headerView!
            
        }
        return reusableView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
        return viewModel.getNumberOfItems(index: section)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NewsCell
        
        cell?.idLabel.text = viewModel.getId(index1: indexPath.section, index2: indexPath.row)
        return cell!
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        tappedItem = indexPath.item
        tappedSection = indexPath.section
        performSegue(withIdentifier: "toAbstract", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newsAbstractVC = segue.destination as? NewsAbstractVC
        newsAbstractVC?.newsAbstractViewModel.newsSource = viewModel.getNewsSourceObject(index1: tappedSection, index2: tappedItem)
        newsAbstractVC?.title = viewModel.getId(index1: tappedSection, index2: tappedItem)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

