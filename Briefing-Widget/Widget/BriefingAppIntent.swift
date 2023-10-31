//
//  AppIntent.swift
//  Briefing-Widget
//
//  Created by 이전희 on 10/31/23.
//

import WidgetKit
import AppIntents

struct BriefingConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}
