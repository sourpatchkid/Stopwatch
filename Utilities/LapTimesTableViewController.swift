//
//  LapTimesTableViewController.swift
//  Utilities
//
//  Created by Wyatt Allen on 12/15/17.
//  Copyright © 2017 Wyatt Allen. All rights reserved.
//

import UIKit

class LapTimesViewController: UIViewController{

    @IBOutlet weak var lapTimesView: UITableView!
    
    var lappedTimes: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lapTimesView.dataSource = self
    }

}

extension LapTimesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(lappedTimes.count)
        return lappedTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LapCell", for: indexPath) as! LapCell
        print(lappedTimes)
        cell.configure(time: lappedTimes[indexPath.item], number: indexPath.row)
        return cell
        
    }
    
}
