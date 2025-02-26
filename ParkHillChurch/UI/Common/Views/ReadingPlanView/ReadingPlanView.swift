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
            static let endingColor: Color = .white
            static let startingOpacity: CGFloat = 0.95
            static let endingOpacity: CGFloat = 0.8
            static let startingPoint: UnitPoint = .init(x: 0.5, y: -0.5)
            static let endingPointX: CGFloat = 0.7
            static let endingPointY: CGFloat = 2
            
            static let textKerning: CGFloat = 15
            static let textVerticalPadding: CGFloat = 20
            static let textOffset: CGFloat = -200
            
            static let bottomLimit: CGFloat = 50
        }
        
        static let headerImageName: String = "bread_cover"
        static let headerSubtitle: String = "Park Hill Church"
        
        static let defaultTitle: String = "Reading Plan"
        static let defaultPlanDescription: String = ""
    }
    
    @Environment(\.modelContext) var modelContext
    
    @ObservedObject var readingPlanManager: ReadingPlanManager
    
    @State private var isShowingHeader: Bool = false
    @State private var headerIsTransitioning: Bool = false
    
    @State private var selectedViewType: ViewType = .list
    
    @State private var path: NavigationPath = .init()
    
    var headerGradient: LinearGradient = .init(
        colors: [
            Constants.HeaderGradient.startingColor.opacity(Constants.HeaderGradient.startingOpacity),
            Constants.HeaderGradient.endingColor.opacity(Constants.HeaderGradient.endingOpacity)
        ],
        startPoint: Constants.HeaderGradient.startingPoint,
        endPoint: .init(
            x: Constants.HeaderGradient.endingPointX,
            y: Constants.HeaderGradient.endingPointY
        )
    )
    
    init(readingPlanManager: ReadingPlanManager) {
        self.readingPlanManager = readingPlanManager
    }
    
    var body: some View {
        
        NavigationStack(path: $path) {
            
            if let readingPlan = readingPlanManager.readingPlan {
                
                ZStack(alignment: .top) {
                    
                    Color.primaryBackground.ignoresSafeArea()
                    
                    ScrollView {
                        LazyVStack {
                            
                            ReadingPlanHeader(
                                imageName: Constants.headerImageName,
                                title: readingPlanManager.readingPlan?.name ?? Constants.defaultTitle,
                                subtitle: Constants.headerSubtitle,
                                caption: readingPlanManager.readingPlan?.planDescription ?? Constants.defaultPlanDescription,
                                selectedViewType: $selectedViewType
                            )
                            
                            if let sections = readingPlan.sections {
                                ReadingPlanListView(path: $path, sections: sections)
                            }
                        }
                    }
                    .ignoresSafeArea(edges: .top)
                    .onScrollGeometryChange(
                        for: CGFloat?.self,
                        of: { scrollGeometry in
                            let offsetY = scrollGeometry.contentOffset.y
                            let contentHeight = scrollGeometry.contentSize.height
                            let viewportHeight = scrollGeometry.bounds.height
                            
                            let maxOffset = contentHeight - viewportHeight
                            let overshoot = offsetY - maxOffset
                            
                            // if rubberbanding
                            if overshoot > 0 {
                                return nil
                            }
                            
                            return offsetY
                        },
                        action: { oldOffset, newOffset in
                            handleScrollGeometryChange(oldOffset, newOffset)
                        }
                    )
                    
                    renderHeader(readingPlan.name)
                }
                .navigationDestination(for: BreadReadingPlan.Day.self) { day in
                    
                    let selectedStep: BreadStep = day.dateCompleted == nil ? .breathe : .read
                    
                    BreadWizardView(selectedStep: selectedStep, day: day)
                }
            }
        }
    }
}

extension ReadingPlanView {
    
    @ViewBuilder
    private func renderHeader(_ title: String) -> some View {
        Text(title.uppercased())
            .frame(maxWidth: .infinity, alignment: .center)
            .monospacedDigit()
            .font(.largeTitle)
            .kerning(Constants.HeaderGradient.textKerning)
            .foregroundStyle(.white)
            .padding(.vertical, Constants.HeaderGradient.textVerticalPadding)
            .frame(maxWidth: .infinity)
            .background(self.headerGradient)
            .transition(.move(edge: .top))
            .offset(y: isShowingHeader ? 0 : Constants.HeaderGradient.textOffset)
    }
    
    func handleScrollGeometryChange(_ oldOffset: CGFloat?, _ newOffset: CGFloat?) {
        
        guard let newOffset, let oldOffset else {
            isShowingHeader = false
            return
        }
        
        guard !headerIsTransitioning else {
            return
        }
        
        let bottomHeaderLimit: CGFloat = Constants.HeaderGradient.bottomLimit
        
        let shouldShowHeader = oldOffset > newOffset && newOffset > bottomHeaderLimit
        
        withAnimation(.smooth) {
            headerIsTransitioning = true
            if isShowingHeader != shouldShowHeader { isShowingHeader.toggle() }
        } completion: {
            headerIsTransitioning = false
        }
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
