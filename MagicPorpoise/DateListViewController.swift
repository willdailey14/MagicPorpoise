//
//  DateListViewController.swift
//  MagicPorpoise
//
//  Created by Will Dailey on 11/29/17.
//  Copyright © 2017 Will Dailey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI

class DateListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var defaultsData = UserDefaults.standard
    var surfSpot: surfSpot!
    var data: [DateData]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = surfSpot.dateData
        if data == nil {
            data = []
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditDate" {
            let destination = segue.destination as! DetailViewController
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                destination.dateData = self.data![selectedIndexPath.row]
            }
            destination.surfSpot = surfSpot
        }
        if segue.identifier == "AddDate" {
            let destination = segue.destination as! UINavigationController
            let detailVC = destination.topViewController as! DetailViewController
            detailVC.surfSpot = self.surfSpot
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }

    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
    let source = segue.source as! DetailViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
//            let newIndexPath = IndexPath(row: 0, section: 0)
            source.dateData.inputField = source.inputField.text!
            data!.append(source.dateData)
            tableView.reloadData()
//            tableView.insertRows(at: [newIndexPath], with: .automatic)
//            tableView.scrollToRow(at: newIndexPath, at: .top, animated: true)
//            tableView.reloadRows(at: [newIndexPath], with: .automatic)
        }
    }
}
extension DateListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = data![indexPath.row].date
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

