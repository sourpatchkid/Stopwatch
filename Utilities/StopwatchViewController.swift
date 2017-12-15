//
//  StopwatchViewController.swift
//  Utilities
//
//  Created by Wyatt Allen on 12/14/17.
//  Copyright © 2017 Wyatt Allen. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController {
    
    var timerMain: Timer?
    var timerTotal: Timer?
    // when the timer 1st start, set to 0.0 only on reset
    var startTotalTime = 0.0
    // each new lapped timer, set to 0.0 on reset and lap
    var startTime = 0.0
    // current time
    var currentTime = 0.0
    // total time elapsed
    var timeElapsed = 0.0
    var running: Bool = false
    var lappedTimes: [Double] = []
    let startButtonPic = #imageLiteral(resourceName: "StartButton")
    let stopButtonPic = #imageLiteral(resourceName: "StopButton")
    let resetButtonPic = #imageLiteral(resourceName: "ResetButton")
    let lapButtonPic = #imageLiteral(resourceName: "LapButton")

    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var millisecondsLabel: UILabel!
    @IBOutlet weak var totalMinutesLabel: UILabel!
    @IBOutlet weak var totalSecondsLabel: UILabel!
    @IBOutlet weak var totalMillisecondsLabel: UILabel!
    @IBOutlet weak var stopwatchStartButton: UIButton!
    @IBOutlet weak var stopwatchStopButton: UIButton!
    @IBOutlet weak var lapTimesButton: UIButton!

    
    @IBAction func stopwatchStartButton(_ sender: UIButton!) {
        timerMain?.invalidate()
        timerTotal?.invalidate()
        if running == false {
            sender.setImage(lapButtonPic, for: .normal)
            stopwatchStopButton.setImage(stopButtonPic, for: .normal)
            start()
        } else {
            stopwatchStopButton.setImage(stopButtonPic, for: .normal)
            lap() }
    }
    
    
    
    @IBAction func stopwatchStopButton(_ sender: UIButton!) {
        timerMain?.invalidate()
        timerTotal?.invalidate()
        if running == false {
            sender.setImage(stopButtonPic, for: .normal)
            stopwatchStartButton.setImage(startButtonPic, for: .normal)
            reset()
        } else {
            sender.setImage(resetButtonPic, for: .normal)
            stopwatchStartButton.setImage(startButtonPic, for: .normal)
            stop () }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if lapTimesButton == (sender as? UIButton){
            guard let destination = segue.destination as? LapTimesViewController else {return}
           destination.lappedTimes = lappedTimes
        }
    }
    
    
    @objc func incrementTime() {
        currentTime = Date().timeIntervalSinceReferenceDate - startTime
        let numSeconds = Int(currentTime) % 60
        let numMinutes = Int(currentTime / 60) % 60
        let numMilliseconds = Int(currentTime * 100) % 100
        minutesLabel.text = String(format: "%02d", numMinutes )
        secondsLabel.text = String(format: "%02d", numSeconds)
        millisecondsLabel.text = String(format: "%02d", numMilliseconds)
      
    }
    
    @objc func incrementTotalTime() {
        timeElapsed = Date().timeIntervalSinceReferenceDate - startTotalTime
        let numSeconds = Int(timeElapsed) % 60
        let numMinutes = Int(timeElapsed / 60) % 60
        let numMilliseconds = Int(timeElapsed * 100) % 100
        totalMinutesLabel.text = String(format: "%02d", numMinutes )
        totalSecondsLabel.text = String(format: "%02d", numSeconds)
        totalMillisecondsLabel.text = String(format: "%02d", numMilliseconds)
    }
    
    func start() {
        startTotalTime = Date().timeIntervalSinceReferenceDate - timeElapsed
        running = true
        startTime = Date().timeIntervalSinceReferenceDate - currentTime
        timerMain = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(incrementTime), userInfo: nil, repeats: true)
        timerTotal = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(incrementTotalTime), userInfo: nil, repeats: true)
    }
    
    func lap() {
        running = true
        lappedTimes.append(currentTime)
        currentTime = 0.0
        startTime = Date().timeIntervalSinceReferenceDate - currentTime
        timerMain = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(incrementTime), userInfo: nil, repeats: true)
        timerTotal = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(incrementTotalTime), userInfo: nil, repeats: true)
    }
    
    func stop() {
        running = false
    }
    
    func reset() {
        
        running = false
        
        currentTime = 0.0
        timeElapsed = 0.0
        lappedTimes = []
        
        let numSeconds = Int(currentTime) % 60
        let numMinutes = Int(currentTime / 60) % 60
        let numMilliseconds = Int(currentTime * 100) % 100
        minutesLabel.text = String(format: "%02d", numMinutes )
        secondsLabel.text = String(format: "%02d", numSeconds)
        millisecondsLabel.text = String(format: "%02d", numMilliseconds)
        totalMinutesLabel.text = String(format: "%02d", numMinutes )
        totalSecondsLabel.text = String(format: "%02d", numSeconds)
        totalMillisecondsLabel.text = String(format: "%02d", numMilliseconds)
    }
}



