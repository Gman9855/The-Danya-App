//
//  RecordSoundsViewController.swift
//  The Danya App
//
//  Created by Gershy Lev on 9/8/17.
//  Copyright © 2017 Gershy Lev. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var microphoneButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    var recordingSession: AVAudioSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordingSession = AVAudioSession.sharedInstance()
        self.navigationItem.titleView = CustomTitleLabel(text: "Voice Changer")

        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission({ (allowed: Bool) in
                DispatchQueue.main.async {
                    if allowed {
                    } else {
                        // failed to record!
                    }
                }
            })
        } catch {
            // failed to record!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        microphoneButton.isEnabled = true;
        recordingLabel.text = "Tap to record"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func recordAudio(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.recordingLabel.alpha = 0.0
            self.stopButton.alpha = 0.0
        }) { (Bool) -> Void in
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                self.recordingLabel.text = "Recording"
                self.recordingLabel.alpha = 1.0
                self.stopButton.alpha = 1.0
                self.stopButton.isHidden = false
            })
        }
        
        microphoneButton.isEnabled = false;
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        stopButton.isHidden = true;
        microphoneButton.isEnabled = true;
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch {
            //
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            recordedAudio = RecordedAudio(filePath: recorder.url, title: recorder.url.lastPathComponent)
            self.performSegue(withIdentifier: "stopRecording", sender: recordedAudio)
        } else {
            print("Recording was not successful")
            microphoneButton.isEnabled = true
            stopButton.isHidden = true
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC:PlaySoundsViewController = segue.destination as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }

}
