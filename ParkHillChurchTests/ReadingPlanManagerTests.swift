//
//  ReadingPlanManagerTests.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/25/25.
//


import Testing
@testable import ParkHillChurch

extension ParkHillChurchTests {
    struct ReadingPlanManagerTests {
        
        let sut = ReadingPlanManager(planId: BreadReadingPlan.bread2025Id)
        
        @Test func testLoadBreadReadingPlanNoError() {
            let readingPlan: BreadReadingPlan? = try? sut.loadReadingPlanFromJSON()
            
            #expect(readingPlan != nil)
        }
    }
}
