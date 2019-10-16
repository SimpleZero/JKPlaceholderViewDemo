//
//  CustomController.swift
//  JKPlaceholderViewDemo
//
//  Created by 01 on 2019/10/16.
//  Copyright © 2019 com.01. All rights reserved.
//

import UIKit

class CustomController: UIViewController {
    //    MARK: life
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customView = UIView()
        
        let label = UILabel()
        label.text = "啥也不说了，给您劈个叉吧"
        label.sizeToFit()
        customView.addSubview(label)
        
        let image = UIImage(named: "picha")!
        let imageView = UIImageView(image: image)
        let scale: CGFloat = image.size.height / image.size.width
        imageView.frame.size = CGSize(width: view.frame.width / 2, height: scale * view.frame.width / 2)
        imageView.contentMode = .scaleAspectFit
        customView.addSubview(imageView)
        
        customView.frame.size = CGSize(width: max(imageView.frame.width, label.frame.width), height: label.frame.maxY + imageView.frame.maxY + 20)
        let centerX = customView.frame.width / 2
        label.center.x = centerX
        
        imageView.frame.origin.y = label.frame.maxY + 20
        imageView.center.x = centerX
        
        view.jk.placeholder = (JKPlaceholderView()).customView(view: customView)
        view.jk.reload(show: true)
    }

}
