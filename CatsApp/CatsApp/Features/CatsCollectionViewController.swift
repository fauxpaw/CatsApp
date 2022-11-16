//
//  CatsCollectionViewController.swift
//  CatsApp
//
//  Created by Michael Sweeney on 11/16/22.
//

import UIKit

class CatsCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatCollectionViewCell.reuseID, for: indexPath) as? CatCollectionViewCell else { return UICollectionViewCell() }
        let image = UIImage()
        let fact = "hello there"
        cell.configureView(with: image, fact: fact)
        return cell
    }
}

extension UIScrollView {
    
    var verticalOffsetForBottom: CGFloat {
            let scrollViewHeight = bounds.height
            let scrollContentSizeHeight = contentSize.height
            let bottomInset = contentInset.bottom
            let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
            return scrollViewBottomOffset
        }
    
    var isAtBottom: Bool {
            return contentOffset.y >= verticalOffsetForBottom
        }
}
