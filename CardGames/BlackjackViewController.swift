//
//  BlackjackViewController.swift
//  CardGames
//
//  Created by Dante  Lacey-Thompson on 9/8/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import UIKit

class BlackjackViewController : UIViewController {
    
    @IBOutlet var hitButton: UIButton!
    @IBOutlet var stand2Button: UIButton!
    @IBOutlet var surrenderButton: UIButton!
    @IBOutlet var playerScoreLabel: UILabel!
    @IBOutlet var dealerScoreLabel: UILabel!
    @IBOutlet var playerCards: UIImageView!
    @IBOutlet var dealerCards: UIImageView!
    
    var cardsPlayed: [String] = []
    var deckOfCards: [String] = []
    var playableCards: [String] = []
    var dealersCards: [String] = []
    var playersCards: [String] = []
    
    var playerScore: Int = 0
    var dealerScore: Int = 0
    
    let wantedScore: Int = 21
    
    let alert = UIAlertController(title: "Ace Card", message: "Select the value for your Ace card.", preferredStyle: .alert)
    let winAlert = UIAlertController(title: "Winner", message: "Thank you for playing and congratulations on your win.", preferredStyle: .alert)
    let loseAlert = UIAlertController(title: "You have Lost", message: "Sorry, better luck next time.", preferredStyle: .alert)
    let drawAlert = UIAlertController(title: "You have Tied", message: "Try again or play some other time.", preferredStyle: .alert)

    
    func gamestart(){
        deckOfCards = Deck.shared.cards
        for _ in 1...2{
            getCardPlayer()
        }
        while dealerScore < 17 {
            getCardDealer()
        }
        if playerScore == 21 {
            present(winAlert, animated: true, completion: nil)
        }
        if dealerScore == 21 && playerScore != 21 {
            present(loseAlert, animated: true, completion: nil)
        }
    }
    
    // Need to reset all values if they click replay, can't reload view controller. So reset all data and call gamestart again
    func gameReset(){
        playerScore = 0
        dealerScore = 0
        cardsPlayed.removeAll()
        deckOfCards.removeAll()
        playableCards.removeAll()
        gamestart()
    }
    
    func getCardDealer() {
        if cardsPlayed.isEmpty {
            let randomIndex = Int(arc4random_uniform(UInt32(deckOfCards.count)))
            print(randomIndex)
            print(deckOfCards[randomIndex])
            cardsPlayed.append(deckOfCards[randomIndex])
            dealerCards.image = UIImage(named: deckOfCards[randomIndex])
            if deckOfCards[randomIndex].hasPrefix("2") {
                dealerScore = 2
            }
            else if deckOfCards[randomIndex].hasPrefix("3") {
                dealerScore = 3
            }
            else if deckOfCards[randomIndex].hasPrefix("4") {
                dealerScore = 4
            }
            else if deckOfCards[randomIndex].hasPrefix("5") {
                dealerScore = 5
            }
            else if deckOfCards[randomIndex].hasPrefix("6") {
                dealerScore = 6
            }
            else if deckOfCards[randomIndex].hasPrefix("7") {
                dealerScore = 7
            }
            else if deckOfCards[randomIndex].hasPrefix("8") {
                dealerScore = 8
            }
            else if deckOfCards[randomIndex].hasPrefix("9") {
                dealerScore = 9
            }else if deckOfCards[randomIndex].hasPrefix("10") {
                dealerScore = 10
            }
            else if deckOfCards[randomIndex].hasPrefix("ace") {
                print("Found Ace")
                dealerScore = 11
            }
            else if deckOfCards[randomIndex].hasPrefix("jack") {
                dealerScore = 10
            }
            else if deckOfCards[randomIndex].hasPrefix("queen") {
                dealerScore = 10
            }
            else if deckOfCards[randomIndex].hasPrefix("king") {
                dealerScore = 10
            }
        } else {
            print("Cards have been played")
            playableCards = Array(Set(deckOfCards).subtracting(cardsPlayed))
            print(playableCards)
            let rndmIndex = Int(arc4random_uniform(UInt32(playableCards.count)))
            print(rndmIndex)
            print(playableCards[rndmIndex])
            cardsPlayed.append(playableCards[rndmIndex])
            dealerCards.image = UIImage(named: playableCards[rndmIndex])
            if playableCards[rndmIndex].hasPrefix("2") {
                dealerScore += 2
            }
            else if playableCards[rndmIndex].hasPrefix("3") {
                dealerScore += 3
            }
            else if playableCards[rndmIndex].hasPrefix("4") {
                dealerScore += 4
            }
            else if playableCards[rndmIndex].hasPrefix("5") {
                dealerScore += 5
            }
            else if playableCards[rndmIndex].hasPrefix("6") {
                dealerScore += 6
            }
            else if playableCards[rndmIndex].hasPrefix("7") {
                dealerScore += 7
            }
            else if playableCards[rndmIndex].hasPrefix("8") {
                dealerScore += 8
            }
            else if playableCards[rndmIndex].hasPrefix("9") {
                dealerScore += 9
            }else if playableCards[rndmIndex].hasPrefix("10") {
                dealerScore += 10
            }
            else if playableCards[rndmIndex].hasPrefix("ace") {
                print("Found Ace")
                if dealerScore > 11 {
                    dealerScore += 1
                } else {
                    dealerScore += 11
                }
            }
            else if playableCards[rndmIndex].hasPrefix("jack") {
                dealerScore += 10
            }
            else if playableCards[rndmIndex].hasPrefix("queen") {
                dealerScore += 10
            }
            else if playableCards[rndmIndex].hasPrefix("king") {
                dealerScore += 10
            }
        }
        dealerScoreLabel.text = String(dealerScore)
    }
    
