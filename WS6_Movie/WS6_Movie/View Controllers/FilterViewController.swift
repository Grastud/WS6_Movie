//
//  FilterViewController.swift
//  WS6_Movie
//
//  Created by Anastasiia Graftceva on 22.04.19.
//  Copyright © 2019 AnastasiaAlina. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    internal var flags = [Bool]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 50
        
        (0..<40).map { _ in flags.append(true) }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}


extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return flags.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as! FilterCell
    //cell.onOffSwitch.isOn = true
    //tableView.indexPath(for: cell)
    flags[indexPath.row] = !flags[indexPath.row]
    cell.propertyLabel.text = "Row \(indexPath.row)"
    cell.onOffSwitch.isOn = flags[indexPath.row]
    return cell
    
    }
}
