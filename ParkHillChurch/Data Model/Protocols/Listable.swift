//
//  Listable.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/31/25.
//


import Foundation

protocol Listable: Hashable {
    var listTitle: String { get }
    var listSubtitle: String? { get }
}
