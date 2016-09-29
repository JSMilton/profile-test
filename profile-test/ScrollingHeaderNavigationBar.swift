//
//  ScrollingHeaderNavigationBar.swift
//  profile-test
//
//  Created by James Milton on 28/09/2016.
//  Copyright © 2016 James Milton. All rights reserved.
//

import UIKit
import PureLayout

class ScrollingHeaderNavigationBar: UIView {
    
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var titleLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundView: UIView!
    
    private var titleLabelMaxOffset = CGFloat(44)
    
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
        let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)!.first as! UIView
        addSubview(view)
        view.frame = bounds
        view.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        
        backgroundColor = .clear
        view.backgroundColor = .clear
        
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabelMaxOffset = titleLabel.frame.height
    }
    
    func updateTitlePositionAndBackgroundAlpha(withOffset offset: CGFloat) {
        var value = max(offset * -1, 0)
        value = min(value, titleLabelMaxOffset)
        
        titleLabelBottomConstraint.constant = value - titleLabelMaxOffset
        backgroundView.alpha = value / titleLabelMaxOffset
    }
    
}
 
