//
//  ScrollingHeaderTableViewController.swift
//  profile-test
//
//  Created by James Milton on 28/09/2016.
//  Copyright © 2016 James Milton. All rights reserved.
//

import UIKit
import PureLayout

class ScrollingHeaderTableViewController: UIViewController {
    
    let tableView = UITableView()
    var headerImageView = UIImageView()
    var scrollingNavigationBar = ScrollingHeaderNavigationBar()
    var navigationBarHeightConstraint: NSLayoutConstraint!
    var headerImageViewHeightConstraint: NSLayoutConstraint!
    
    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    var navigationBarHeight: CGFloat {
        return navigationController?.navigationBar.frame.height ?? 0.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(headerImageView)
        view.addSubview(tableView)
        view.addSubview(scrollingNavigationBar)
        
        headerImageView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .bottom)
        self.headerImageViewHeightConstraint = headerImageView.autoSetDimension(.height, toSize: 88)
        
        scrollingNavigationBar.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .bottom)
        navigationBarHeightConstraint = scrollingNavigationBar.autoSetDimension(.height, toSize: 44)
        
        tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .top)
        tableView.autoPinEdge(.top, to: .bottom, of: scrollingNavigationBar)
        
        headerImageView.image = UIImage(named: "bill-gates")
        headerImageView.contentMode = .scaleAspectFill
        
        scrollingNavigationBar.titleLabel.text = "Nav bar"
        scrollingNavigationBar.backgroundColor = .clear
        
        tableView.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let navbarheight = navigationBarHeight+statusBarHeight
        let imageViewHeight = navbarheight * 1.5
        navigationBarHeightConstraint.constant = navbarheight
        headerImageViewHeightConstraint.constant = imageViewHeight
        
        tableView.contentInset = UIEdgeInsets(top: imageViewHeight, left: 0, bottom: bottomLayoutGuide.length, right: 0)
    }
    
    func backButtonPressed() {
        fatalError("override in subclass")
    }
    
    func rightBarButtonPressed() {
        fatalError("override in subclass")
    }
    
    func tableViewOffsetDidChange() {
        
    }

}
