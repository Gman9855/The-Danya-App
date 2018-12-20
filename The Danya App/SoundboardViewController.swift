//
//  SoundboardViewController.swift
//  The Danya App
//
//  Created by Gershy Lev on 9/10/17.
//  Copyright © 2017 Gershy Lev. All rights reserved.
//

import UIKit
import AVFoundation

class SoundboardViewController: UIViewController, CAAnimationDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet var buttonCollection: [UIButton]!
    var soundClipNames: [String] {
        return ["Danya1", "Danya2", "Danya3", "Danya4", "Danya5", "Danya6", "Danya7", "Danya8", "Danya9"]
    }
    var audioPlayer: AVAudioPlayer!
    var currentlyPlayingButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = CustomTitleLabel(text: "Soundboard")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playSoundClip(forButton button: UIButton) {
        if let audioPlayer = audioPlayer, audioPlayer.isPlaying {
            audioPlayer.stop()
            currentlyPlayingButton.layer.removeAllAnimations()
        }
        if let soundURL = Bundle.main.url(forResource: soundClipNames[button.tag], withExtension: "mp3") {
            let asset = AVURLAsset(url: soundURL)
            let audioDuration = asset.duration
            let audioDurationSeconds = CMTimeGetSeconds(audioDuration)
            let animationGroup = CAAnimationGroup()
            animationGroup.duration = audioDurationSeconds
            animationGroup.repeatCount = .infinity
            animationGroup.beginTime = CACurrentMediaTime() + 3
            
            let fullRotation = CABasicAnimation(keyPath: "transform.rotation")
            fullRotation.delegate = self
            fullRotation.fromValue = NSNumber(floatLiteral: 0)
            fullRotation.toValue = NSNumber(floatLiteral: 0.5)
            fullRotation.duration = 0.3
            fullRotation.repeatCount = .infinity
            fullRotation.repeatDuration = audioDurationSeconds
            fullRotation.autoreverses = true
            animationGroup.animations = [fullRotation]
            button.layer.add(fullRotation, forKey: "360")
            
            currentlyPlayingButton = button
            
            let audioSession = AVAudioSession.sharedInstance()
            
            do {
                try audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
            } catch let error as NSError {
                print("audioSession error: \(error.localizedDescription)")
            }
            
            try? audioPlayer = AVAudioPlayer(contentsOf: soundURL)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        playSoundClip(forButton: sender)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //currentlyPlayingButton.layer.removeAllAnimations()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
