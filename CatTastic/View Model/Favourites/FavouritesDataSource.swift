//
//  FavouritesDataSource.swift
//  CatTastic
//
import UIKit

final class FavouritesDataSource: GenericDataSource<CatBreed>, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.value.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesTableViewCell.cellID,
                                                       for: indexPath) as? FavouritesTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(for: data.value[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, commit
                    editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let catBreed = data.value[indexPath.row]
            data.value.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            PersistenceManager.updateWith(cat: catBreed, actionType: .remove) { _ in
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            }
        }
    }
}
