//
//  DZACollectionViewFlowLayout.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 28/01/20.
//  Copyright © 2020 dhiyaulhaqza. All rights reserved.
//

import UIKit

class DZACollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func invalidationContext(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forPreferredLayoutAttributes: preferredAttributes, withOriginalAttributes: originalAttributes)
        context.invalidateSupplementaryElements(ofKind: UICollectionView.elementKindSectionHeader,
                                                    at: [originalAttributes.indexPath])
        context.invalidateSupplementaryElements(ofKind: UICollectionView.elementKindSectionFooter,
                                                    at: [originalAttributes.indexPath])
        return context
    }
}
