//
//  CountryDetailModel.swift
//  CountryDetail
//
//  Created by Ashish jha on 6/12/18.
//  Copyright © 2018 xyz. All rights reserved.
//

import UIKit

struct CountryDetailModel : Codable {
        let title : String
        let rows : [Row?]
    
    struct Row : Codable {
        enum CodingKeys: String, CodingKey {
            case title
            case description
            case imageHref
        }
        let title : String?
        let description : String?
        let imageHref : URL?
    }
}

extension CountryDetailModel {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let headerTitle = try container.decodeIfPresent(String.self,
                                                     forKey: .title)
        var rowUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .rows)
        var rowArray : [Row] = []
        while !rowUnkeyedContainer.isAtEnd {
            if let row = try? rowUnkeyedContainer.decode(Row.self) {
                rowArray.append(row)
            }
        }
        let filteredRowArray = rowArray.filter{ $0.title != nil }.map { $0 }
        self.init(title: headerTitle!, rows: filteredRowArray)
    }
}
