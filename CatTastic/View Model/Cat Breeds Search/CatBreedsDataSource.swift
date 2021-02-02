//
//  CatBreedsDataSource.swift
//  CatTastic
//
import UIKit

enum Section { case main }

final class CatBreedsDataSource: NSObject {
    var dataSource: UICollectionViewDiffableDataSource<Section, CatBreed>!
    
    func configureDataSource(for collectionView: UICollectionView) {
        dataSource = UICollectionViewDiffableDataSource<Section, CatBreed>(collectionView: collectionView,
                                                                           cellProvider: { (collectionView, indexPath, catBreed) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedCollectionViewCell.cellID,
                                                                for: indexPath) as? BreedCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(for: catBreed)
            return cell
        })
    }
    
    func updateData(on catBreeds: [CatBreed]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CatBreed>()
        snapshot = NSDiffableDataSourceSnapshot<Section, CatBreed>()
        snapshot.appendSections([.main])
        snapshot.appendItems(catBreeds)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
