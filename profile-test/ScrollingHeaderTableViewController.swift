//
//  ScrollingHeaderTableViewController.swift
//  profile-test
//
//  Created by James Milton on 28/09/2016.
//  Copyright © 2016 James Milton. All rights reserved.
//

import UIKit
import PureLayout

fileprivate let kHeaderScaleDamping = CGFloat(30)

class ScrollingHeaderTableViewController: UIViewController {
    
    let tableView = UITableView()
    private var headerImageView = UIImageView()
    private var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private var scrollingNavigationBar = ScrollingHeaderNavigationBar()
    private var navigationBarHeightConstraint: NSLayoutConstraint!
    private var headerImageViewHeightConstraint: NSLayoutConstraint!
    
    private var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    private var navigationBarHeight: CGFloat {
        return navigationController?.navigationBar.frame.height ?? 0.0
    }
    
    private var labelAppearanceThreshold = CGFloat(0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headerImageView)
        view.addSubview(tableView)
        view.addSubview(scrollingNavigationBar)
        
        headerImageView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .bottom)
        self.headerImageViewHeightConstraint = headerImageView.autoSetDimension(.height, toSize: 88)
        
        scrollingNavigationBar.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .bottom)
        navigationBarHeightConstraint = scrollingNavigationBar.autoSetDimension(.height, toSize: 44)
        
        tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .top)
        tableView.autoPinEdge(.top, to: .bottom, of: scrollingNavigationBar)
        
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        
        scrollingNavigationBar.backgroundColor = .clear
        tableView.backgroundColor = .clear
        
        headerImageView.addSubview(visualEffectView)
        visualEffectView.autoPinEdgesToSuperviewEdges()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // If you want the header image views height to match the table headers height,
    // then set the table headers frame in the subclasses viewWillLayoutSubviews()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let navbarheight = navigationBarHeight+statusBarHeight
        navigationBarHeightConstraint.constant = navbarheight
        
        if let tableHeaderHeight = tableView.tableHeaderView?.frame.height {
            let imageViewHeight = navbarheight + tableHeaderHeight
            headerImageViewHeightConstraint.constant = imageViewHeight
        }
    }
    
    func backButtonPressed() {
        fatalError("override in subclass")
    }
    
    func rightBarButtonPressed() {
        fatalError("override in subclass")
    }
    
    func tableViewOffsetDidChange() {
        let adjustedOffset = tableView.contentOffset.y - labelAppearanceThreshold
        scrollingNavigationBar.updateTitlePositionAndBackgroundAlpha(withOffset: adjustedOffset)
        updateHeaderImageTransform()
    }
    
    func setTitleAppearanceContentOffset(_ offset: CGFloat) {
        labelAppearanceThreshold = offset
    }
    
    func setHeaderImageViewImage(_ image: UIImage?) {
        headerImageView.image = image
    }
    
    func setBackButtonHidden(_ isHidden: Bool) {
        scrollingNavigationBar.backButton.isHidden = isHidden
    }
    
    func setNavbarTitle(_ titleText: String?) {
        scrollingNavigationBar.titleLabel.text = titleText
    }
    
    private func updateHeaderImageTransform() {
        let offset = tableView.contentOffset.y
        var scale = CGFloat(1)
        
        if offset < 0 {
            scale = fabs(offset / kHeaderScaleDamping) + 1.0
        }
        
        headerImageView.transform = CGAffineTransform.init(scaleX: scale, y: scale)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
