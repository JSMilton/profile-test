//
//  TestHeaderView.swift
//  profile-test
//
//  Created by Willis on 29/09/2016.
//  Copyright © 2016 James Milton. All rights reserved.
//

import UIKit

class TestHeaderView: UIView {

    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.autoPinEdgesToSuperviewEdges(with: UIEdgeInsetsMake(50, 0, 0, 0))
        label.text = "Some text"
        
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
