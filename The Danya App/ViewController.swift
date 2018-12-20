//
//  ViewController.swift
//  The Danya App
//
//  Created by Gershy Lev on 9/8/17.
//  Copyright © 2017 Gershy Lev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {

    @IBOutlet weak var voiceChangerButton: UIButton!
    @IBOutlet weak var soundboardButton: UIButton!
    @IBOutlet weak var danyaImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createParticles()
        
        self.navigationItem.titleView = CustomTitleLabel(text: "The Danya App")
        let buttons: [UIButton] = [voiceChangerButton, soundboardButton]
        for button in buttons {
            button.layer.cornerRadius = 8
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 2
            button.layer.masksToBounds = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rotateDanyaImageView()
    }
    
    private func rotateDanyaImageView() {
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 7;
        animationGroup.repeatCount = .infinity
        animationGroup.beginTime = CACurrentMediaTime() + 3
        
        let fullRotation = CABasicAnimation(keyPath: "transform.rotation")
        fullRotation.delegate = self
        fullRotation.fromValue = NSNumber(floatLiteral: 0)
        fullRotation.toValue = NSNumber(floatLiteral: Double(CGFloat.pi * 2))
        fullRotation.duration = 0.6
        
        animationGroup.animations = [fullRotation]
        danyaImageView.layer.add(animationGroup, forKey: "360")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createParticles() {
        let cloud = CAEmitterLayer()
        cloud.emitterPosition = CGPoint(x: view.center.x, y: -50)
        cloud.emitterShape = kCAEmitterLayerLine
        cloud.emitterSize = CGSize(width: view.frame.size.width, height: 1)
    
        let flake = makeEmitterCell()
        cloud.emitterCells = [flake]
    
        view.layer.addSublayer(cloud)
    }
    
    func makeEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contentsScale = 8
        cell.birthRate = 0.35
        cell.lifetime = 50.0
        cell.velocity = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 0.5
        cell.spinRange = 1.2
        cell.scaleRange = -0.05
        cell.contents = UIImage(named: "Face_small")?.cgImage
            
        return cell
    }
}

