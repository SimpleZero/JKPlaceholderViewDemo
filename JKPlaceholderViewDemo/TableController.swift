//
//  TableController.swift
//  JKPlaceholderViewDemo
//
//  Created by 01 on 2019/10/16.
//  Copyright © 2019 com.01. All rights reserved.
//

import UIKit

class TableController: UIViewController, UITableViewDataSource {
    
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
        
        tableview.jk.placeholder = (JKPlaceholderView()).imageName(name: "empty").titleText(text: "功能").desText(text: "为了区分cover与否，这里设置了vc.view背景色为红色，placeholder背景色为白色，实际上非cover模式placeholder自动设置为clear，cover模式自动设置为white。\nplaceholder内部控件可自适应调节，以下为手动调节方法:\n1. imageSize可调节image大小\n2. titleMaxWidth可调节title宽度\n3. desMaxWidth可调节des宽度\n\nplaceholder还提供了自定义refresh的一些方法，不再一一列举。\n点击placeholder与refresh均可响应事件。").refreshText(text: "refresh").refreshAction {
               print("this is refresh action")
           }.tapAction {
               print("this is placeholder action")
           }
        
        view.addSubview(tableview)
        
        let addBtn = UIButton(frame: CGRect(x: 0, y: tableview.frame.maxY + 30, width: 80, height: 50))
        addBtn.setTitle("add", for: .normal)
        addBtn.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        view.addSubview(addBtn)
        
        let minusBtn = UIButton()
        minusBtn.frame = addBtn.frame
        minusBtn.setTitle("minus", for: .normal)
        minusBtn.addTarget(self, action: #selector(minusAction), for: .touchUpInside)
        view.addSubview(minusBtn)
        
        addBtn.frame.origin.x = 30
        minusBtn.frame.origin.x = view.frame.width - minusBtn.frame.width - 30
        
    }

    var datasource: Array<String> = ["1"]
    lazy var tableview: UITableView = {
        let x: CGFloat = 0
        let y = UIApplication.shared.statusBarFrame.height
        let width = view.frame.width
        let height = view.frame.height - 150
        let tableView = UITableView(frame: CGRect(x: x, y: y, width: width, height: height), style: .plain)
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    //    MARK:UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify = "identify"
        var cell = tableView.dequeueReusableCell(withIdentifier: identify)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identify)
        }
        cell?.textLabel?.text = datasource[indexPath.row]
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }

    @objc func addAction() {
        datasource.append("1")
        tableview.jk.reload()
    }
    
    @objc func minusAction() {
        guard datasource.count > 0 else {
            return
        }
        datasource.remove(at: datasource.count - 1)
        tableview.jk.reload()
    }
}

