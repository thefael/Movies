import UIKit

class CollectionViewDataSource<T, Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource {
    var list = [T]()
    var configureCell: ((T, Cell) -> Void)?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = list[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        configureCell?(item, cell)
        return cell
    }


}
