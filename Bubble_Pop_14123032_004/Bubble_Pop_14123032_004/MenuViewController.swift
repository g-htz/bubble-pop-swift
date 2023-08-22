//
//  GameViewController.swift
//  Bubble_Pop_14123032_004
//
//  Created by George Hetrelezis on 17/04/21.
//

import UIKit
import SpriteKit
import GameplayKit

class MenuViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var playerTF: UITextField!
    @IBOutlet weak var barBubbles: UILabel!
    @IBOutlet weak var barTimer: UILabel!
    
    var timer = 60
    var bubbleNumber = 15
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerTF.delegate = self
    }
    
    
    //We are using an overriding declaration so this function requires the "override" keyword
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Begin" {
            let screen = segue.destination as! BubbleGameViewController
            
            //these guarantee that the final values on the slider update the game's timer and bubble count
            screen.countdownTimer = bubbleNumber
            screen.bubbleCount = timer
            
            //this ensures that the player's name will show up on the high score list
            screen.player = playerTF.text!
        }
    }
    
    //Xcode luckily lets both menu sliders apply to this function. The if statements are connected to the tags on each UI slider and ensures that the corresponding sliders change
    //the in game settings
    @IBAction func barValues(_ sender: UISlider) {
        if sender.tag == 300 {
            timer = Int(sender.value)
            barTimer.text = "\(timer)"
        }
        
        if sender.tag == 600 {
            bubbleNumber = Int(sender.value)
            barBubbles.text = "\(bubbleNumber)"
        }
    }
}
