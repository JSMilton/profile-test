//
//  ScrollingHeaderView.swift
//  profile-test
//
//  Created by Willis on 29/09/2016.
//  Copyright © 2016 James Milton. All rights reserved.
//

import UIKit

fileprivate let kHeaderScaleDamping = CGFloat(30)

class ScrollingHeaderView: UIView {

    let imageView = UIImageView()
    let loadingSpinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    private var blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func commonInit() {
        addSubview(imageView)
        addSubview(loadingSpinner)
        imageView.addSubview(blurView)
        
        imageView.autoPinEdgesToSuperviewEdges()
        loadingSpinner.autoCenterInSuperview()
        blurView.autoPinEdgesToSuperviewEdges()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        loadingSpinner.hidesWhenStopped = false
        loadingSpinner.alpha = 0
    }
    
    func updateSpinner(_ offset: CGFloat) {
        let scaledOffset = (offset / CGFloat(60)) * -1
        loadingSpinner.alpha = scaledOffset
        loadingSpinner.transform = CGAffineTransform.init(rotationAngle: scaledOffset)
    }

}