    func getCardPlayer() {
        if cardsPlayed.isEmpty {
            let randomIndex = Int(arc4random_uniform(UInt32(deckOfCards.count)))
            print(randomIndex)
            print(deckOfCards[randomIndex])
            cardsPlayed.append(deckOfCards[randomIndex])
            playerCards.image = UIImage(named: deckOfCards[randomIndex])
            if deckOfCards[randomIndex].hasPrefix("2") {
                playerScore = 2
            }
            else if deckOfCards[randomIndex].hasPrefix("3") {
                playerScore = 3
            }
            else if deckOfCards[randomIndex].hasPrefix("4") {
                playerScore = 4
            }
            else if deckOfCards[randomIndex].hasPrefix("5") {
                playerScore = 5
            }
            else if deckOfCards[randomIndex].hasPrefix("6") {
                playerScore = 6
            }
            else if deckOfCards[randomIndex].hasPrefix("7") {
                playerScore = 7
            }
            else if deckOfCards[randomIndex].hasPrefix("8") {
                playerScore = 8
            }
            else if deckOfCards[randomIndex].hasPrefix("9") {
                playerScore = 9
            }else if deckOfCards[randomIndex].hasPrefix("10") {
                playerScore = 10
            }
            else if deckOfCards[randomIndex].hasPrefix("ace") {
                print("Found Ace")
                playerScore = 11
            }
            else if deckOfCards[randomIndex].hasPrefix("jack") {
                playerScore = 10
            }
            else if deckOfCards[randomIndex].hasPrefix("queen") {
                playerScore = 10
            }
            else if deckOfCards[randomIndex].hasPrefix("king") {
                playerScore = 10
            }
        } else {
            print("Cards have been played")
            playableCards = Array(Set(deckOfCards).subtracting(cardsPlayed))
            print(playableCards)
            let rndmIndex = Int(arc4random_uniform(UInt32(playableCards.count)))
            print(rndmIndex)
            print(playableCards[rndmIndex])
            cardsPlayed.append(playableCards[rndmIndex])
            playerCards.image = UIImage(named: playableCards[rndmIndex])
            if playableCards[rndmIndex].hasPrefix("2") {
                playerScore += 2
            }
            else if playableCards[rndmIndex].hasPrefix("3") {
                playerScore += 3
            }
            else if playableCards[rndmIndex].hasPrefix("4") {
                playerScore += 4
            }
            else if playableCards[rndmIndex].hasPrefix("5") {
                playerScore += 5
            }
            else if playableCards[rndmIndex].hasPrefix("6") {
                playerScore += 6
            }
            else if playableCards[rndmIndex].hasPrefix("7") {
                playerScore += 7
            }
            else if playableCards[rndmIndex].hasPrefix("8") {
                playerScore += 8
            }
            else if playableCards[rndmIndex].hasPrefix("9") {
                playerScore += 9
            }else if playableCards[rndmIndex].hasPrefix("10") {
                playerScore += 10
            }
            else if playableCards[rndmIndex].hasPrefix("ace") {
                print("Found Ace")
                alert.view.tintColor = UIColor.blue
                alert.view.backgroundColor = UIColor.cyan
                alert.view.layer.cornerRadius = 25
                present(alert, animated: true, completion: nil)
            }
            else if playableCards[rndmIndex].hasPrefix("jack") {
                playerScore += 10
            }
            else if playableCards[rndmIndex].hasPrefix("queen") {
                playerScore += 10
            }
            else if playableCards[rndmIndex].hasPrefix("king") {
                playerScore += 10
            }
        }
        playerScoreLabel.text = String(playerScore)
        if playerScore > 21 {
            present(loseAlert, animated: true, completion: nil)
        }
        if playerScore == 21{
            present(winAlert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func getRandomCard(_ sender: UIButton){
        getCardPlayer()
    }
    
    @IBAction func getWinner(_ sender: UIButton){
        print("In getWinner function")
        checkGame()
        //getCardDealer()
    }
    
    @IBAction func surrender(_ sender: UIButton){
        present(loseAlert, animated: true, completion: nil)
    }
    
    func checkGame(){
        if(playerScore == 21 && dealerScore != 21){
            present(winAlert, animated: true, completion: nil)
        }
        else if(dealerScore == 21 && dealerScore != 21){
            present(loseAlert, animated: true, completion: nil)
        }
        else if playerScore > 21 {
            present(loseAlert, animated: true, completion: nil)
        }
        else if dealerScore > 21 {
            present(winAlert, animated: true, completion: nil)
        }
        else if playerScore == dealerScore {
            present(drawAlert, animated: true, completion: nil)
        }
        else if playerScore > dealerScore && playerScore <= 21 {
            present(winAlert, animated: true, completion: nil)
        }
        else if dealerScore > playerScore && dealerScore <= 21 {
            present(loseAlert, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("BlackJack view loaded.")
        print(Deck.shared.cards)
        gameSetup()
    }
    
    func gameSetup(){
        let resetAction = UIAlertAction(title: "Restart the Game", style: .default, handler: {(action) -> Void in
            self.gameReset()
        })
        let suspendAction = UIAlertAction(title: "Quit the Game", style: .default, handler: {(action) -> Void in
            self.gameReset()
            UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        })
        let action1 = UIAlertAction(title: "Add 1", style: .default, handler: {(action) -> Void in
            print("They chose the value of 1")
            print(action.title!)
            self.playerScore += 1
            print(self.playerScore)
            self.playerScoreLabel.text = String(self.playerScore)
        })
        let action11 = UIAlertAction(title: "Add 11", style: .default, handler: {(action) -> Void in
            print("They chose the value of 11")
            print(action.title!)
            self.playerScore += 11
            print(self.playerScore)
            self.playerScoreLabel.text = String(self.playerScore)
        })
        loseAlert.addAction(resetAction)
        loseAlert.addAction(suspendAction)
        winAlert.addAction(resetAction)
        winAlert.addAction(suspendAction)
        drawAlert.addAction(resetAction)
        drawAlert.addAction(suspendAction)
        alert.addAction(action1)
        alert.addAction(action11)
        gamestart()
    }
    
    
}
