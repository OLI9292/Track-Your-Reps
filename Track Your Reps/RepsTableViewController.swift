//
//  TableViewController.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/4/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import UIKit

class RepsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(RepTableViewCell.self, forCellReuseIdentifier: RepTableViewCell.reuseID)
    }
    
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repSummaryVC = RepSummaryViewController()
        self.navigationController?.pushViewController(repSummaryVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repcell", for: indexPath) as! RepTableViewCell
        //cell.repImage.image = #imageLiteral(resourceName: "kirsten_gillibrand")
        cell.repImage.image = #imageLiteral(resourceName: "kirsten_gillibrand")
        cell.repNameLabel.text = "Rep Name"
        cell.repContactLabel.text = "Phone // Twitter "
        return cell
    }
    
    
}
