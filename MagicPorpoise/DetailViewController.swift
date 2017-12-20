//
//  DetailViewController.swift
//  MagicPorpoise
//
//  Created by Will Dailey on 11/29/17.
//  Copyright © 2017 Will Dailey. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var waveHeightLabel: UILabel!
    @IBOutlet weak var swellDirectionsLabel: UILabel!
    @IBOutlet weak var windSpeedDirectionLabel: UILabel!
    @IBOutlet weak var airTempLabel: UILabel!
    @IBOutlet weak var inputField: UITextView!

    var currentDate: String!
    var currentTime: String!
    
    var surfSpot: surfSpot!
    var dateDetail = DateDetail()
    var dateData: DateData!
    var callAPI: Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if dateData == nil {
            dateDetail.getData(surfSpot.spotID, completed: { (data) in
                self.dateData = data
                self.loadUserInterface(dateData: data)
            })
        } else {
            self.loadUserInterface(dateData: dateData!)
        }
        
        inputField.becomeFirstResponder()
    
    }
    
    func loadUserInterface(dateData: DateData) {
        dateLabel.text = dateData.date
        timeLabel.text = dateData.time
        conditionsLabel.text = "\(dateData.solidRating!), \(dateData.fadedRating!) s/f"
        waveHeightLabel.text = "\(dateData.minWaveHeight!) - \(dateData.maxWaveHeight!) ft."
        swellDirectionsLabel.text = "\(dateData.swellDirection!), \(dateData.swellPeriod!) s"
        windSpeedDirectionLabel.text = "\(dateData.windSpeed!) mph, \(dateData.windDirection!)"
        airTempLabel.text = "\(dateData.airTemp!) °F"
        inputField.text = dateData.inputField
    }

   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindFromDetail" {
            dateData.inputField = inputField.text
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func dismissInputField(_ sender: UISwipeGestureRecognizer) {
        inputField.resignFirstResponder()
    }
    
}

