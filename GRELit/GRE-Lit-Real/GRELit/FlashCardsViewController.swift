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
    
    var favFlashCards = [[String]()]

    
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
        ["1901 - 1939", "Modernism\n\nAuthors: William Butler yeats, Joseph Conrad, D.H. Lawrence, W.H. Auden, James Joyce, Virginia Woolf, Ernest Hemingway, F. Scott Fitzgerald, Gertrude Stein, T.S. Eliot, Ezra Pound, W.E.B. DuBois"],
        ["Alexandrine (term)", "A line of iambic hexameter at the end of a Spenserian stanza"],
        ["Alliteration (term)", "Repeated consonant sounds, important in Old English poetry such as Beowulf"],
        ["Allusion (term)", "A reference to something or someone, usually literary"],
        ["Antagonist (term)", "Opposite of the protagonist, often a villain"],
        ["Anthropomorphism (term)", "The assigning of human attributes, such as emotions or physical charactistics to nonhumans, most often plants and animals.  It differs from personification insofar as this applies throughout the entire work"],
        ["Apostrophe (term)", "Innately gradiose speech addressed to someone or something that is not present or an abstraction (like \"History\")"],
        ["Bildungsroman (term)", "\"Novel of Education\" -- follows a young person over a period of years from naivete and inexperience through the first struggles with the harsher realities and hypocrises of the adult world\n\nEx: Great Expectations"],
        ["Caesura (term)", "The pause that breaks a line of Old English verse"],
        ["Decorum (term)", "A neoclassical principle of drama in which style must match content/context -- a character's speech should be appropriate to his/her social standing"],
        ["Doggerel (term)", "Crappy poetry with no value"],
        ["Epithalamium (term)", "A work, primarily poem, that is written to celebrate a wedding"],
        ["Euphuism (term)", "Self-conscious, highly-elaborate way of speaking--popular in the late 16th century\n\nEx: Polonius from Hamlet"],
        ["Feminine Rhyme (term)", "Lines rhymed by their final two syllables, the penultimates rhyme and the final ones rhyme and are unstressed\n\npainted, acquainted\n\npassion, fashion"],
        ["Flat Character (term)", "Character with only one single dominant trait, fairly predictable"],
        ["Round Character (term)", "Character with deep psychological complexity"],
        ["Georgic (term)", "Contrary to pastoral poetry, Georgics deal with the harsh realities and hard work of country life, pushing plows, laboring, and virtuousness"],
        ["Hamartia (term)", "Aristotle's term for the \"tragic flaw\""],
        ["Homeric Epithet (term)", "A repeated descriptive phrase as found in Homer's epics\n\nEx: \"Hector of the Flashing Helm\""],
        ["Hudibrastic (term)", "deliberately humorous, ill-formed poetry with ill-rhymed couplets\n\ncointed by Sauel Butler\n\nRhymed tetrameter"],
        ["Hyperbole (term)", "A deliberate exaggeration for effect"],
        ["Litotes (term)", "An understatement created through a double-negative\n\nEx: No ordinary city (means an extraordinary city)"],
        ["Masculine Rhyme (term)", "Rhyme predicated on the final, stressed word in a line.  The standard of poetry."],
        ["Metonymy (term)", "Where a single feature of aspect represents the whole idea or person\n\n\"The pen is mightier than the sword\"\n\nDiffers from synecdoche insofar as metonymy can be anything to stand for an idea, whereas synecdoche must be a part of something representing the whole."],
        ["Neoclassical Unities (term)", "Coined by Aristotle--there should be a unity of time, place, and action (one day, one location, one main plotline)"],
        ["Pastoral Elegy (term)", "Lamentation for the dead sung by a shepherd\n\n(Elegy = lament for the dead)"],
        ["Pastoral Literature (term)", "A work that deals with the lives of people, especially shepherds, in the country or in nature"],
        ["Pathetic Fallacy (term)", "Coined by John Ruskin; it refers to ascribing emotion or agency to inanimate objects."],
        ["Personification (term)", "Giving an inanimate ojbect human qualities or form"],
        ["Picaresque (term)", "Series of events type of novel, specifically one which follows a deviant with base concerns (such as food and shelter)\n\n Ex: Huckleberry Finn"],
        ["Protagonist (term)", "The main character, usually the hero"],
        ["Sprung Rhythm (term)", "Varying number of unstressed syllables--only stressed ones count toward the syllabic count.  \n\nCoined by Gerard Manley Hopkins (19th C.)"],
        ["Synaesthesia (term)", "A phrase that suggests the interplay of senses, as in Keats's \"Ode to a Nightengale\""],
        ["Synecdoche (term)", "Where a part of something represents the whole (differs from metonymy)\n\nEx: Cleveland is up 6 runs (referring to the Cleveland Indians)"],
        ["Voice (term)", "The perspective from which the story is written"],
        ["Chinua Achebe", "Things Fall Apart"],
        ["William Langland", "the conjectured author of the 14th-century English dream-vision Piers Plowman"],
        ["Aeschylus", "The Persions\nOresteia (Agammemenon, Libation Bearers)"],
        ["Isabel Allende", "The H ouse of the Spirits"],
        ["Euripedes", "Medea\nAndromache\nElectra\nBacchae"],
        ["Toni Morrison", "Beloved\nJazz"],
        ["Jean Anouilh", "Antigone (French retelling in the 1940s)"],
        ["Aristophanes", "Lysistrata"],
        ["Aristotle", "Rhetoric\nMetaphysics\nPoetics"],
        ["bathos (term)", "an effect of anticlimax created by an unintentional lapse in mood from the sublime to the trivial or ridiculous"],
        ["eclogue (term)", "a short poem, especially a pastoral dialogue"],
        ["epithalamion (term)", "a song or poem celebrating a marriage"],
        ["epic", "begins with epic invocation to the muse\n\nbegins in media res\n\nfeatures a central hero of supernatural strength\n\nincludes epic similes, epic catalogues, great battles, and supernatural interference\n\nExamples: Odyssey, Illiad, Aeneid, Beowulf, Gilgamesh, Faerie Queene, Paradise Lost\n\nsee mock epic"],
        ["Greek tragedy", "classical plays divided into 4 parts: prologue (introduction), parados (chorus enters and more intro), epeisodia (main action of play and chorus songs/narration (kommos)), exodos (conclusion)"],
        ["William Congreve", "1670-1729\n\nEnglish Restoration dramatists and poet\n\n\"The Way of the World\"\n\nOther works: The Old Bachelor, The Double Dealer, Love for Love"],
        ["Polyhymnia", "in Greek mythology, one of the nine muses (daughters of Zeus and Mnemosyne; known for music, which brings joy to any who hear it\n\nSongs to the gods."],
        ["Erato", "In Greek mythology, one of the nine muses (daughters of Zeus and Mnemosyne; known for music, which brings joy to any who hear it)\n\nlove poetry"],
        ["Calliope", "In Greek mythology, one of the nine muses (daughters of Zeus and Mnemosyne; known for music, which brings joy to any who hear it)\n\nepic poetry"],
        ["Terpsichore", "In Greek mythology, one of the nine muses (daughters of Zeus and Mnemosyne; known for music, which brings joy to any who hear it)\n\ndance"]
        
        
        
    
        
    
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
