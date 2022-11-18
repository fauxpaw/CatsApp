//
//  CatsCollectionViewController.swift
//  CatsApp
//
//  Created by Michael Sweeney on 11/16/22.
//

import UIKit

class CatsCollectionViewController: UICollectionViewController {
    
    let displayCount = 20
    var cats = [Cat]()
    var catFacts = [CatFact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        Networking.CatAAS.getCats(limit: displayCount, skip: 0) { result in
            switch result {
            case .success(let cats):
                self.cats = cats
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        Networking.CatFacts.getFacts(limit: displayCount) { result in
            switch result {
            case .success(let facts):
                self.catFacts = facts
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cats.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatCollectionViewCell.reuseID, for: indexPath) as? CatCollectionViewCell else { return UICollectionViewCell() }
        cell.configureView(with: cats[indexPath.row], fact: catFacts[indexPath.row].fact)
        return cell
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let cell = sender as? CatCollectionViewCell else { return false}
        return cell.imageView.image != nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            
            let vc = segue.destination as! CatDetailViewController
            guard let cell = sender as? CatCollectionViewCell else { return }
            guard let image = cell.imageView.image else { return }
            vc.image = image
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerIdentifier", for: indexPath)
        return headerView
    }
}
