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
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var titleLabelBottomConstraint: NSLayoutConstraint!
    
    override var backgroundColor: UIColor? {
        set {
            subviews.first?.backgroundColor = newValue
        }
        get {
            return subviews.first?.backgroundColor
        }
    }
    
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabelBottomConstraint.constant = -titleLabel.frame.height
    }
    
}