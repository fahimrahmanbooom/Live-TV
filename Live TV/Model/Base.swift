//
//  Base.swift
//  Live TV
//
//  Created by Fahim Rahman on 22/4/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

struct Base : Codable {
    let entertainment : [Entertainment]?
    let news : [News]?
    let sports : [Sports]?
    let cartoon : [Cartoon]?

    enum CodingKeys: String, CodingKey {

        case entertainment = "entertainment"
        case news = "news"
        case sports = "sports"
        case cartoon = "cartoon"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        entertainment = try values.decodeIfPresent([Entertainment].self, forKey: .entertainment)
        news = try values.decodeIfPresent([News].self, forKey: .news)
        sports = try values.decodeIfPresent([Sports].self, forKey: .sports)
        cartoon = try values.decodeIfPresent([Cartoon].self, forKey: .cartoon)
    }
}
