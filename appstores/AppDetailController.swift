//
//  AppDetailController.swift
//  appstores
//
//  Created by Admin on 22/06/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit

class AppDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    private let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.redColor()
        collectionView?.registerClass(AppDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header  = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerId, forIndexPath: indexPath)
        
        return header
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(view.frame.width, 170)
    }
}
class AppDetailHeader: BaseCell {
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .ScaleAspectFill
        
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.blueColor()
        addSubview(imageView)
        
    }
}
class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
    }
}