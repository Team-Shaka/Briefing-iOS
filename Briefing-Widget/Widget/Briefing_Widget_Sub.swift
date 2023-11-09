//
//  Briefing_Widget_Sub.swift
//  Briefing-WidgetExtension
//
//  Created by 이전희 on 11/7/23.
//

import SwiftUI
import WidgetKit

// 위젯 새로고침 타임라인 결정
struct SubProvider: TimelineProvider {
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

struct Briefing_WidgetSubEntryView : View {
    var entry: SubProvider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .accessoryRectangular: accessoryRectangular
        default: VStack {}
        }
    }
    
    var accessoryRectangular: some View {
        let contentCount: Int = 2
        return VStack(alignment: .leading, spacing: 4) {
            Text(BriefingWidgetStringCollection.displayName)
                .font(.productSans(size: 16))
            VStack(alignment:.leading, spacing: 2) {
                if let briefings = entry.keywords?.briefings.prefix(contentCount) {
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
}

// Widget
struct Briefing_SubWidget: Widget {
    let kind: String = "com.bmlee.briefing.sub"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: SubProvider()) { entry in
            Briefing_WidgetSubEntryView(entry: entry)
            
                .containerBackground(.white,
                                     for: .widget)
        }.configurationDisplayName(BriefingWidgetStringCollection.displayName)
            .description(BriefingWidgetStringCollection.description)
            .supportedFamilies([.accessoryRectangular])
    }
}

#Preview(as: .systemSmall) {
    Briefing_SubWidget()
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
