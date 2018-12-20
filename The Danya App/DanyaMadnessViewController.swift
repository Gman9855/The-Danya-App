//
//  DanyaMadnessViewController.swift
//  The Danya App
//
//  Created by Gershy Lev on 9/14/17.
//  Copyright © 2017 Gershy Lev. All rights reserved.
//

import UIKit

class DanyaMadnessViewController: UIViewController {
    
    let emitterPositions: [CGPoint] = [CGPoint(x: UIScreen.main.bounds.width / 2, y: -50), CGPoint(x: -50, y: UIScreen.main.bounds.height / 2), CGPoint(x: UIScreen.main.bounds.width + 50, y: UIScreen.main.bounds.height / 2), CGPoint(x: UIScreen.main.bounds.width + 50, y: UIScreen.main.bounds.height / 2)]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        let randomIndex = (0...emitterPositions.count - 1).random
        createParticles(emitterPosition: emitterPositions[randomIndex])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createParticles(emitterPosition: CGPoint) {
        let cloud = CAEmitterLayer()
        cloud.emitterPosition = emitterPosition//CGPoint(x: view.center.x, y: -50)
        cloud.emitterShape = kCAEmitterLayerLine
        cloud.emitterSize = CGSize(width: view.frame.size.width, height: 1)
        
        let flake = makeEmitterCell()
        cloud.emitterCells = [flake]
        
        view.layer.addSublayer(cloud)
    }
    
    func makeEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contentsScale = 8
        cell.birthRate = 1
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CountableRange where Bound: Strideable, Bound == Int {
    var random: Int {
        return lowerBound + Int(arc4random_uniform(UInt32(count)))
    }
    func random(_ n: Int) -> [Int] {
        return (0..<n).map { _ in random }
    }
}
extension CountableClosedRange where Bound: Strideable, Bound == Int {
    var random: Int {
        return lowerBound + Int(arc4random_uniform(UInt32(count)))
    }
    func random(_ n: Int) -> [Int] {
        return (0..<n).map { _ in random }
    }
}
