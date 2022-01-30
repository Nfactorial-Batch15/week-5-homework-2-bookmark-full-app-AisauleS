//
//  BookmarkModel.swift
//  BookmarkUIKIT
//
//  Created by Aisaule Sibatova on 27.01.2022.
//

import Foundation

protocol BookMarkProtocol {
    var title: String {get set}
    var url: String {get set}
}
struct BookMarks: BookMarkProtocol {
    var title: String
    var url: String
}

