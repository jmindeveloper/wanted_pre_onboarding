//
//  Extension.swift
//  Weather
//
//  Created by J_Min on 2022/06/11.
//

import UIKit

extension UIImageView {
    func loadImage(index: String) {
        let urlString = "http://openweathermap.org/img/wn/\(index)@2x.png"
        if let imageData =  CacheImage.shared.cache[urlString] {
            self.image = UIImage(data: imageData)
        } else {
            DispatchQueue.global().async {
                guard let url = URL(string: urlString),
                      let data = try? Data(contentsOf: url),
                      let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.image = image
                    CacheImage.shared.imageCaching(with: image, url: urlString)
                }
            }
        }
    }
}
