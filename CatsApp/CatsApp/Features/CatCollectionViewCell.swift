//
//  CatCollectionViewCell.swift
//  CatsApp
//
//  Created by Michael Sweeney on 11/16/22.
//
import UIKit

private let labelCornerRadius: CGFloat = 4
private let cardCornerRadius: CGFloat = 8

class CatCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "CatCell"
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var factLabel: UILabel!
    
    func configureView(with image: UIImage, fact: String) {
        self.factLabel.text = fact
        self.imageView.image = image
//        contentView.layer.cornerRadius = cardCornerRadius
        imageView.layer.cornerRadius = cardCornerRadius
    }

    private func loadImage(url: URL) {
        
//        if let cachedImage = imageCache.object(forKey: URLKey(url: url)) {
//            self.imageView.image = cachedImage
//        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let data = data { // should have some default image as a graceful fallback
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
//                        imageCache.setObject(image, forKey: URLKey(url: url))
                        self.imageView.image = image
                    }
                }
            }
        }.resume()
    }
}
