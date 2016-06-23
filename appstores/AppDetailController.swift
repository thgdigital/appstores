//
//  AppDetailController.swift
//  appstores
//
//  Created by Admin on 22/06/16.
//  Copyright © 2016 THG Digital. All rights reserved.
//

import UIKit

class AppDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {

    
    var app: App? {
        didSet {
            
        
        }
    }
    
    private let headerId = "headerCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(AppDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header  = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerId, forIndexPath: indexPath) as! AppDetailHeader
      
        header.app = app
        
        return header
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(view.frame.width, 170)
    }
}
class AppDetailHeader: BaseCell {
    
    var app: App? {
        didSet {
            if let image = app?.imageName {
                
                imageView.image = UIImage(named: image)
            }
            
            if let name = app?.name {
                nameLabel.text = name
            }
            if let preco = app?.price {
                
                buyBotao.setTitle("R$ \(preco)", forState: .Normal)
            }
        }
    }
    
    let segementedControll: UISegmentedControl = {
        let sc = UISegmentedControl(items:["Detalhes", "Revisão", "Relacionado"])
        sc.tintColor = UIColor.darkGrayColor()
        sc.selectedSegmentIndex = 0
        
        return sc
    }()
    
    let nameLabel : UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFontOfSize(16)
        name.text = "Nome app"
        return name
    }()
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .ScaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    let buyBotao: UIButton = {
        let botao = UIButton(type: .System)
        botao.setTitle("Baixar", forState: .Normal)
        botao.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).CGColor
        botao.layer.borderWidth = 1
        botao.layer.cornerRadius = 5
        botao.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
        return botao
    }()
    
    let dividiView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(segementedControll)
        addSubview(nameLabel)
        addSubview(buyBotao)
        addSubview(dividiView)
        
        addConstraintsWithFormat("H:|-14-[v0(100)]-8-[v1]|", views: imageView, nameLabel)
        addConstraintsWithFormat("V:|-14-[v0(100)]", views: imageView)
        
        addConstraintsWithFormat("V:|-14-[v0(20)]", views: nameLabel)
        
        addConstraintsWithFormat("H:|-40-[v0]-40-|", views: segementedControll)
        addConstraintsWithFormat("V:[v0(34)]-8-|", views: segementedControll)
        
        addConstraintsWithFormat("H:[v0(80)]-14-|", views: buyBotao)
        addConstraintsWithFormat("V:[v0(32)]-54-|", views: buyBotao)
     
        addConstraintsWithFormat("H:|[v0]|", views: dividiView)
        addConstraintsWithFormat("V:[v0(0.5)]|", views: dividiView)
        
    }
}
extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerate() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
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