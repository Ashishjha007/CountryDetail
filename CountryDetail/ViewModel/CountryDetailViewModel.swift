//
//  CountryDetailViewModel.swift
//  CountryDetail
//
//  Created by Ashish jha on 6/12/18.
//  Copyright © 2018 xyz. All rights reserved.
//

import UIKit

struct CountryDetailViewModel {
    static func fetchDetail(_ urlString : String , completion:@escaping (_ rootObject : CountryDetailModel?) -> Void)  {
        
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
        let jsonData: Data = (string?.data(using: .utf8))!
            
        do {
            let detail = try JSONDecoder().decode(CountryDetailModel.self, from: jsonData)
             DispatchQueue.main.async {
                completion(detail)
            }
        }
        catch DecodingError.dataCorrupted(let context) {
            print(context.debugDescription)
        }
        catch DecodingError.keyNotFound(let key, let context) {
            print("\(key.stringValue) was not found, \(context.debugDescription)")
        }
        catch DecodingError.typeMismatch(let type, let context) {
            print("\(type) was expected, \(context.debugDescription)")
        }
        catch DecodingError.valueNotFound(let type, let context) {
            print("no value was found for \(type), \(context.debugDescription)")
        }
        catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
