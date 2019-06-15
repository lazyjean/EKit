//
//  EImageProgressView.swift
//  EKit
//
//  Created by 刘真 on 2019/6/15.
//

import UIKit

@IBDesignable

class EImageProgress: UIView {

    @IBInspectable public var progress: CGFloat = 0.5 {
        didSet {
            progress = min(progress, 1)
            progress = max(progress, 0)
            setNeedsLayout()
        }
    }

    //用作背景的图片
    @IBInspectable public var fullImage: UIImage? {
        didSet {
            fullImageView.image = fullImage
            setNeedsLayout()
        }
    }

    //覆盖在上层，显示当前进度的图片
    @IBInspectable public var progressImage: UIImage? {
        didSet {
            progressImageView.image = progressImage
            setNeedsLayout()
        }
    }

    private lazy var fullImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .left
        return iv
    }()

    private lazy var progressImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .left
        iv.clipsToBounds = true
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        self.backgroundColor = .clear
        addSubview(fullImageView)
        addSubview(progressImageView)
    }

    override func layoutSubviews() {
        fullImageView.frame = self.bounds

        progressImageView.frame = CGRect(x: 0, y: 0, width: fullImageView.frame.width * self.progress, height: self.bounds.height)
    }

    override func prepareForInterfaceBuilder() {
        setup()
        setNeedsLayout()
    }
}
