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