//
//  Main.swift
//  Bubble_Pop_14123032_004
//
//  Created by George Hetrelezis on 17/04/21.
//

import Foundation
import UIKit

class Main: UIButton {
    
    //initialiser
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    //update the return value if you'd like to resize your bubbles
    var bubbleSize: Int {
        return Int(0.2 * UIScreen.main.bounds.width)
    }
    
    //ensures each bubble colour has a value reflecting the rules
    var points: Double = 0
    
    override init(frame : CGRect) {
        
        super.init(frame : frame)
        
        //adjust this if you prefer to reshape each object into squares and diamonds
        self.layer.cornerRadius = 25
        
        //do not adjust unless ratios are done correctly to match below switch statement
        var probability = Int(arc4random_uniform(100))
        
        //You ant radically increase how many points a colour can have or change the colour of bubbles or even add a new colour?
        //Well look no further
        switch probability {
            case 96...100:
                self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.points = 10
            case 86...95:
                self.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                self.points = 8
            case 71...85:
                self.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                self.points = 5
            case 40...70:
                self.backgroundColor = #colorLiteral(red: 0.863707602, green: 0, blue: 0.7458749413, alpha: 1)
                self.points = 2
            default:
                self.backgroundColor = #colorLiteral(red: 0.8107888103, green: 0, blue: 0, alpha: 1)
                self.points = 1
        }
    }
}
