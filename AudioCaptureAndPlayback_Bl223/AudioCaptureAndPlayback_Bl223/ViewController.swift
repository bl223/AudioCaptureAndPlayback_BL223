//
//  ViewController.swift
//  AudioCaptureAndPlayback_Bl223
//
//  Created by BryceLigaya on 7/12/19.
//  Copyright © 2019 Bl223LabCPU. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, AVAudioRecorderDelegate {
    
    var recordAudio:AVAudioRecorder!
    var recordSession:AVAudioSession!
    var recordNum = 0
    
    @IBAction func RECORD(_ sender: Any) {
        if recordAudio == nil {
            recordNum += 1
            let filename = getDirectory().appendingPathComponent("\(recordNum).m4a")
            
            let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
            
            do {
                recordAudio = try AVAudioRecorder(url: filename, settings: settings)
                recordAudio.delegate = self
                recordAudio.record()
                
                buttonLabel.setTitle("Ceased", for: .normal)
            }
                
            catch {
                errorAlert(title: "FAILED", message: "ERROR, FAILED")
            }
            
        }
            
        else {
            recordAudio.stop()
            recordAudio = nil
            
            
            buttonLabel.setTitle("Recording...", for: .normal)
            
        }
        
        
    }
    @IBOutlet weak var buttonLabel: UIButton!
    
    @IBAction func Record(_ sender: Any) {
        if recordAudio == nil {
            recordNum += 1
            let filename = getDirectory().appendingPathComponent("\(recordNum).m4a")
            
            let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
            
            do {
                recordAudio = try AVAudioRecorder(url: filename, settings: settings)
                recordAudio.delegate = self
                recordAudio.record()
                
               buttonLabel.setTitle("Ceased", for: .normal)
            }
            
            catch {
                errorAlert(title: "FAILED", message: "ERROR, FAILED")
            }
            
        }
        
        else {
            recordAudio.stop()
            recordAudio = nil
            
            
            buttonLabel.setTitle("Recording...", for: .normal)
            
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        recordSession = AVAudioSession.sharedInstance()
        
        AVAudioSession.sharedInstance().requestRecordPermission { (PermissionGranted) in
            if PermissionGranted {
                print ("Permisson Granted")
            }
        }
        
    }
    func getDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
    
    //Error Alert
    
    func errorAlert(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    

}

