//
//  FlashCardsViewController.swift
//  GRELit
//
//  Created by user138458 on 5/23/18.
//  Copyright © 2018 user138458. All rights reserved.
//

import UIKit

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

//let x = [1, 2, 3].shuffled()
// x == [2, 3, 1]

//let fiveStrings = stride(from: 0, through: 100, by: 5).map(String.init).shuffled()

class FlashCardsViewController: UIViewController {

    @IBOutlet weak var AnswerPopUp: UITextView!
    
    @IBOutlet weak var QuestionPopUp: UILabel!
    
    @IBOutlet weak var SeeAnswerButton: UIButton!
    
    @IBOutlet weak var NextButton: UIButton!
    
    @IBOutlet weak var ProgressLabel: UILabel!
    
    @IBOutlet weak var FavoriteButton: UIButton!
    
    @IBOutlet weak var FavoritesStudyButton: UIButton!
    
    var numberOfPresses = 0
    
    var FavoredCards = Favorites.init()
    
    var Questions = [String]()
    var Answers = [String]()

    
    var currentlyInFavorites = false
    
    var FlashCards = [
        
        ["400 - 1300 Britain", "Old English\n\nevents: Battle of Hastings (1066)\n\nauthors: Caedmon, unknown author of Beowulf"],
        ["1300 - 1500 Britain", "Middle English\n\nEvents: Battle of Agincourt (1415), Gutenburg Bible\n\nAuthors: William Langland, Geoffrey Chaucer, Thomas Malory"],
        ["1500 - 1558 Britain", "early Tudor period\n\nEvents: Reigns of Henry VII, Henry VIII, Edward VI and Mary\n\nAuthors: John Skelton, Thomas More"],
        ["1558 - 1603 Britain", "Elizabethan Period\n\nEvents: Reign of Elizabeth I\n\nAuthors: Philip Sidney, Edmund Spenser, John Lyly, Christopher Marlowe, William Shakespeare"],
        ["1603 - 1625 Britain", "Jacobean Period\n\nEvents: Reign of James I\n\nAuthors: Ben Jonson"],
        ["1625 - 1649 Britain", "Caroline period\n\nEvents: Reign of Charles I\n\nAuthors: John Donne, John Webster"],
        ["1649 - 1660 Britain", "Events: Charles I executed (1649), Cromwell and the Interregnum\n\nAuthors: John Milton, Robert Herrick, Andrew Marvell"],
        ["1660 - 1714 Britain", "Restoration Period\n\nEvents: Reign of Charles II\n\nAuthors: William Congreve, George Etherege, John Bunyan, John Dryden"],
        ["1714 - 1727 Britain", "Events: Reigne of Anne, the last Stuart monarch\n\nAuthors: Daniel Defoe, Alexander Pope"],
        ["1727 - 1760 Britain", "Events: Reign of George I\n\nAuthors: Jonathan Swift, Henry Fielding, Thomas Gray"],
        ["1760 - 1790 Britain", "The Enlightenment\n\nEvents: reign of George II, first 30 years of George III's reign, American Revolution, the Gothic Novel\n\nAuthors: Samuel Johnson, Lawrence Sterne, Horace Walpole, Thomas Chatterton, Mary Wollstonecraft, William Cowper"],
        ["1790 - 1820 Britain", "Early Romantic Period\n\nEvents: second 30 years of George III's reign, German Sturm and Drang\n\nAuthors: Anne Radcliffe, William Blake, William Wordsworth, Samuel Coleridge, Percy Bysshe Shelley, Lord Byron, John Keats"],
        ["1820 - 1837 Britain", "Middle Romantic Period\n\nEvents: reigns of George IV and William IV\n\nAuthors: Charles Lamb, Jane Austen, Thomas Carlyle, Alfred Tennyson, Washington Irving"],
        ["1837 - 1869 Britain", "Late Romantic / Victorian Period\n\nEvents: First 32 years of Victoria's reign\n\nAuthors: Thomas Macaulay, Emily Bronte, Charlotte Bronte, Charles Dickens, Robert Browning"],
        ["1837 - 1869 America", "Transcendentalism\n\nAuthors: Nathaniel Hawthorne, Ralph Waldo Emerson, Henry David Thoreau, Walt Whitman, Herman Melville"],
        ["1869 - 1901", "Realism\n\nEvents: Second 30 years of Victoria's reign\n\nAuthors: John Ruskin, George Meredith, Charles Swinburne, George Eliot Gerard, M. Hopkins, Thomas Hardy, Mark Twain, Henry James"],
        ["1901 - 1939", "Modernism\n\nAuthors: William Butler yeats, Joseph Conrad, D.H. Lawrence, W.H. Auden, James Joyce, Virginia Woolf, Ernest Hemingway, F. Scott Fitzgerald, Gertrude Stein, T.S. Eliot, Ezra Pound, W.E.B. DuBois"]
        
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentlyInFavorites = false
        AnswerPopUp.isHidden = true
        NextButton.isHidden = true
        FlashCards.shuffle()
        QuestionPopUp.text = FlashCards[numberOfPresses][0]
        AnswerPopUp.text = FlashCards[numberOfPresses][1]
        ProgressLabel.text = String(numberOfPresses+1) + " / " + String(FlashCards.count)
        ChangeHeart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func SeeAnswerPress(_ sender: UIButton) {
        AnswerPopUp.isHidden = false
        NextButton.isHidden = false
        SeeAnswerButton.isHidden = true
    }
    
    func showAlert() {
        let myAlertController: UIAlertController = UIAlertController(title: "Whoops", message: "No favorites!  Taking you back to flashcards...", preferredStyle: .alert)
        
        let okayAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
            //do some stuff
        }
        
        myAlertController.addAction(okayAction)
        
        self.present(myAlertController, animated: true, completion: nil)
    }
    
