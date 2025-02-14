//
//  ReadingPlanDayView.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/4/25.
//

import SwiftUI

struct ReadingPlanDayView: View {
    
    private enum Constants {
        static let breathePrompt: String = "Find a place where you can encounter God, ask him to fill the space, and then take a minute in the stillness."
        static let readPrompt: String = "Slowly read through the passage of the day, find a verse that stands out or grabs your attention. Write it down."
        static let encounterPrompt: String = "Take your chosen verse, meditate on it, and consider what God might be saying to you."
        static let applyPrompt: String = "Turn your focus outward, and think about how you might practically live out what God is saying today."
        static let devotePrompt: String = "Close by writing a simple prayer of devotion to God"
    }
    
    @State private var selectedPassage: BiblePassage?
    
    @State private var encounterText: String = ""
    @State private var applyText: String = ""
    @State private var devoteText: String = ""
    
    var day: BreadReadingPlan.Day
    var dateButtonPressed: () -> Void = { }
    
    var weekdayString: String {
        day.date.formatted(Date.FormatStyle().weekday(.wide))
    }
    
    var monthYearString: String {
        day.date.formatted(Date.FormatStyle().month(.wide).year())
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                Group {
                    
                    breatheSection
                    
                    readSection
                    
                    encounterSection
                    
                    applySection
                    
                    devoteSection
                }
                .padding(.horizontal)
            }
        }
        .border(.yellow)
        .scrollClipDisabled(false)
        .fullScreenCover(item: $selectedPassage) { passage in
            Text("\(passage)")
            
            Button("Close") {
                selectedPassage = nil
            }
        }
    }
    
    @ViewBuilder
    var breatheSection: some View {
        sectionTitle("Breathe")
        
        sectionCaption(Constants.breathePrompt)
    }
    
    @ViewBuilder
    var readSection: some View {
        sectionTitle("Read")
        
        sectionCaption(Constants.readPrompt)
        
        ForEach(day.passages, id: \.self) { passage in
            NavigationLink(value: passage) {
                passageButton(passage)
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    var encounterSection: some View {
        sectionTitle("Encounter")
        
        sectionCaption(Constants.encounterPrompt)
        
        responseEntry($encounterText)
    }
    
    @ViewBuilder
    var applySection: some View {
        sectionTitle("Apply")
        
        sectionCaption(Constants.applyPrompt)
        
        responseEntry($applyText)
    }
    
    @ViewBuilder
    var devoteSection: some View {
        sectionTitle("Devote")
        
        sectionCaption(Constants.devotePrompt)
        
        responseEntry($devoteText)
    }
    
    func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 28).bold().lowercaseSmallCaps().monospacedDigit())
            .foregroundStyle(.primaryText.opacity(0.7))
    }
    
    func sectionCaption(_ caption: String) -> some View {
        Text(caption)
            .font(.system(size: 14).italic())
    }
    
    @ViewBuilder
    func passageButton(_ passage: BiblePassage) -> some View {
        Button {
            selectedPassage = passage
        } label: {
            HStack {
                Text(passage.description)
                    .font(.system(size: 16).lowercaseSmallCaps())
                    .foregroundStyle(.primaryText)
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "book.pages")
                            .font(.system(size: 18))
                    }
                    .foregroundStyle(.primaryText)
                }
            }
            .padding()
            .background {
                Color.brown.opacity(0.1)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
    
    @ViewBuilder
    func responseEntry(_ response: Binding<String>) -> some View {
        TextEditor(text: response)
            .padding()
            .padding(.bottom, 16)
            .scrollContentBackground(.hidden)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.brown.opacity(0.7))
            }
            .overlay(alignment: .bottomTrailing) {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 16))
                    .foregroundStyle(.brown.opacity(0.7))
                    .padding()
            }
            .padding()
    }
}

//#Preview {
//    ReadingPlanDayView()
//}
