//
//  UIImageView+Extension.swift
//  CountriesApp-Kyle
//
//  Created by Kyle-Anthony Hay on 11/1/23.
//

import UIKit
extension UIImageView {
      func loadImage(url: URL) {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url) { [weak self] url, _, error in
          if error == nil, let url = url,
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data) {
              DispatchQueue.main.async {
                  if let weakSelf = self {
                      weakSelf.image = image
                  }
              }
           }
        }
        downloadTask.resume()
      }
    
    func loadImage(url: URL, completion: @escaping () -> Void) {
      let session = URLSession.shared
      let downloadTask = session.downloadTask(with: url) { [weak self] url, _, error in
        if error == nil, let url = url,
          let data = try? Data(contentsOf: url),
          let image = UIImage(data: data) {
            DispatchQueue.main.async {
                if let weakSelf = self {
                    weakSelf.image = image
                    completion()
                }
            }
         }
      }
      downloadTask.resume()
    }
}
