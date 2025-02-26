//
//  ReadingPlanView.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/2/25.
//

import SwiftUI
import SwiftData

struct ReadingPlanView: View {
    
    private enum Constants {
        struct HeaderGradient {
            static let startingColor: Color = .bread
            static let endingColor: Color = .black.opacity(0.5)
            static let startingOpacity: CGFloat = 0.95
            static let endingOpacity: CGFloat = 0.8
            static let startingPoint: UnitPoint = .init(x: 0.5, y: -0.5)
            static let endingPointX: CGFloat = 0.7
            static let endingPointY: CGFloat = 2
            
            static let height: CGFloat = 150
        }
        
        static let headerImageName = "bread_cover"
        static let headerSubtitle: String = "Park Hill Church"
    }
    
    @Environment(\.modelContext) var modelContext
    
    @ObservedObject var readingPlanManager: ReadingPlanManager
    
    @State private var isShowingHeader: Bool = false
    @State private var headerTransitionCompletion: CGFloat = 0
    
    @State private var selectedViewType: ViewType = .list
    
    @State private var path: NavigationPath = .init()
    
    var headerGradient: LinearGradient {
        return .init(
            colors: [
                Constants.HeaderGradient.startingColor.opacity(Constants.HeaderGradient.startingOpacity),
                Constants.HeaderGradient.endingColor.opacity(Constants.HeaderGradient.endingOpacity)
            ],
            startPoint: Constants.HeaderGradient.startingPoint,
            endPoint: .init(
                x: Constants.HeaderGradient.endingPointX,
                y: Constants.HeaderGradient.endingPointY * headerTransitionCompletion
            )
        )
    }
    
    init(readingPlanManager: ReadingPlanManager) {
        self.readingPlanManager = readingPlanManager
    }
    
    var body: some View {
        
        NavigationStack(path: $path) {
            
            if let readingPlan = readingPlanManager.readingPlan {
                
                ZStack(alignment: .top) {
                    Color.primaryBackground.ignoresSafeArea()
                    
                    ScrollView {
                        
                        LazyVStack(spacing: 16) {
                            
                            ReadingPlanHeader(
                                imageName: Constants.headerImageName,
                                title: readingPlanManager.readingPlan?.name ?? "No Title",
                                subtitle: Constants.headerSubtitle,
                                caption: readingPlanManager.readingPlan?.planDescription ?? "No Description",
                                selectedViewType: $selectedViewType
                            )
                            
                            if let sections = readingPlan.sections {
                                ReadingPlanListView(path: $path, sections: sections)
                            }
                        }
                    }
                    .ignoresSafeArea()
                    .onScrollGeometryChange(
                        for: CGFloat.self,
                        of: { scrollGeometry in
                            let offset = scrollGeometry.contentOffset.y + scrollGeometry.contentInsets.top
                            return offset
                        },
                        action: { oldOffset, newOffset in
                            handleScrollGeometryChange(oldOffset, newOffset)
                        }
                    )
                    
                    renderHeader(readingPlan.name)
                }
                .navigationDestination(for: BreadReadingPlan.Day.self) { day in
                    Text("\(day.date)")
                }
            }
        }
    }
}

extension ReadingPlanView {
    
    private func renderHeader(_ title: String) -> some View {
        Text(title.uppercased())
            .frame(maxWidth: .infinity, alignment: .center)
            .monospacedDigit()
            .font(.largeTitle)
            .kerning(15)
            .foregroundStyle(.white.opacity(headerTransitionCompletion))
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(headerGradient.opacity((headerTransitionCompletion)))
    }
    
    func handleScrollGeometryChange(_ oldOffset: CGFloat, _ newOffset: CGFloat) {
        let bottomHeaderLimit: CGFloat = 50
        let topHeaderLimit: CGFloat = 140
        let headerLimitRange: CGFloat = bottomHeaderLimit - topHeaderLimit // 110 - 140 = -30
        
        var newOpacity: CGFloat = 0
        
        if newOffset >= bottomHeaderLimit {
            // e.g. offset in [110 ... 140]
            newOpacity = abs((newOffset - bottomHeaderLimit) / headerLimitRange)
            
            // Also clamp to 0...1 if you don't want it to exceed
            newOpacity = min(max(newOpacity, 0), 1)
        } else {
            // If offset < 110, fully transparent
            newOpacity = 0
        }
        
        headerTransitionCompletion = newOpacity
    }
}

extension ReadingPlanView {
    enum ViewType {
        case list
        case calendar
    }
}

#Preview {
    ReadingPlanView(readingPlanManager: ReadingPlanManager(planId: BreadReadingPlan.bread2025Id))
}
