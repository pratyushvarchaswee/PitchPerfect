//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Pratyush Varchaswee on 9/10/15.
//  Copyright (c) 2015 Pratyush. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var recievedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer=try? AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl)
        audioPlayer.enableRate=true
        audioEngine=AVAudioEngine()
        audioFile = try? AVAudioFile(forReading: recievedAudio.filePathUrl)

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        playAudioCommon(1.50)
    }

    @IBAction func playSlowAudio(sender: UIButton) {
     playAudioCommon(0.50)
       
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        stopResetAudio()
        
    }
    @IBAction func playChipMunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopResetAudio()
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        do {
            try
                audioEngine.start()
        } catch _ {
        }
        
        audioPlayerNode.play()
    }
    
    func stopResetAudio()
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
    }
    
    func playAudioCommon(playRate:Float)
    {
        audioEngine.reset()
        audioPlayer.enableRate=true
        audioPlayer.currentTime=0.0
        audioPlayer.rate=playRate
        audioPlayer.play()
        
    }

    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
}
