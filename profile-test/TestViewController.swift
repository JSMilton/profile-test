//
//  TestViewController.swift
//  profile-test
//
//  Created by James Milton on 28/09/2016.
//  Copyright © 2016 James Milton. All rights reserved.
//

import UIKit

class TestViewController: ScrollingHeaderTableViewController {
    
    var selectedTab = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        setHeaderImageViewImage(UIImage(named: "bill-gates"))
        setNavbarTitle("Awesome title")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if tableView.tableHeaderView == nil {
            let v = TestHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
            tableView.tableHeaderView = v
            
            setHeaderHeightTrackingView(v.label)
            setTitleOffsetTrackingView(v.label)
        }
    }
    
    override func rightBarButtonPressed() {
        selectedTab = !selectedTab
        tableView.reloadData()
    }

}

extension TestViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableViewOffsetDidChange()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .blue
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}

extension TestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedTab ? 30 : 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Some awesome cell"
        return cell
    }
}
