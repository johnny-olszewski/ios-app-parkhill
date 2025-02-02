//
//  BiblePassage.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/2/25.
//

import Foundation

struct BiblePassage: Codable, Hashable {
    let book: BibleBook
//    let chapters: [Int]
    
    enum CodingKeys: String, CodingKey {
        case book
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode BiblePassages
        let bookString = try container.decode(String.self, forKey: .book)
        self.book = BibleBook(rawValue: bookString) ?? .unknown
    }
}

extension BiblePassage: CustomStringConvertible {
    var description: String {
        "\(book.rawValue)"
    }
}


