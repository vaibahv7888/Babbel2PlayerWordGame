//
//  FetchWordsData.swift
//  Babbel2PlayerWordGame
//
//  Created by Vaibhav Bangde on 7/28/19.
//  Copyright © 2019 Vaibhav Bangde. All rights reserved.
//

import Foundation

struct FetchWordsData : FetchWordsDataProtocol {
    var words : [Words]?
    
    init() {
        words = readJSON()
    }
    
    func readJSON() -> [Words]? {
        if let path = Bundle.main.path(forResource: "words", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    data, options: [])
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return nil
                }
                var tempwords = [Words]()
                tempwords = jsonArray.compactMap(Words.init)

                print(jsonArray)
                return tempwords
            } catch {
                // handle error
                print("Parse Error")
            }
        }
        return nil
    }
    
    func decodeJSON<T>(type: T.Type, from: Data?) -> T? where T : Decodable {
        let decoder = JSONDecoder()
        
        guard let data = from,
            let decoded = try? decoder.decode(type.self, from: data) else { return nil }
        
        return decoded
    }
    
    func getMainWord() -> Words? {
        return words?.randomElement()
    }
    
    func getRandomWord(except: Words?) -> Words? {
        guard let wordsArr = words else { return nil }
        
        guard let currectMainWord = except else { return nil }
        
        let probabilty = Int(arc4random_uniform(UInt32(4)))
        
        if probabilty == 1 {
            return currectMainWord
        } else {
            var word : Words
            repeat {
                guard let tempWord = wordsArr.randomElement() else { return nil }
                word = tempWord
            } while word == currectMainWord
            return word
        }
    }
}
