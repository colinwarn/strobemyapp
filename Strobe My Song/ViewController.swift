//
//  ViewController.swift
//  Strobe My Song
//
//  Created by Colin Warn on 6/1/17.
//  Copyright © 2017 Colin Warn. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    var recorder = AVAudioRecorder()
    
    @IBOutlet weak var isMusicPlaying: UILabel!
    
    var timer: Timer!
    var songBPM = 0.1
    
    
    
    func setRandomBackgroundColor() {
        let colors = [
            UIColor.red,
            UIColor.blue,
            UIColor.green,
            UIColor.yellow,
            UIColor.white
            
        ]
        let randomColor = Int(arc4random_uniform(UInt32 (colors.count)))
        self.view.backgroundColor = colors[randomColor]
        
        let decibels = recorder.averagePower(forChannel: 0)
        self.view.alpha = CGFloat(decibels)
        
        
        
    }
    func init_recorder() -> Void
    {
        let recordersettings = [
            AVFormatIDKey: Int(kAudioFormatAppleIMA4),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVLinearPCMBitDepthKey: 16,
            AVLinearPCMIsFloatKey: false,
            AVLinearPCMIsBigEndianKey: false,
            ] as [String : Any]
        
        let filename = URL(fileURLWithPath: NSTemporaryDirectory())
        
        
        
        do
        {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
            try session.setActive(true)
            //Bad path here?
            recorder = try AVAudioRecorder(url: filename, settings: recordersettings)
            recorder.isMeteringEnabled = true
            recorder.prepareToRecord()
            recorder.record()
            recorder.updateMeters()
            
            
            
            
            
        }
        catch
        {
            print("error")
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        init_recorder()
        
        
        
        //Setup EQ
//        eq.bands[0].filterType = .lowPass
//        eq.bands[0].frequency = 200
//        
        timer = Timer.scheduledTimer(timeInterval: songBPM, target: self, selector: #selector(ViewController.setRandomBackgroundColor), userInfo: nil, repeats: true)
        self.setRandomBackgroundColor()
        
        
        
     
        
    }
    
    
    
    
    
}