    @IBAction func FavoriteButtonPush(_ sender: UIButton) {
         let fullHeart = UIImage(named: "full")
        if currentlyInFavorites == false {
            let Question = FlashCards[numberOfPresses][0]
            let Answer = FlashCards[numberOfPresses][1]
            if FavoriteButton.currentImage == fullHeart {
                FavoredCards.RemoveFavorite(RemoveQuestion: Question)
                ChangeHeart()
                FavoredCards.SaveFavorites()
            } else {
                FavoredCards.AddFavorite(AddedQuestion: Question, AddedAnswer: Answer)
                ChangeHeart()
                FavoredCards.SaveFavorites()
            }
            FavoredCards.SaveFavorites()
        } else {
            if FavoriteButton.currentImage == fullHeart {
                let Question = Questions[numberOfPresses]
                FavoredCards.RemoveFavorite(RemoveQuestion: Question)
                Questions.remove(at: numberOfPresses)
                Answers.remove(at: numberOfPresses)
                numberOfPresses = numberOfPresses + 1
                FavoredCards.SaveFavorites()
                if Questions.count == 0 && numberOfPresses >= Questions.count{
                    showAlert()
                    numberOfPresses = 0
                    currentlyInFavorites = false
                    AnswerPopUp.isHidden = true
                    NextButton.isHidden = true
                    FlashCards.shuffle()
                    QuestionPopUp.text = FlashCards[numberOfPresses][0]
                    AnswerPopUp.text = FlashCards[numberOfPresses][1]
                    ProgressLabel.text = String(numberOfPresses+1) + " / " + String(FlashCards.count)
                    ChangeHeart()
                    FavoritesStudyButton.setTitle("Study Favorites", for: [])
                    return
                } else {
                    AnswerPopUp.isHidden = true
                    NextButton.isHidden = true
                    SeeAnswerButton.isHidden = false
                    if (numberOfPresses >= Questions.count) {
                        numberOfPresses = 0
                    }
                    AnswerPopUp.text = Answers[numberOfPresses]
                    QuestionPopUp.text = Questions[numberOfPresses]
                    ProgressLabel.text = String(numberOfPresses+1) + " / " + String(Questions.count)
                    ChangeHeart()
                }
            } else {
                FavoriteButton.setImage(fullHeart, for: [])
            }
        }
    }
    
    @IBAction func NextButtonPress(_ sender: UIButton) {
        if currentlyInFavorites == false {
            AnswerPopUp.isHidden = true
            NextButton.isHidden = true
            SeeAnswerButton.isHidden = false
            numberOfPresses = numberOfPresses + 1
            if (numberOfPresses >= FlashCards.count) {
                numberOfPresses = 0
                FlashCards.shuffle()
            }
            QuestionPopUp.text = FlashCards[numberOfPresses][0]
            AnswerPopUp.text = FlashCards[numberOfPresses][1]
            ProgressLabel.text = String(numberOfPresses+1) + " / " + String(FlashCards.count)
            ChangeHeart()
        } else {
            AnswerPopUp.isHidden = true
            NextButton.isHidden = true
            SeeAnswerButton.isHidden = false
            numberOfPresses = numberOfPresses + 1
            if numberOfPresses >= Questions.count {
                numberOfPresses = 0
            }
            QuestionPopUp.text = Questions[numberOfPresses]
            AnswerPopUp.text = Answers[numberOfPresses]
            ProgressLabel.text = String(numberOfPresses+1) + " / " + String(Questions.count)
            ChangeHeart()
        }
    }
    
func ChangeHeart() {
    var Question = ""
    if currentlyInFavorites == true && Questions.count > 0 {
                Question = Questions[numberOfPresses]
    } else {
                Question = FlashCards[numberOfPresses][0]
    }
    let fullHeart = UIImage(named: "full")
    let emptyHeart = UIImage(named: "empty")
    if FavoredCards.findQuestion(Question : Question) == true{
        FavoriteButton.setImage(fullHeart, for: [])
    } else {
        FavoriteButton.setImage(emptyHeart, for: [])
    }
}
    
    @IBAction func StudyFavoritesPress(_ sender: UIButton) {
        Questions = FavoredCards.favArrayQuestions
        Answers = FavoredCards.favArrayAnswers
        if Questions.count == 0 {
           showAlert()
        } else {
            if currentlyInFavorites == false {
                numberOfPresses = 0
                currentlyInFavorites = true
                QuestionPopUp.text = Questions[numberOfPresses]
                AnswerPopUp.text = Answers[numberOfPresses]
                ProgressLabel.text = String(numberOfPresses+1) + " / " + String(Questions.count)
                AnswerPopUp.isHidden = true
                SeeAnswerButton.isHidden = false
                NextButton.isHidden = true
                FavoritesStudyButton.setTitle("Back to Flashcards", for: [])
                ChangeHeart()
            } else {
                numberOfPresses = 0
                currentlyInFavorites = false
                FlashCards.shuffle()
                QuestionPopUp.text = FlashCards[numberOfPresses][0]
                AnswerPopUp.text = FlashCards[numberOfPresses][1]
                ProgressLabel.text = String(numberOfPresses+1) + " / " + String(FlashCards.count)
                AnswerPopUp.isHidden = true
                SeeAnswerButton.isHidden = false
                NextButton.isHidden = true
                FavoritesStudyButton.setTitle("Study Favorites", for: [])
                ChangeHeart()
        }
    }
}
    
    
}
