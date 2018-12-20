//
//  PlaySoundsViewController.swift
//  The Danya App
//
//  Created by Gershy Lev on 9/8/17.
//  Copyright © 2017 Gershy Lev. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var receivedAudio: RecordedAudio!
    var player:AVAudioPlayer!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = CustomTitleLabel(text: "Voice Changer")

        audioEngine = AVAudioEngine()
        do {
            try audioFile = AVAudioFile(forReading: receivedAudio.filePathURL)
        } catch {
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            try player = AVAudioPlayer(contentsOf: receivedAudio.filePathURL!)
        } catch {
        }
        //AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: nil)
        player.enableRate = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func snailButtonTapped(_ sender: UIButton) {
        stopAndResetAudioEngine()
        playAudioWithRate(rate: 0.5)
    }
    
    
    @IBAction func rabbitButtonTapped(_ sender: UIButton) {
        stopAndResetAudioEngine()
        playAudioWithRate(rate: 2.0)
    }
    
    @IBAction func chipmunkButtonTapped(_ sender: UIButton) {
        playAudioWithVariablePitch(pitch: 1000)
    }
    
    @IBAction func darthVaderButtonTapped(_ sender: UIButton) {
        playAudioWithVariablePitch(pitch: -1000)
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        if player.isPlaying {
            player.stop()
        }
        if audioEngine.isRunning {
            audioEngine.stop()
        }
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        player.stop()
        stopAndResetAudioEngine()
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attach(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attach(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
        try? audioEngine.start()
        audioPlayerNode.play()
    }
    
    func playAudioWithRate(rate: Float) {
        player.stop()
        player.rate = rate
        player.currentTime = 0.0
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        player.play()
    }
    
    func stopAndResetAudioEngine() {
        audioEngine.stop()
        audioEngine.reset()
    }
}
