//
//  RecordSoundViewController.swift
//  PitchPerfect
//RecordSoundViewController
//  Created by Pratyush Varchaswee on 9/8/15.
//  Copyright (c) 2015 Pratyush. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController,AVAudioRecorderDelegate {
    
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    

    @IBOutlet weak var recordLabel: UILabel!
    
    var recordedAudio:RecordedAudio!
    
    var audioRecorder: AVAudioRecorder!
    
        
    @IBAction func recordAudio(sender: UIButton) {
        
        recordLabel.text="recording..."
        recordButton.enabled=false
        stopButton.hidden=false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        var session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch _ {
        }
        audioRecorder = try? AVAudioRecorder(url: NSURL, settings: [String : AnyObject])
        audioRecorder.meteringEnabled = true
        audioRecorder.delegate=self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag)
        {
            recordedAudio=RecordedAudio(filePathUrl: recorder.url,title: recorder.url.lastPathComponent)
            performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else
        {
            print("Recording was not successful")
            recordButton.enabled=true
            stopButton.hidden=true
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="stopRecording")
        {
            let playSoundsVC:PlaySoundsViewController=segue.destinationViewController as! PlaySoundsViewController;
            let data=sender as! RecordedAudio
            
            playSoundsVC.recievedAudio=data
        }
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        
        recordLabel.text="Tap to record"
        recordButton.hidden=false
        stopButton.hidden=true
        recordButton.enabled=true
        
        
        audioRecorder.stop()
        let audioSession=AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch _ {
        }
        
    }
    
}

