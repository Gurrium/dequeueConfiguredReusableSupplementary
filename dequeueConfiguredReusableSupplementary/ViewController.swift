//
//  ViewController.swift
//  dequeueConfiguredReusableSupplementary
//
//  Created by gurrium on 2021/05/02.
//

import UIKit

class ViewController: UICollectionViewController {
    private var dataSource: UICollectionViewDiffableDataSource<Int, Int>!

    override func viewDidLoad() {
        super.viewDidLoad()

        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.footerMode = .supplementary
        collectionView.setCollectionViewLayout(UICollectionViewCompositionalLayout.list(using: config), animated: false)

        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Int> { cell, _, number in
            var config = cell.defaultContentConfiguration()
            config.text = "\(number)"

            cell.contentConfiguration = config
        }
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) { $0.dequeueConfiguredReusableCell(using: cellRegistration, for: $1, item: $2) }

        let footerRegistration = UICollectionView.SupplementaryRegistration<SomeFooterView>(supplementaryNib: UINib(nibName: "SomeFooterView", bundle: nil), elementKind: UICollectionView.elementKindSectionFooter) { _, _, _ in }
        dataSource.supplementaryViewProvider = {
            $0.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: $2)
        }

        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems([0, 1, 2])
        dataSource.apply(snapshot)
    }
}

