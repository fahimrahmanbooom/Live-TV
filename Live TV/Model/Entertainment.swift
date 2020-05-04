//
//  Entertainment.swift
//  Live TV
//
//  Created by Fahim Rahman on 22/4/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

struct Entertainment : Codable {
    let name : String?
    let link : String?
    let image : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case link = "link"
        case image = "image"
    }

    init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }

}
