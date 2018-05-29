//
//  Favorites.swift
//  GRELit
//
//  Created by user138458 on 5/24/18.
//  Copyright © 2018 user138458. All rights reserved.
//

import Foundation

class Favorites {
    var favArrayQuestions = [String]()
    var favArrayAnswers = [String]()
    let defaults = UserDefaults.standard
    
    init(){
        favArrayQuestions = defaults.object(forKey: "SavedFavoritesQuestions") as? [String] ?? [String]()
        favArrayAnswers = defaults.object(forKey: "SavedFavoritesAnswers") as? [String] ?? [String]()
    }
    
    func AddFavorite(AddedQuestion : String, AddedAnswer : String) {
        favArrayQuestions.append(AddedQuestion)
        favArrayAnswers.append(AddedAnswer)
    }
    
    func RemoveFavorite(RemoveQuestion : String) {
        var location = -1
        var i = 0
        while i < favArrayQuestions.count {
            if favArrayQuestions[i] == RemoveQuestion {
                location = i
                break
            }
            i=i+1
        }
        if location >= 0 {
            favArrayQuestions.remove(at: location)
            favArrayAnswers.remove(at: location)
        }
    }
    
    func SaveFavorites() {
        defaults.set(favArrayQuestions, forKey: "SavedFavoritesQuestions")
        defaults.set(favArrayAnswers, forKey: "SavedFavoritesAnswers")
    }
    
    func findQuestion(Question : String) -> Bool {
        var i = 0
        while i < favArrayQuestions.count {
            if favArrayQuestions[i] == Question {
                return true
            } else {
                i = i+1
            }
        }
        return false
    }
    
    
    
}
