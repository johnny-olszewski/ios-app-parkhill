//
//  BiblePassage.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/2/25.
//

import Foundation

struct BiblePassage: Codable, Hashable {
    let book: BibleBook
    let chapters: [Int]?
    let verses: [Int: VerseRange]?
    
    enum CodingKeys: String, CodingKey {
        case book
        case chapters
        case verses
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode BiblePassages
        let bookString = try container.decode(String.self, forKey: .book)
        self.book = BibleBook(rawValue: bookString) ?? .unknown
        
        self.chapters = try container.decodeIfPresent([Int].self, forKey: .chapters)
        
        self.verses = try container.decodeIfPresent([Int: VerseRange].self, forKey: .verses)
    }
    
    struct VerseRange: Codable, Hashable, CustomStringConvertible {
        let start: Int
        let end: Int
        
        var description: String { "\(start)-\(end)"}
    }
}

extension BiblePassage: CustomStringConvertible {
    var description: String {
        
        if chapters == nil, verses == nil {
            return book.rawValue
        }
        
        var result = "\n"
        
        if let chapters = self.chapters {
            for chapter in chapters {
                result += "\(book.rawValue) \(chapter)\n"
            }
        }
        
        if let verses = self.verses {
            for chapter in verses {
                result += "\(book.rawValue) \(chapter.key): \(chapter.value)\n"
            }
        }
        
        return result
    }
}


