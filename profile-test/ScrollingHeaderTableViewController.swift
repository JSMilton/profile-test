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
    private var headerView = ScrollingHeaderView()
    private var scrollingNavigationBar = ScrollingHeaderNavigationBar()
    private var navigationBarHeightConstraint: NSLayoutConstraint!
    private var headerViewHeightConstraint: NSLayoutConstraint!
    
    private var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    private var navigationBarHeight: CGFloat {
        return navigationController?.navigationBar.frame.height ?? 0.0
    }
    
    weak private var headerHeightTrackingView: UIView?
    weak private var titleOffsetTrackingView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.addSubview(scrollingNavigationBar)
        
        headerView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .bottom)
        self.headerViewHeightConstraint = headerView.autoSetDimension(.height, toSize: 44)
        
        scrollingNavigationBar.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .bottom)
        navigationBarHeightConstraint = scrollingNavigationBar.autoSetDimension(.height, toSize: 44)
        
        tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .top)
        tableView.autoPinEdge(.top, to: .bottom, of: scrollingNavigationBar)
        
        scrollingNavigationBar.backgroundColor = .clear
        tableView.backgroundColor = .clear
        
        let refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        
        for v in refreshControl.subviews {
            v.removeFromSuperview()
        }
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    func handleRefresh(_ :UIRefreshControl) {
        headerView.loadingSpinner.startAnimating()
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
        navigationBarHeightConstraint.constant = navbarheight
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateHeaderHeight()
        updateTitleOffset()
    }
    
    func backButtonPressed() {
        fatalError("override in subclass")
    }
    
    func rightBarButtonPressed() {
        fatalError("override in subclass")
    }
    
    func tableViewOffsetDidChange() {
        
        updateHeaderHeight()
        updateTitleOffset()
        
        headerView.updateSpinner(tableView.contentOffset.y)
    }
    
    func setHeaderImageViewImage(_ image: UIImage?) {
        headerView.imageView.image = image
    }
    
    func setBackButtonHidden(_ isHidden: Bool) {
        scrollingNavigationBar.backButton.isHidden = isHidden
    }
    
    func setNavbarTitle(_ titleText: String?) {
        scrollingNavigationBar.titleLabel.text = titleText
    }
    
    func setRightBarButtonImage(image: UIImage?) {
        scrollingNavigationBar.rightButton.setImage(image, for: .normal)
    }
    
    func setHeaderHeightTrackingView(_ trackingView: UIView?) {
        headerHeightTrackingView = trackingView
    }
    
    func setTitleOffsetTrackingView(_ trackingView: UIView?) {
        titleOffsetTrackingView = trackingView
    }
    
    private func updateHeaderHeight() {
        let combinedBarHeight = navigationBarHeight+statusBarHeight
        
        if let heightTrackingView = headerHeightTrackingView {
            let offset = tableView.convert(heightTrackingView.frame.origin, to: nil).y
            headerViewHeightConstraint.constant = max(offset, combinedBarHeight)
        }
    }
    
    private func updateTitleOffset() {
        let combinedBarHeight = navigationBarHeight+statusBarHeight
        
        if let titleTrackingView = titleOffsetTrackingView {
            let offset = tableView.convert(titleTrackingView.frame.origin, to: nil).y
            let adjustedOffset = offset - combinedBarHeight
            scrollingNavigationBar.updateTitlePositionAndBackgroundAlpha(withOffset: adjustedOffset)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
