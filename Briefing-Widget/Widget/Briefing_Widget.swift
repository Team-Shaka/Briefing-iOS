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
                            subTitle: "",
                            scrapCount: 0)
        }
        
        return Keywords(createdAt: createdAt,
                        // type: "SOCIAL",
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
        case .systemSmall: system(.small)
        case .systemMedium: system(.medium)
        case .systemLarge: system(.large)
        default: VStack {}
        }
    }
    
    var accessoryRectangular: some View {
        let contentCount: Int = 3
        return VStack(alignment: .leading, spacing: 4) {
            // Text(BriefingWidgetStringCollection.displayName)
            //     .font(.productSans(size: 16))
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
    
    enum SystemWidgetType {
        case small
        case medium
        case large
    }
    
    func system(_ type: SystemWidgetType) -> some View {
        let widgetTitleFont: Font = .productSans(size: 18).bold()
        var title: String = BriefingWidgetStringCollection.displayName
        var contentCount: Int = 3
        switch type {
        case .small: title = BriefingWidgetStringCollection.briefing
        case .large: contentCount = 5
        default: break
        }
        
        return VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(widgetTitleFont)
                .foregroundColor(.briefingNavy)
            
            VStack(alignment: .leading){
                if let briefings = entry.keywords?.briefings,
                   !briefings.isEmpty {
                    ForEach(briefings.prefix(contentCount), id: \.id) { keyword in
                        keywordView(keyword: keyword, type: type)
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
    
    func keywordView(keyword: KeywordBriefing,
                     type: SystemWidgetType) -> some View {
        var dividerColor: Color = .briefingWhite
        switch keyword.ranks {
        case 1: dividerColor = .briefingNavy
        case 2: dividerColor = .briefingBlue
        case 3: dividerColor = .briefingLightBlue
        default: break
        }
        
        let dividerWidth: CGFloat = 3
        var size: CGFloat = 18
        
        switch type {
        case .medium, .small: size = 16
        default: break
        }
        
        let titleFont: Font = .productSans(size: size).bold()
        
        return HStack (alignment: .center){
            Divider()
                .frame(width: dividerWidth)
                .overlay(dividerColor)
            switch type {
            case .large:
                Text("\(keyword.ranks)")
                    .font(titleFont)
                    .foregroundColor(.briefingNavy)
                    .padding(.trailing, 4)
                VStack(alignment: .leading, spacing: 4) {
                    Text(keyword.title)
                        .font(titleFont)
                        .foregroundColor(.briefingNavy)
                    if type != .small {
                        Text(keyword.subTitle)
                            .foregroundColor(.gray.opacity(0.6))
                            .font(.productSans(size: size-6))
                            .lineLimit(1)
                    }
                }
            case .medium:
                Text("\(keyword.ranks)")
                    .font(titleFont)
                    .foregroundColor(.briefingNavy)
                    .padding(.trailing, 4)
                HStack(alignment: .bottom, spacing: 4) {
                    Text(keyword.title)
                        .font(titleFont)
                        .foregroundColor(.briefingNavy)
                    Text(keyword.subTitle)
                        .foregroundColor(.gray.opacity(0.6))
                        .font(.productSans(size: size-6))
                        .lineLimit(1)
                }
            case .small:
                HStack(alignment: .center, spacing: 4) {
                    Text(keyword.title)
                        .font(titleFont)
                        .foregroundColor(.briefingNavy)
                }
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
                                .systemSmall,
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
                            subTitle: "",
                            scrapCount: 0)
        }
        return Keywords(createdAt: createdAt,
                        // type: "SOCIAL",
                        briefings: briefings)
    }())
}
