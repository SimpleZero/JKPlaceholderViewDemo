//
//  JKPlaceholderHelper.swift
//  JKPlaceholderViewDemo
//
//  Created by 01 on 2019/10/12.
//  Copyright © 2019 com.01. All rights reserved.
//

import UIKit

private var jk_placeholder_key: UInt8 = 0

struct JK<T> {
    let base: T
    init(_ base: T) {
        self.base = base
    }
}

protocol JKCompatible {
    associatedtype JKBase
    
    var jk: JK<JKBase> { get set }
}

extension JKCompatible {
    var jk: JK<Self> {
        get {JK(self)}
        set {}
    }
}

extension JK where T: UIView {
    var placeholder: JKPlaceholderView {
        set {
            for view in base.subviews {
                if view is JKPlaceholderView {
                    view.removeFromSuperview()
                }
            }
            objc_setAssociatedObject(base, &jk_placeholder_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            base.addSubview(newValue)
            reload()
        }
        get {
            objc_getAssociatedObject(base, &jk_placeholder_key) as! JKPlaceholderView
        }
    }
    
    func reload() {
        if let s = base as? UIScrollView {
            base.jk.placeholder.isHidden = s.jk.dataCount() > 0
        } else {
            base.jk.placeholder.isHidden = true
        }
        base.bringSubviewToFront(base.jk.placeholder)
    }
    
    func reload(show: Bool) {
        base.jk.placeholder.isHidden = !show
        base.bringSubviewToFront(base.jk.placeholder)
    }
    
}

extension JK where T: UIScrollView {
    private func dataCount() -> Int {
        var count = 0
        if let tableView = base as? UITableView {
            tableView.reloadData()
            for section in 0..<tableView.numberOfSections {
                count += tableView.numberOfRows(inSection: section)
            }
            
        } else if let collectionView = base as? UICollectionView {
            collectionView.reloadData()
            for section in 0..<collectionView.numberOfSections {
                count += collectionView.numberOfItems(inSection: section)
            }
        }
        return count
    }
}


extension UIView: JKCompatible {}

