//
//  JKPlaceholderView.swift
//  JKPlaceholderViewDemo
//
//  Created by 01 on 2019/10/11.
//  Copyright © 2019 com.01. All rights reserved.
//

import Foundation
import UIKit

public class JKPlaceholderView: UIView {
    
//    MARK: private ivar
    private var maxWidth: CGFloat = 0
    private var contentSize = CGSize.zero
    private let margin: CGFloat = 18
        
    
//   MARK: contentView
    private var _coverBackgroundColor = UIColor.white
    func coverBackgroundColor(color: UIColor) -> JKPlaceholderView {
        _coverBackgroundColor = color
        setBgColor()
        return self
    }
    
    private var _autoCover = false
    func autoCover(auto: Bool) -> JKPlaceholderView {
        _autoCover = auto
        setBgColor()
        setNeedsLayout()
//        layoutIfNeeded()
        return self
    }
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        addSubview(contentView)
        return contentView
    }()
    
    
//    MARK: imageView
    private var _imageName: String?
    func imageName(name: String) -> JKPlaceholderView {
        _imageName = name
        imageView?.image = UIImage(named: name)
        imageView?.isHidden = imageView?.image == nil
        return self
    }
    
    private var _imageSize = CGSize.zero
    func imageSize(size: CGSize) -> JKPlaceholderView {
        _imageSize = size
        setNeedsLayout()
        return self
    }
    
    private lazy var imageView: UIImageView? = {
        if let image = UIImage(named: _imageName ?? "") {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            contentView.addSubview(imageView)
            return imageView
        }
        return nil
    }()
    
    
//    MARK: titleLabel
    private var _titleText: String?
    func titleText(text: String) -> JKPlaceholderView {
        _titleText = text
        titleLabel?.text = text
        titleLabel?.isHidden = text.count == 0
        setNeedsLayout()
        return self
    }
    
    private var _titleFont = UIFont.systemFont(ofSize: 16)
    func titleFont(font: UIFont) -> JKPlaceholderView {
        _titleFont = font
        return self
    }
    
    private var _titleColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
    func titleColor(color: UIColor) -> JKPlaceholderView {
        _titleColor = color
        return self
    }
    
    private var _titleMargin: CGFloat?
    func titleMargin(margin: CGFloat) -> JKPlaceholderView {
        _titleMargin = margin
        return self
    }
    
    private var _titleMaxWidth: CGFloat?
    func titleMaxWidth(max: CGFloat) -> JKPlaceholderView {
        _titleMargin = max
        return self
    }
    
    private lazy var titleLabel: UILabel? = {
        if _titleText?.count ?? 0 > 0 {
            let titleLabel = UILabel()
            titleLabel.textAlignment = .center
            contentView.addSubview(titleLabel)
            return titleLabel
        }
        return nil
    }()
    
    
//    MARK: desLabel
    private var _desText: String?
    func desText(text: String) -> JKPlaceholderView {
        _desText = text
        desLabel?.text = text
        desLabel?.isHidden = text.count == 0
        setNeedsLayout()
        return self
    }
    
    private var _desFont = UIFont.systemFont(ofSize: 14)
    func desFont(font: UIFont) -> JKPlaceholderView {
        _desFont = font
        return self
    }
    
    private var _desColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    func desColor(color: UIColor) -> JKPlaceholderView {
        _desColor = color
        return self
    }
    
    private var _desMargin: CGFloat?
    func desMargin(margin: CGFloat) -> JKPlaceholderView {
        _desMargin = margin
        return self
    }
    
    private var _desMaxWidth: CGFloat?
    func desMaxWidth(max: CGFloat) -> JKPlaceholderView {
        _desMaxWidth = max
        return self
    }
    
    private lazy var desLabel: UILabel? = {
        if _desText?.count ?? 0 > 0 {
            let desLabel = UILabel()
            desLabel.textAlignment = .center
            desLabel.numberOfLines = 0
            contentView.addSubview(desLabel)
            return desLabel
        }
        return nil
    }()
    
    
