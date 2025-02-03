//
//  BiblePassage+CustomStringConvertible.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/2/25.
//


import Foundation

extension BiblePassage: CustomStringConvertible {
    var description: String {
        
        if chapters == nil, verses == nil {
            return book.rawValue
        }
        
        var result = ""
        
        if let chapters = self.chapters {
            result += "\(book.rawValue) \(toDashRange(chapters))"
        }
        
        if let verses = self.verses {
            for chapter in verses {
                result += "\(book.rawValue) \(chapter.key): \(chapter.value)"
            }
        }
        
        return result
    }
    
    private func toDashRange(_ numbers: [Int]) -> String {
        guard let first = numbers.first, let last = numbers.last else {
            return ""
        }
        // If you just want "1-3", even if they're not consecutive
        return "\(first)-\(last)"
    }
}


