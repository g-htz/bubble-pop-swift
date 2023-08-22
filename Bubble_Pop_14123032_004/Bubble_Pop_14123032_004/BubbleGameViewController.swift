//
//  BubbleGameViewController.swift
//  Bubble_Pop_14123032_004
//
//  Created by George Hetrelezis on 1/5/21.
//

import AVFoundation
import UIKit


class BubbleGameViewController: UIViewController {
    
    //Values change depending on the user's score and the time left in game
    //Time will be higher or lower depending on the slider on the previous screen
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var userTime: UILabel!
    
    //Variables ensure that the bubble's properties are called and recongised when the controller is activated
    var callToMain = Main()
    var bubbleCount = 15
    var bubbleStreak:Double = 0
    var visibleBubbles = [Main]()
    
    //Constraint to ensure game has a fully functional clock and a call to the Timer class
    //Please see https://developer.apple.com/documentation/foundation/timer for more information
    var countdownTimer = 60
    var gameTimer: Timer?
    
    //The game would not be as fun if the game did not save your name and score
    var player: String = ""
    var playerScore: Double = 0
    
    //Scores will not save unless the following lines are kept.
    //Pairs must be left as String + anything with a floating point to capture the 1.5x multiplier in game
    var determineScores: Dictionary? = [String : Double]()
    var highScores = [(key: String, value: Double)]()
    
    //These variables ensure that you're able to have a static value for the user's device's width and height
    //This should not be removed or responsive widths will not function as intended
    var phoneY: UInt32 {
        return UInt32(UIScreen.main.bounds.height)
    }
    var phoneX: UInt32 {
        return UInt32(UIScreen.main.bounds.width)
    }
    
    //creating a temporary value in the event determineScores! finds nil
    var temp = [String: Double]()
    
    
    
    //automatically generated function which runs core Controller methods
    override func viewDidLoad() {
        //accessing super class member
        super.viewDidLoad()
        
        //Pulls values according to the linked forKey
        determineScores = UserDefaults.standard.dictionary(forKey: "leaderboardScore") as?
            Dictionary<String, Double>
        
        if determineScores != nil {
            temp = determineScores!
            
            //Scoreboard will remain empty if forKey leaderboardScores is empty
//          //Scoreboard can be re-filtered if values inbetween brackets are updated
            highScores = temp.sorted(by: {$0.value > $1.value})
        }
        
        //Any new functions for future features should be added here
        //Main incremental functions happen here
        //decrease value following "withTimeInterval" to increase game speed. Default is 1
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.countdownClock()
            self.disappear()
            self.newBubble()
        }
    }
    
    //This function will ensure that the user's score will be added to the area in which the scores are kept
    //Hopefully their score is high enough!!!
    //Change the "listScore" string on this page and in both positions in ScoresViewController.swift to reset the scoreboard!!!
    func addToLeaderboard() {
        temp.updateValue(playerScore, forKey: "\(player)")
        UserDefaults.standard.set(temp, forKey: "leaderboardScore")
    }
    
    //Self explanatory and counts down until game has finished as function is repeating in viewDidLoad()
    func countdownClock() {
        let endGame = self.storyboard?.instantiateViewController(withIdentifier: "ScoresViewController") as! ScoresViewController
        
        //updates clock in game's UI
        userTime.text = "\(countdownTimer)"
        if(countdownTimer < 1) {
            gameTimer?.invalidate()
            leaderboard()
            
            //change animated to true if desired, as present() function requires a boolean value
            present(endGame, animated: false )
        }
        
        //incremental value as function is called as game increments
        countdownTimer -= 1
    }
    
    
    //This function will activate when a bubble has been clicked on
    //Classified as "Interface Builder Action" as function is triggered by #selector in newBubble()
    @IBAction func click(_ sender: Main) {
        //ensures that bubble does not stay in the user's view once clicked
        sender.removeFromSuperview()
        
        //adjust multiplier if you wish all scores to have exponentially higher values! eg Black bubble = 1000 points
        let multiplier = 1.0
        
        //guarantees that users can receive the full points bonus from following the rules
        if bubbleStreak == sender.points {
            
            playerScore += sender.points * 1.5
        }
        
        else {
            playerScore += (sender.points * multiplier)
        }
        bubbleStreak = sender.points
        
        //Ensures that label containing score is updated with each point increase
        score.text = "\(playerScore)"
        
    }
    
    
    //function is called in viewDidLoad() to ensure bubbles disappear as planned as per core functionality 9.
    func disappear() {
        var counter = 0
        
        //value is arbitrarily set at 45. Value can be lowered to make game easier
        var difficulty = 45
        
        //Bubbles will stay instead of vanishing regularly unless below lines are kept
        while counter < visibleBubbles.count {
            if arc4random_uniform(100) < difficulty {
                visibleBubbles[counter].removeFromSuperview()
                visibleBubbles.remove(at: counter)
                counter += 1
            }
        }
    }
    
    //Self explanatory and ensures that user scores are added to the leaderboard only in instances that follow the game's rules
    func leaderboard() {
        //A users's score will automatically be added to an empty leaderboard
        if determineScores != nil {
            temp = determineScores!
            
            //Is the user already on the leaderboard?
            if temp.keys.contains("\(player)") {
                let score = temp["\(player)"]!
                if score < playerScore {
                    addToLeaderboard()
                }
            //Lets add them regardless
            } else {
                addToLeaderboard()
            }
        } else  {
            addToLeaderboard()
        }
    }
    
    //New bubbles are created by this eponymous function
    func newBubble() {
        let assortment = arc4random_uniform(UInt32(Int(bubbleCount - visibleBubbles.count)))
        var counter = 0
        
        while counter < assortment {
            
            //modify this if you wish to make the bubbles appear higher an lower. You may even chose to split the 2 positions it is called at
            let yConstant = 72
            
            //modify this if you wish to make the bubbles larger. Do this at your own risk as more bubbles could cause a crash in combination with stackPrevention()
            let multiplier = 0.65
            callToMain = Main()
            
            //x: randomly places new bubble at a point on the x axis
            //y: randomly places new bubble at a point with x on the y axis
            //height: how tall will the new bubble be?
            //width: how wide will the new bubble be?
            callToMain.frame = CGRect(x: (Int(arc4random_uniform(phoneX - UInt32(callToMain.bubbleSize)))),
                                      y: yConstant + Int(arc4random_uniform(phoneY - UInt32(callToMain.bubbleSize) - UInt32(yConstant))),
                                      width: Int(Double(callToMain.bubbleSize) * multiplier),
                                      height: Int(Double(callToMain.bubbleSize) * multiplier))
            
            //new bubbles can only be created if stackPrevention() approves the newBubble
            if !stackPrevention(newBubble: callToMain) {
                
                //Ensures that target object is associated with the click IBAction function
                //See https://developer.apple.com/documentation/uikit/uicontrol/1618259-addtarget for more information
                callToMain.addTarget(self, action: #selector(click), for: UIControl.Event.touchUpInside)
                
                //adds the bubbles to the window and tracks how many bubbles are on screen
                self.view.addSubview(callToMain)
                counter += 1
                
                visibleBubbles += [callToMain]
                
            }
        }
    }
    
    //boolean function will return false unless newBubble is on top of a previous bubble (breaking a core functionality)
    func stackPrevention(newBubble: Main) -> Bool {
        for stackCheck in visibleBubbles {
            //bubbles are unlikely to intersect unless bubble size is increased too large
            if newBubble.frame.intersects(stackCheck.frame) {
                return true
            }
        }
        return false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
