//
//  TestViewController.swift
//  profile-test
//
//  Created by James Milton on 28/09/2016.
//  Copyright © 2016 James Milton. All rights reserved.
//

import UIKit

class TestViewController: ScrollingHeaderTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        setHeaderImageViewImage(UIImage(named: "bill-gates"))
        setNavbarTitle("Awesome title")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if tableView.tableHeaderView == nil {
            tableView.tableHeaderView = TestHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
            setTitleAppearanceContentOffset(50)
        }
    }

}

extension TestViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableViewOffsetDidChange()
    }
}

extension TestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Some awesome cell"
        return cell
    }
}
