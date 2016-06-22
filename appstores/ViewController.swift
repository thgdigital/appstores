//
//  ViewController.swift
//  appstores
//
//  Created by Admin on 19/06/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit


class ViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
   

    private  let cellId = "cellId"
    private  let largcellId = "largcellId"
    private let headerCellId = "headerCellId"
    var featuredApps : FeaturedApps?
    
    var appCategorias :  [AppCategoria]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Features Apps"
        collectionView?.backgroundColor = UIColor.whiteColor()
        
        collectionView?.registerClass(CategoriaCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.registerClass(LarguraCell.self, forCellWithReuseIdentifier: largcellId)
        
        collectionView?.registerClass(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellId)
        //appCategoria = AppCategoria.sampleAppCategories()
        
        
        AppCategoria.fetchFeaturedApps { (featuredApps) in
        
            self.featuredApps = featuredApps
            self.appCategorias = featuredApps.appCategories
            
             self.collectionView?.reloadData()
        }
        
    }
    func showAppDetailForApp(app: App) {
        let layout = UICollectionViewFlowLayout()
        let appDetailController = AppDetailController(collectionViewLayout: layout)
       // appDetailController.app = app
        navigationController?.pushViewController(appDetailController, animated: true)
    }
 
    
    override func collectionView(collectioView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        if indexPath.item == 2 {
            
            let cell = collectionView?.dequeueReusableCellWithReuseIdentifier(largcellId, forIndexPath: indexPath) as! LarguraCell
            cell.appCategoria = appCategorias?[indexPath.item]
            cell.featuredAppsController = self
            return cell

        }
        let cell = collectionView?.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! CategoriaCell
        cell.appCategoria = appCategorias?[indexPath.item]
        cell.featuredAppsController = self
        
        return cell
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = appCategorias?.count{
            return count
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if indexPath.item == 2 {
        
            return CGSizeMake(view.frame.width, 160)
        }
        return CGSizeMake(view.frame.width, 230)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(view.frame.width, 120)
        
    }
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header =  collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerCellId, forIndexPath: indexPath) as! Header
        header.appCategoria = featuredApps?.bannerCategory
        
        return header
    }

}


//Header Class
class Header: CategoriaCell {
    let cellId = "bannerId"
    
    
    override func setupViews() {
      
        appClletionView.dataSource = self
        appClletionView.delegate = self
        appClletionView.registerClass(BannerAppCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(appClletionView)
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appClletionView]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appClletionView]))
    }
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! AppCell
        cell.app = appCategoria?.apps?[indexPath.item]
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(frame.width / 2 + 50, frame.height)
    }
    
    private class BannerAppCell: AppCell {
        
        private override func setupViews() {
            addSubview(imageView)
            imageView.layer.cornerRadius = 0
            imageView.layer.borderColor = UIColor(white: 0.5, alpha: 05).CGColor
            imageView.layer.borderWidth = 0.5
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
            
        }
    }

}


//Customizando a largura do box 50%
class LarguraCell: CategoriaCell {
    
    private let largeAppCellId = "largeAppCellId"
    
    override func setupViews() {
        super.setupViews()
        appClletionView.registerClass(LarguraAppCell.self, forCellWithReuseIdentifier: "largeAppCellId")
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(largeAppCellId, forIndexPath: indexPath) as! AppCell
        cell.app = appCategoria?.apps?[indexPath.item]
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(200, frame.height - 32)
    }
    
    private class LarguraAppCell: AppCell {
        
        private override func setupViews() {
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-2-[v0]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))

        }
    }
}
