//
//  ViewController.swift
//  JKPlaceholderViewDemo
//
//  Created by 01 on 2019/10/10.
//  Copyright © 2019 com.01. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var tableview: UITableView = {
        let x: CGFloat = 0
        let y = UIApplication.shared.statusBarFrame.height
        let width = view.frame.width
        let height = view.frame.height
        let tableView = UITableView(frame: CGRect(x: x, y: y, width: width, height: height), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    let datasource: Array<String> = ["基本功能", "自定义view", "tableView", "collectionView"]
    let vcCls: Array<UIViewController.Type> = [AbilityController.self, CustomController.self, TableController.self, CollectionController.self]

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        title = "Demo"
        view.addSubview(tableview)
    }

    
//    MARK:UITableViewDataSource/UITableViewDelegate
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let index = indexPath.row
        let vc = vcCls[index].init()
        vc.title = datasource[index]
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