//    MARK: refreshBtn
    private var _refreshText: String?
    func refreshText(text: String) -> JKPlaceholderView {
        _refreshText = text
        refreshBtn?.setTitle(text, for: .normal)
        desLabel?.isHidden = text.count == 0
        setNeedsLayout()
        return self
    }
    
    private var _refreshFont = UIFont.systemFont(ofSize: 17)
    func refreshFont(font: UIFont) -> JKPlaceholderView {
        _refreshFont = font
        return self
    }
    
    private var _refreshMargin: CGFloat?
    func refreshMargin(margin: CGFloat) -> JKPlaceholderView {
        _refreshMargin = margin
        return self
    }
    
    private var _refreshColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
    func refreshColor(color: UIColor) -> JKPlaceholderView {
        _refreshColor = color
        return self
    }
    
    private var _refreshBgColor = UIColor.white
    func refreshBgColor(color: UIColor) -> JKPlaceholderView {
        _refreshColor = color
        return self
    }
    
    private var _refreshBorderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
    func refreshBorderColor(color: CGColor) -> JKPlaceholderView {
        _refreshBorderColor = color
        return self
    }
    
    private var _refreshBorderWidth: CGFloat = 0
    func refreshBorderWidth(width: CGFloat) -> JKPlaceholderView {
        _refreshBorderWidth = width
        return self
    }
    
    private var _refreshCornerRadius: CGFloat = 0
    func refreshCornerRadius(cornerRadius: CGFloat) -> JKPlaceholderView {
        _refreshCornerRadius = cornerRadius
        return self
    }
    
    private var _refreshSize: CGSize?
    func refreshSize(size: CGSize) -> JKPlaceholderView {
        _refreshSize = size
        return self
    }

    private lazy var refreshBtn: UIButton? = {
        if _refreshText?.count ?? 0 > 0 {
            let refreshBtn = UIButton()
            refreshBtn.addTarget(self, action: #selector(refreshBtnAction), for: .touchUpInside)
            contentView.addSubview(refreshBtn)
            return refreshBtn
        }
        return nil
    }()
    
    
//    MARK: customView
    private var _customView: UIView?
    func customView(view: UIView) -> JKPlaceholderView {
        _customView = view
        contentView.addSubview(view)
        return self
    }

    
//    MARK: action
    private var _tapAction: (()->())?
    private lazy var _tapGes = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
    func tapAction(action: @escaping ()->()) -> JKPlaceholderView {
        addGestureRecognizer(_tapGes)
        _tapAction = action
        return self
    }
    
    private var _refreshAction: (()->())?
    func refreshAction(action: @escaping ()->()) -> JKPlaceholderView {
        _refreshAction = action
        return self
    }
    
    
//    MARK: override
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if let superFrame = superview?.frame {
            maxWidth = _autoCover ? superFrame.width : superFrame.width - 30
            
            if _customView == nil {
                layoutImageView()
                layoutTitleLabel()
                layoutDesLabel()
                layoutRefreshBtn()
            } else {
                contentSize = CGSize(width: _customView!.frame.width, height: _customView!.frame.maxY)
            }
            
            frame.size = _autoCover ? superFrame.size : contentSize
            center = CGPoint(x: superFrame.width / 2, y: superFrame.height / 2)
            contentView.frame.size = contentSize
            contentView.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
            
            let centerX = contentView.frame.width / 2
            
            if _customView == nil {
                imageView?.center.x = centerX
                titleLabel?.center.x = centerX
                desLabel?.center.x = centerX
                refreshBtn?.center.x = centerX
            } else {
                _customView?.center.x = centerX
            }
        }
    }
    
}


private extension JKPlaceholderView {
    @objc func tapGestureAction() {
        _tapAction!()
    }
    
    @objc func refreshBtnAction() {
        _refreshAction!()
    }
    
    func setBgColor() {
        backgroundColor = _autoCover ? _coverBackgroundColor : UIColor.clear
    }
    
    func layoutImageView() {
        guard let image = imageView?.image else {
            return
        }
        var size = image.size
        var scale: CGFloat = 1
        let width = _imageSize.width
        let height = _imageSize.height
        if width > height && height > 0 {
            scale = height / width
            size = CGSize(width: width * scale, height: height)
        } else if height > width && width > 0 {
            scale = width / height
            size = CGSize(width: width, height: height * scale)
        }
        imageView?.frame = CGRect(origin: CGPoint.zero, size: size)
        contentSize.width = size.width
        contentSize.height = imageView!.frame.maxY
    }
    
    func layoutTitleLabel() {
        guard let text = titleLabel?.text else {
            return
        }
        let delta = _titleMargin ?? margin
        var width = _titleMaxWidth ?? maxWidth
        width = (width > maxWidth) ? maxWidth : width
        let size = calculateTextSize(text: text, size: CGSize(width: width, height: _titleFont.lineHeight), font: _titleFont)
        titleLabel?.font = _titleFont
        titleLabel?.textColor = _titleColor
        titleLabel?.frame = CGRect(x: 0, y: contentSize.height + delta, width: size.width, height: size.height)
        titleLabel?.sizeToFit()

        contentSize = CGSize(width: max(size.width, contentSize.width), height: titleLabel!.frame.maxY)
    }
    
    func layoutDesLabel() {
        guard let text = desLabel?.text else {
            return
        }
        let delta = _desMargin ?? margin
        var width = _desMaxWidth ?? maxWidth
        width = (width > maxWidth) ? maxWidth : width
        let size = calculateTextSize(text: text, size: CGSize(width: width, height: 1000), font: _desFont)
        desLabel?.font = _desFont
        desLabel?.textColor = _desColor
        desLabel?.frame = CGRect(x: 0, y: contentSize.height + delta, width: size.width, height: size.height)
        desLabel?.sizeToFit()
        
        contentSize = CGSize(width: max(size.width, contentSize.width), height: desLabel!.frame.maxY)
    }
    
    func layoutRefreshBtn() {
        guard let text = refreshBtn?.currentTitle else {
            return
        }
        
        refreshBtn?.titleLabel?.font = _refreshFont
        refreshBtn?.setTitle(text, for: .normal)
        refreshBtn?.setTitleColor(_refreshColor, for: .normal)
        refreshBtn?.backgroundColor = _refreshBgColor
        refreshBtn?.layer.borderColor = _refreshBorderColor
        refreshBtn?.layer.borderWidth = _refreshBorderWidth
        refreshBtn?.layer.cornerRadius = _refreshCornerRadius
        
        let delta = _refreshMargin ?? margin
        var size = _refreshSize ?? calculateTextSize(text: text, size: CGSize(width: maxWidth, height: _refreshFont.lineHeight), font: _refreshFont)
        size = _refreshSize == nil ? CGSize(width: size.width + 12, height: size.height + 6) : size
        refreshBtn?.frame = CGRect(x: 0, y: contentSize.height + delta, width: size.width, height: size.height)
        
        contentSize = CGSize(width: max(size.width, contentSize.width), height: refreshBtn!.frame.maxY)
    }
    
    func calculateTextSize(text: String, size: CGSize, font: UIFont) -> CGSize {
        let string = text as NSString
        return string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).size
    }
    
}
