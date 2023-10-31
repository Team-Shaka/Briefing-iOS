//
//  Briefing_Widget.swift
//  Briefing-Widget
//
//  Created by 이전희 on 10/31/23.
//

import WidgetKit
import SwiftUI

// 위젯 새로고침 타임라인 결정
struct Provider: TimelineProvider {
    private let keywordsExample: Keywords = {
        let createdAt = Date()
        let briefings:[KeywordBriefing] = (1...10).map { rank in
            KeywordBriefing(id: rank,
                            ranks: rank,
                            title: "",
                            subTitle: "")
        }
        
        return Keywords(createdAt: createdAt,
                        briefings: briefings)
    }()
    
    func placeholder(in context: Context) -> BriefingEntry {
        let entry = BriefingEntry(date: Date(),
                                  keywords: nil)
        return entry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (BriefingEntry) -> Void) {
        Task {
            let keywords = await BriefingWidgetNetworkManager.shared.fetchKeywords(date: Date())
            let entry: BriefingEntry = BriefingEntry(date: Date(),
                                                     keywords: keywords)
            completion(entry)
        }
        
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<BriefingEntry>) -> Void) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .hour, value: 5, to: currentDate)!
        
        Task {
            let keywords = await BriefingWidgetNetworkManager.shared.fetchKeywords(date: Date())
            let entries: [BriefingEntry] = [
                BriefingEntry(date: Date(),
                              keywords: keywords)
            ]
            completion(Timeline(entries: entries, policy: .after(refreshDate)))
        }
    }
}

struct Briefing_WidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .accessoryRectangular: accessoryRectangular
        case .systemLarge: systemLarge
        case .systemMedium: systemMedium
        default: VStack {}
        }
    }
    
    var accessoryRectangular: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(BriefingWidgetStringCollection.displayName)
                .font(.productSans(size: 16))
            VStack(alignment:.leading, spacing: 2) {
                if let briefings = entry.keywords?.briefings.prefix(2) {
                    ForEach(briefings, id:\.id) { briefing in
                        HStack {
                            Divider()
                                .frame(width: 2)
                                .overlay(.white)
                            Text(briefing.title)
                                .font(.productSans(size: 16, weight: .bold))
                        }
                    }
                } else {
                    HStack {
                        Divider()
                            .frame(width: 3)
                            .overlay(.white)
                        Text(BriefingWidgetStringCollection.waitingData)
                            .font(.productSans(size: 16, weight: .bold))
                    }
                }
                HStack{ Spacer() }
            }
        }
    }
    
    var systemLarge: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(BriefingWidgetStringCollection.displayName)
                .font(.productSans(size: 20, weight: .bold))
            
            VStack(alignment: .leading){
                if let briefings = entry.keywords?.briefings {
                    ForEach(briefings.prefix(8), id: \.id) { keyword in
                        keywordView(keyword: keyword, type: .large)
                    }
                } else {
                    VStack(alignment: .center){
                        Spacer()
                        Text(BriefingWidgetStringCollection.waitingData)
                        Spacer()
                        HStack { Spacer() }
                    }
                }
                HStack { Spacer() }
            }
        }
    }
    
    var systemMedium: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(BriefingWidgetStringCollection.displayName)
                .font(.productSans(size: 20, weight: .bold))
            
            VStack(alignment: .leading){
                if let briefings = entry.keywords?.briefings {
                    ForEach(briefings.prefix(3), id: \.id) { keyword in
                        keywordView(keyword: keyword, type: .medium)
                    }
                } else {
                    VStack(alignment: .center){
                        Spacer()
                        Text(BriefingWidgetStringCollection.waitingData)
                        Spacer()
                        HStack { Spacer() }
                    }
                }
                HStack { Spacer() }
            }
        }
    }
    
    enum systemWidgetType {
        case large
        case medium
    }
    
    func keywordView(keyword: KeywordBriefing,
                     type: systemWidgetType) -> some View {
        var dividerColor: Color = .briefingWhite
        switch keyword.ranks {
        case 1: dividerColor = .briefingNavy
        case 2: dividerColor = .briefingBlue
        case 3: dividerColor = .briefingLightBlue
        default: break
        }
        let dividerWidth: CGFloat = 3
        var size: CGFloat = 16
        if type == .large {
            size = 18
        }
        
        
        return HStack (alignment: .center){
            Divider()
                .frame(width: dividerWidth)
                .overlay(dividerColor)
            Text("\(keyword.ranks)")
                .font(.productSans(size: size+2, weight: .bold))
            HStack(alignment: .bottom) {
                Text(keyword.title)
                    .font(.productSans(size: size))
                Text(keyword.subTitle)
                    .foregroundColor(.gray.opacity(0.6))
                    .font(.productSans(size: size-6))
            }
        }
    }
}

// Widget
struct Briefing_Widget: Widget {
    // 이 문자열을 가지고 위젯을 식별
    let kind: String = "com.bmlee.briefing"
    
    var body: some WidgetConfiguration {
        // Widget Content View
        // Configuration Type (static, intent)
        StaticConfiguration(kind: kind,
                            provider: Provider()) { entry in
            Briefing_WidgetEntryView(entry: entry)
            
                .containerBackground(.white,
                                     for: .widget)
        }.configurationDisplayName(BriefingWidgetStringCollection.displayName)
            .description(BriefingWidgetStringCollection.description)
            .supportedFamilies([.accessoryRectangular,
                                .systemLarge,
                                .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    Briefing_Widget()
} timeline: {
    BriefingEntry(date: .now, keywords: {
        let createdAt = Date()
        let briefings:[KeywordBriefing] = (1...10).map { rank in
            KeywordBriefing(id: rank,
                            ranks: rank,
                            title: "\(rank) - Breifing",
                            subTitle: "")
        }
        return Keywords(createdAt: createdAt,
                        briefings: briefings)
    }())
}
