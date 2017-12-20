//
//  ViewController.swift
//  MagicPorpoise
//
//  Created by Will Dailey on 11/29/17.
//  Copyright © 2017 Will Dailey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI

class PlaceListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let surfSpots = SurfSpots()
    var surfSpotsArray: [surfSpot]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSpots()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updateSpots() {
        if surfSpotsArray == nil {
            surfSpotsArray = surfSpots.getSpots()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickPlace" {
            let destination = segue.destination as! DateListViewController
            let selectedRow = tableView.indexPathForSelectedRow!.row
            destination.surfSpot = surfSpotsArray[selectedRow]
        }
    }
    
    @IBAction func unwindFromDate(segue: UIStoryboardSegue) {
        let source = segue.source as! DateListViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            for i in source.data! {
                self.surfSpotsArray[selectedIndexPath.row].dateData?.append(i)
            }
        }
    }
}
extension PlaceListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surfSpotsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = surfSpotsArray[indexPath.row].name
        return cell
    }
}


