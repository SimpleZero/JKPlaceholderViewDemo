//
//  AbilityController.swift
//  JKPlaceholderViewDemo
//
//  Created by 01 on 2019/10/16.
//  Copyright © 2019 com.01. All rights reserved.
//

import UIKit

class AbilityController: UIViewController {
    
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
        
        setupUI()
    }
    
    
//    MARK: UI
    
    var displayView: UIView!
    var controlView: UIView!
    
    func setupUI() {
        setupDisplayView()
        setupControlView()
    }
    
    func setupDisplayView() {
        let x: CGFloat = 0
        let y = UIApplication.shared.statusBarFrame.height
        let width = view.frame.width
        let height = view.frame.height - 200
        displayView = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        view.addSubview(displayView)
        
        displayView.jk.placeholder = (JKPlaceholderView()).imageName(name: "empty").titleText(text: "功能").desText(text: "为了区分cover与否，这里设置了vc.view背景色为红色，placeholder背景色为白色，实际上非cover模式placeholder自动设置为clear，cover模式自动设置为white。\nplaceholder内部控件可自适应调节，以下为手动调节方法:\n1. imageSize可调节image大小\n2. titleMaxWidth可调节title宽度\n3. desMaxWidth可调节des宽度\n\nplaceholder还提供了自定义refresh的一些方法，不再一一列举。\n点击placeholder与refresh均可响应事件。").refreshText(text: "refresh").refreshAction {
            print("this is refresh action")
        }.tapAction {
            print("this is placeholder action")
        }
        
        displayView.jk.placeholder.backgroundColor = UIColor.white
        displayView.jk.reload(show: true)
    }
    
    func setupControlView() {
        let x: CGFloat = 0
        let y = displayView.frame.maxY
        let width = view.frame.width
        let height = view.frame.height - y
        controlView = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        view.addSubview(controlView)
        
        let label = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
        label.text = "autoCover"
        controlView.addSubview(label)
        
        let switcher = UISwitch()
        switcher.frame.origin.x = label.frame.maxX
        switcher.center.y = label.center.y
        switcher.addTarget(self, action: #selector(switcherAction(switcher:)), for: .valueChanged)
        controlView.addSubview(switcher)
    }
    
    @objc func switcherAction(switcher: UISwitch) {
        let _ = displayView.jk.placeholder.autoCover(auto: switcher.isOn)
        displayView.jk.placeholder.backgroundColor = UIColor.white
    }
}
