//
//  ReadingPlanDayView.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/4/25.
//

import SwiftUI

struct ReadingPlanDayView: View {
    
    @State private var encounterText: String = ""
    @State private var applyText: String = ""
    @State private var devoteText: String = ""
    
    @State var selectedSection: Section? = .breathe
    
    var day: BreadReadingPlan.Day
    var dateButtonPressed: () -> Void = { }
    
    var weekdayString: String {
        day.date.formatted(Date.FormatStyle().weekday(.wide))
    }
    
    var monthYearString: String {
        day.date.formatted(Date.FormatStyle().month(.wide).year())
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            ScrollViewReader { proxy in
                HStack(alignment: .top, spacing: 0) {
                    
                    ForEach(Section.allCases, id: \.self) { section in
                        ZStack {
                            Color.gray.opacity(0.1)
                                .clipShape(.rect(cornerRadius: 10))
                            
                            renderViewFor(section)
                                .id(section)
                                .padding()
                            
                        }
                        .padding()
                        .containerRelativeFrame(.horizontal, count: 1, spacing: 0, alignment: .top)
                    }
                }
                .scrollTargetLayout()
            }
        }
        .scrollPosition(id: $selectedSection)
        .scrollTargetBehavior(.paging)
        .safeAreaInset(edge: .top) {
            VStack(spacing: 16) {
                header
                    .animation(.easeInOut, value: selectedSection)
                
                if let caption = selectedSection?.caption {
                    sectionCaption(caption)
                }
            }
            .padding()
        }
    }
    
    var header: some View {
        HStack {
            ForEach(Section.allCases, id: \.self) { section in
                Button {
                    selectedSection = section
                } label: {
                    sectionTitle(section.title)
                }
            }
            
            Spacer()
        }
    }
    
    func sectionTitle(_ title: String) -> some View {
        HStack {
            Text(title.prefix(1))
            
            if selectedSection?.title == title {
                Text(title.dropFirst())
                    .transition(.asymmetric(insertion: .push(from: .trailing), removal: .identity))
            }
        }
        .font(.system(size: 28).bold().lowercaseSmallCaps().monospacedDigit())
        .foregroundStyle(.primaryText.opacity(0.7))
    }
    
    func sectionCaption(_ caption: String) -> some View {
        Text(caption)
            .font(.system(size: 14).italic())
    }
    
    @ViewBuilder
    func renderViewFor(_ section: Section) -> some View {
        switch section {
        case .breathe:
            BreatheSectionView()
        case .read:
            ReadSectionView(passages: day.passages)
        case .encounter:
            EncounterSectionView(response: $encounterText)
        case .apply:
            ApplySectionView(response: $applyText)
        case .devote:
            DevoteSectionView(response: $devoteText)
        }
    }
}

//#Preview {
//    ReadingPlanDayView()
//}
