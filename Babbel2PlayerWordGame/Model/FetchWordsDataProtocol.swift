//
//  FetchWordsDataProtocol.swift
//  Babbel2PlayerWordGame
//
//  Created by Vaibhav Bangde on 7/28/19.
//  Copyright © 2019 Vaibhav Bangde. All rights reserved.
//

import Foundation

protocol FetchWordsDataProtocol {
    func getMainWord() -> Words?
    func getRandomWord(except: Words?) -> Words?
}
