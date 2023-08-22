//
//  ScoresViewController.swift
//  Bubble_Pop_14123032_004
//
//  Created by George Hetrelezis on 1/5/21.
//

import UIKit

class ScoresViewController: UIViewController {
    
    //Linked scoreboard weak variables for first place
    @IBOutlet weak var firstPlace: UILabel!
    @IBOutlet weak var firstScore: UILabel!
    
    //Linked scoreboard weak variables for second place
    @IBOutlet weak var secondPlace: UILabel!
    @IBOutlet weak var secondScore: UILabel!
    
    //Linked scoreboard weak variables for third place
    @IBOutlet weak var thirdPlace: UILabel!
    @IBOutlet weak var thirdScore: UILabel!
    
    //Linked scoreboard weak variables for fourth place
    @IBOutlet weak var fourthPlace: UILabel!
    @IBOutlet weak var fourthScore: UILabel!
    
    //created to contain every player since the last forKey update and a spare which is later filled and sorted
    var topAchievers = [String : Double]()
    var rankings = [(key: String, value: Double)]()
    
    
    
    override func viewDidLoad() {
        //accessing super class member
        super.viewDidLoad()
        
        //
        if let topAchievers = UserDefaults.standard.dictionary(forKey: "leaderboardScore")
            as! [String: Double]? {
                rankings = topAchievers.sorted(by: {$0.value > $1.value})
            
            //If statements can be copy + pasted to increase number of people on leaderboard
                //Shows the score if there are 4+ people on leaderboard
            if rankings.count > 3 {
                firstPlace.text = rankings[0].key
                firstScore.text = "\(rankings[0].value)"
                secondPlace.text = rankings[1].key
                secondScore.text = "\(rankings[1].value)"
                thirdPlace.text = rankings[2].key
                thirdScore.text = "\(rankings[2].value)"
                fourthPlace.text = rankings[3].key
                fourthScore.text = "\(rankings[3].value)"
                
                //Shows the score if there are 3 people on leaderboard
            } else if rankings.count == 3 {
                firstPlace.text = rankings[0].key
                firstScore.text = "\(rankings[0].value)"
                secondPlace.text = rankings[1].key
                secondScore.text = "\(rankings[1].value)"
                thirdPlace.text = rankings[2].key
                thirdScore.text = "\(rankings[2].value)"
                
                //Shows the score if there are 2 people on leaderboard
            } else if rankings.count == 2 {
                firstPlace.text = rankings[0].key
                firstScore.text = "\(rankings[0].value)"
                secondPlace.text = rankings[1].key
                secondScore.text = "\(rankings[1].value)"
                
                //Shows the score if there is only one person on leaderboard
            } else if rankings.count == 1 {
                firstPlace.text = rankings[0].key
                firstScore.text = "\(rankings[0].value)"
                
                //leaderboard may be empty
            } else {
                firstPlace.text = "Beat your friends"
                firstScore.text = "!"
                }
        }
            
            
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
