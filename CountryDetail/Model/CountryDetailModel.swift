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
    
    init(title: String, rowArray: [Row?]) { // default struct initializer
        self.title = title
        self.rows = rowArray
    }
}

extension CountryDetailModel {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let headerTitle = try container.decodeIfPresent(String.self,
                                                     forKey: .title)
        var rowArray = try container.nestedUnkeyedContainer(forKey: .rows)
        let rowList : [Row] = []
//        while  {
//            <#code#>
//        }
        self.init(title: headerTitle!, rowArray: rowList)
    }
}
