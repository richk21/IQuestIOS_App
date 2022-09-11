//
//  card.swift
//  IQuest-VIT
//
//  Created by Richa on 14/06/22.
//

import SwiftUI

//card model
struct card : Identifiable{
    var id = UUID().uuidString
    var cardColor: Color
    var offset : CGFloat = 0
    var title: String
}
