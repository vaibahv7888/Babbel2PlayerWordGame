//
//  WorldsEngSpa.swift
//  Babbel2PlayerWordGame
//
//  Created by Vaibhav Bangde on 7/28/19.
//  Copyright © 2019 Vaibhav Bangde. All rights reserved.
//

import Foundation

public struct Words : Codable {
    let text_eng : String
    let text_spa : String
    
    init(text_eng: String, text_spa: String) {
        self.text_eng = text_eng
        self.text_spa = text_spa
    }
    
    init(_ dictionary: [String: Any]) {
        self.text_eng = dictionary["text_eng"] as! String
        self.text_spa = dictionary["text_spa"] as! String
    }
}

extension Words : Equatable {
    public static func == (lhs: Words, rhs: Words) -> Bool {
        if lhs.text_eng == rhs.text_eng && lhs.text_spa == rhs.text_spa {
            return true
        } else {
            return false
        }
    }
}
