//
//  ImageCache.swift
//  CatsApp
//
//  Created by Michael Sweeney on 11/17/22.
//

import UIKit

class URLKey {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

let imageCache = NSCache<URLKey, UIImage>()
