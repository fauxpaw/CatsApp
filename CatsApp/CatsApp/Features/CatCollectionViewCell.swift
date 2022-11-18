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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak private var factLabel: UILabel!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    func configureView(with cat: Cat, fact: String) {
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.startAnimating()
        self.factLabel.text = fact
        imageView.layer.cornerRadius = cardCornerRadius
        guard let url = URL(string: cat.imageURL()) else { return }
        loadImage(url: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.factLabel.text = ""
    }

    private func loadImage(url: URL) {
        
        if let cachedImage = imageCache.object(forKey: URLKey(url: url)) {
            self.imageView.image = cachedImage
            activityIndicator.stopAnimating()
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let data = data { // should have some default image as a graceful fallback
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        imageCache.setObject(image, forKey: URLKey(url: url))
                        self.imageView.image = image
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }.resume()
    }
}
