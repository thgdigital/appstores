//
//  CategoriaCell.swift
//  appstores
//
//  Created by Admin on 19/06/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit

class CategoriaCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var featuredAppsController: ViewController?
    
    
    var appCategoria: AppCategoria? {
        didSet{
            if let name = appCategoria?.name {
                nameLabel.text = name
            
            }
            appClletionView.reloadData()
        }
    }
    
    private let  cellId = "appCellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dividirLineView: UIView = {
       
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Best New Games"
        label.font = UIFont.systemFontOfSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    let appClletionView : UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        let colletion  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletion.translatesAutoresizingMaskIntoConstraints = false
        colletion.backgroundColor = UIColor.clearColor()

        return colletion
    }()
    
    func setupViews(){
        
        backgroundColor = UIColor.clearColor()
        addSubview(appClletionView)
        addSubview(dividirLineView)
        addSubview(nameLabel)
        
        
        appClletionView.dataSource = self
        appClletionView.delegate = self
        appClletionView.registerClass(AppCell.self, forCellWithReuseIdentifier: cellId)
        
         addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dividirLineView]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appClletionView]))


        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[nameLabel(30)][v0][v1(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appClletionView, "v1": dividirLineView, "nameLabel": nameLabel]))
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count =  appCategoria?.apps?.count{
            return count
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! AppCell
        cell.app = appCategoria?.apps?[indexPath.item]
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, frame.height - 32)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let app = appCategoria?.apps?[indexPath.item]{
            
            featuredAppsController?.showAppDetailForApp(app)
        }
        
        
    }
}
class AppCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    var app: App? {
        didSet{
            if let name = app?.name {
                
                nameLabel.text = name
                
                let rect = NSString(string: name).boundingRectWithSize(CGSizeMake(frame.width, 1000), options: NSStringDrawingOptions.UsesFontLeading.union(NSStringDrawingOptions.UsesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14)], context: nil)
                
                if rect.height > 20 {
                    categoriaLabel.frame = CGRectMake(0, frame.width + 38, frame.width, 20)
                    precoLabel.frame = CGRectMake(0, frame.width + 56, frame.width, 20)
                } else {
                    categoriaLabel.frame = CGRectMake(0, frame.width + 22, frame.width, 20)
                    precoLabel.frame = CGRectMake(0, frame.width + 40, frame.width, 20)
                }
                
                nameLabel.frame = CGRectMake(0, frame.width + 5, frame.width, 40)
                nameLabel.sizeToFit()
            }
            if let categoria = app?.category{
                
                categoriaLabel.text = categoria
            }
            if let preco = app?.price{
                
                precoLabel.text = "R$ \(preco)"
            }else{
                precoLabel.text = ""
            }
            if let image = app?.imageName{
                imageView.image = UIImage(named: image)
            }
         
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let imageView: UIImageView = {
       
        let iv = UIImageView()
        iv.image =  UIImage(named: "frozen")
        iv.contentMode = .ScaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        
        return iv
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Disney Build It: Frozen"
        label.font = UIFont.systemFontOfSize(12)
        label.numberOfLines = 2
        return label
    }()
    
    let categoriaLabel: UILabel = {
        let label = UILabel()
        label.text = "Entreterimento"
        label.font = UIFont.systemFontOfSize(13)
        label.textColor = UIColor.darkGrayColor()
        return label
    }()
    
    let precoLabel: UILabel = {
        let label = UILabel()
        label.text = "R$ 1,99"
        label.font = UIFont.systemFontOfSize(13)
        label.textColor = UIColor.darkGrayColor()
        return label
    }()
    
   func setupViews(){
   
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(categoriaLabel)
        addSubview(precoLabel)
        imageView.frame = CGRectMake(0, 0, frame.width, frame.width)
    
    }
}