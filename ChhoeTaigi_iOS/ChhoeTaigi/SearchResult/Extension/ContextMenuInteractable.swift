//
//  ContextMenuInteractable.swift
//  ChhoeTaigi
//
//  Created by bcylin on 26/09/2020.
//

import UIKit

/// A protocol that provides context menu configuration for table view controllers.
protocol ContextMenuInteractable {}

@available(iOS 13.0, *)
extension ContextMenuInteractable where Self: UITableViewController {

    func contextMenuConfiguration(for dataSource: UITableViewDataSource, at indexPath: IndexPath) -> UIContextMenuConfiguration? {
        let cell = dataSource.tableView(tableView, cellForRowAt: indexPath) as? ContentLabelContainer
        guard let copiableText = cell?.columnContentLabel?.text else {
            return nil
        }

        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let copy = UIAction(title: "Hok-tsè", image: UIImage(systemName: "doc.on.doc")) { _ in
                UIPasteboard.general.string = copiableText
            }
            return UIMenu(title: "", children: [copy])
        }
    }

}
