//
//  AllMenuView.swift
//  Tabling-iOS
//
//  Created by 민 on 11/21/23.
//

import UIKit

import SnapKit

final class AllMenuView: UIView {
    
    // MARK: - UI Components
    
    private let allMenuLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.StoreDetail.allMenuTitle
        label.setLineAndCharacterSpacing(font: .pretendardSemiBold(size: 16))
        label.textColor = .Gray800
        return label
    }()
    
    private let compositionalLayout: UICollectionViewCompositionalLayout = {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0/3.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(0.5)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // header
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(30)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header]
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    private lazy var homeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        collectionView.clipsToBounds = true
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        setRegisterCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions
extension AllMenuView {
    
    func setUI() {
        
    }
    
    func setHierarchy() {
        self.addSubviews(allMenuLabel, homeCollectionView)
    }
    
    func setLayout() {
        allMenuLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.leading.equalToSuperview().inset(15)
            $0.width.equalTo(60)
            $0.height.equalTo(24)
        }
        
        homeCollectionView.snp.makeConstraints {
            $0.top.equalTo(allMenuLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setAddTarget() {
        
    }
    
    @objc
    func buttonTapped() {
        
    }
    
    func setRegisterCell() {
        homeCollectionView.register(MenuCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MenuCollectionHeaderView")
        homeCollectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "MenuCollectionViewCell")
    }
    
    func setDataBind() {
        
    }
}

// MARK: - CollectionView Delegate
extension AllMenuView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as? MenuCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MenuCollectionHeaderView", for: indexPath) as? MenuCollectionHeaderView else { return UICollectionReusableView() }
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - CollectionView DataSource
extension AllMenuView: UICollectionViewDelegate {}
