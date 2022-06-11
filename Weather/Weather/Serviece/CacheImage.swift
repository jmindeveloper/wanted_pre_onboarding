//
//  CacheImage.swift
//  Weather
//
//  Created by J_Min on 2022/06/11.
//

import Foundation
import UIKit

final class CacheImage {
    static let shared = CacheImage()
    private init() { }
    
    var cache = [String: Data]()
    
    func imageCaching(with image: UIImage, url key: String) {
        if let imageData = image.pngData(), cache[key] == nil {
            cache[key] = imageData
        }
    }   
}
