//
//  ViewController.swift
//  FinalTimer
//
//  Created by Cindy Chen on 7/1/21.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startStopButton.setTitleColor(UIColor.blue, for: .normal)
    }
      
    @IBAction func resetTapped(_ sender: Any)
    {
        let alert = UIAlertController(title: "RESET TIMER?" , message: "ARE YOU SURE YOU WOULD LIKE TO RESET TIMER?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel , handler: {(_) in
            // do nothing
        }))
        alert.addAction(UIAlertAction(title: "YES", style: .default , handler: {(_) in
            self.count = 0
            self.timer.invalidate()
            self.TimerLabel.text = self.makeTimeString(hours: 0, mintutes: 0, seconds: 0)
            self.startStopButton.setTitle("START", for: .normal)
            self.startStopButton.setTitleColor(UIColor.blue, for: .normal)
        }))
        self.present(alert, animated:true, completion: nil)
    }
        
        @objc func startStopTapped(_ sender: Any)
        {
        if(timerCounting)
        {
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("START", for: .normal)
            startStopButton.setTitleColor(UIColor.blue, for: .normal)
        }
        else
        {
            timerCounting = true
            startStopButton.setTitle("STOP", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter() -> Void
    {
        count = count + 1
        let time = secondsToHoursMintesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0 , mintutes: time.1 , seconds: time.2)
        TimerLabel.text = timeString
    
    }

    func secondsToHoursMintesSeconds(seconds: Int) -> (Int,Int,Int)
    {
        return ((seconds / 3600, (seconds % 3600)/60, (seconds % 3600) % 60))
    }

    func makeTimeString(hours:Int, mintutes: Int, seconds : Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", mintutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}


