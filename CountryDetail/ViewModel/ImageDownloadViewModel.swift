//
//  ImageDownloadViewModel.swift
//  CountryDetail
//
//  Created by Ashish jha on 6/14/18.
//  Copyright © 2018 xyz. All rights reserved.
//

import UIKit

protocol ImageDownloadProtocol {
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}

extension ImageDownloadProtocol {
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let session = URLSession(configuration: .default)
        DispatchQueue.global(qos: .background).async {
            session.dataTask(with: URLRequest(url: url)) { data, response, error in
                if error != nil {
                    print(error?.localizedDescription ?? "Unknown error")
                }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }.resume()
        }
    }
}

