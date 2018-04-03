

import UIKit

class ConcentrationViewController: UIViewController {
    
    
    // MARK: properties
    @IBOutlet var cardCollection: [UIButton]!
    
    var twoCardsPicked: [UIButton] = []
    
    var emojiCardsNonRandom: [String: [String] ] =
        [ "Sports" : ["⚽️","🏀","🏈","⚾️","🎾","🏐","⚽️","🏀","🏈","⚾️","🎾","🏐"],
          "Faces" : ["😆","😕","🤠","😘","😍","😎","😆","😕","🤠","😘","😍","😎"],
          "Animals" : ["😺","🐵","🐶","🐭","🐻","🐷","😺","🐵","🐶","🐭","🐻","🐷"]
    ]
    
    
    var emojiCardsRandom: [String] = []
    
    var theme: String?
    
    // MARK: actions
    @IBAction func cardTap(_ sender: UIButton) {
        
        if doubleClicking(with: sender) {
            return
        }
        
        let index: Int! = cardCollection.index(of: sender)
        let emoji = emojiCardsRandom[index]
        
        flipCard(withEmoji: emoji, on: sender)
        if twoCardsPicked.count == 0 {
            twoCardsPicked.append(sender)
        } else if twoCardsPicked.count == 1 {
            twoCardsPicked.append(sender)
        } else if twoCardsPicked.count == 2{
            matchOrFlipThenEmpty()
            twoCardsPicked.append(sender)
        }
        else {
            emptyTwoCardsPicked()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateView()
    }
    
    private func updateView() {
        
        let currentTheme = theme ?? "Sports"
        var emojiArray = emojiCardsNonRandom[currentTheme]!
        
        for i in 0 ..< 12 {
            let randomIndex = arc4random_uniform(UInt32(11-i))
            let emoji = emojiArray.remove(at: Int(randomIndex))
            emojiCardsRandom.append(emoji)
        }
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateView()
    }
    
    // MARK: methods
    private func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            
            button.setTitle("",for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.5249390194, green: 0.258030158, blue: 0.7298615608, alpha: 1)
            return
        }
        button.setTitle(emoji, for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func emptyTwoCardsPicked() {
        twoCardsPicked = []
    }
    
    private func matchOrFlipThenEmpty() {
        if let cardIndex1 = cardCollection.index(of: twoCardsPicked[0]) {
            if let cardIndex2 = cardCollection.index(of: twoCardsPicked[1]) {
                let emoji1 = emojiCardsRandom[cardIndex1]
                let emoji2 = emojiCardsRandom[cardIndex2]
                
                if emoji1 == emoji2 {
                    cardCollection[cardIndex1].isEnabled = false
                    cardCollection[cardIndex2].isEnabled = false
                    emptyTwoCardsPicked()
                    return
                } else {
                    flipCard(withEmoji: emoji1, on: cardCollection[cardIndex1])
                    flipCard(withEmoji: emoji2, on: cardCollection[cardIndex2])
                    emptyTwoCardsPicked()
                }
            }
        }
    }
    
    private func doubleClicking(with button: UIButton) -> Bool {
        let cardsHeldCount = twoCardsPicked.count
        switch cardsHeldCount {
        case 1:
            if twoCardsPicked[0] == button {
                return true
            }
        case 2:
            if twoCardsPicked[1]  == button {
                return true
            } else if twoCardsPicked[0] == button {
                return true
            }
        default: break
        }
        return false
    }
}

