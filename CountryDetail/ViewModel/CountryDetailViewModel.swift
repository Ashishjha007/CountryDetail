//
//  CountryDetailViewModel.swift
//  CountryDetail
//
//  Created by Ashish jha on 6/12/18.
//  Copyright © 2018 xyz. All rights reserved.
//

import UIKit

struct CountryDetailViewModel {
    static func fetchDetail(_ urlString : String , completion:@escaping (_ rootObject : CountryDetailModel?, _ errorMessage : String?) -> Void)  {
        
        let url = URL(string: urlString)!
        // json data can be downloaded with URLSession but given url is not
        // giving data in correct format so followed below approach
        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//            }
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                print("Error: invalid HTTP response code")
//                return
//            }
//            guard let jsonData = data else {
//                print("Error: missing data")
//                return
//            }

        let string = try? String(contentsOf: url, encoding: .isoLatin1)
        if let content = string {
            let jsonData: Data = (content.data(using: .utf8))!
            do {
                let detail = try JSONDecoder().decode(CountryDetailModel.self, from: jsonData)
                 DispatchQueue.main.async {
                    completion(detail, nil)
                 }
            }
            catch DecodingError.dataCorrupted(let context) {
                let msg = context.debugDescription
                completion(nil, msg)
            }
            catch DecodingError.keyNotFound(_, let context) {
                let msg = context.debugDescription
                completion(nil, msg)
            }
            catch DecodingError.typeMismatch(_, let context) {
                let msg = context.debugDescription
                completion(nil, msg)
            }
            catch DecodingError.valueNotFound(_, let context) {
                let msg = context.debugDescription
                completion(nil, msg)
            }
            catch {
                let msg = error.localizedDescription
                completion(nil, msg)
            }
        } else {
            completion(nil, "Please check internet connection.")
        }
    }
}
