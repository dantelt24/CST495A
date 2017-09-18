//
//  Deck.swift
//  CardGames
//
//  Created by Dante  Lacey-Thompson on 9/12/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import UIKit

final class Deck{
    private init() {}
    static let shared = Deck()
    var cards: [String] = []
}
