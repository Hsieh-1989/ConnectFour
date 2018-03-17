//
//  ReuseableView.swift
//  ConnectFour
//
//  Created by hsieh on 2017/11/29.
//  Copyright © 2017年 Hsieh. All rights reserved.
//

import UIKit

protocol ReuseableView {
    static var identifier: String { get }
}

extension ReuseableView {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol NibLoadable {
    static var nib: UINib { get }
}

extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

extension UITableViewCell: ReuseableView {}
extension UICollectionViewCell: ReuseableView {}

extension UITableView {
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }
    
    func registerNib<T: UITableViewCell>(_ cellClass: T.Type) where T: NibLoadable {
        register(cellClass.nib, forCellReuseIdentifier: cellClass.identifier)
    }
    
    func dequeue<T: UITableViewCell>(_ cellClass: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.identifier, for: indexPath) as? T else {
            fatalError("cannot dequeue cell (maybe forget to register cell)")
        }
        return cell
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.identifier)
    }
    
    func registerNib<T: UICollectionViewCell>(_ cellClass: T.Type) where T: NibLoadable {
        register(cellClass.nib, forCellWithReuseIdentifier: cellClass.identifier)
    }
    
    func dequeue<T: UICollectionViewCell>(_ cellClass: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellClass.identifier, for: indexPath) as? T else {
            fatalError("cannot dequeue cell (maybe forget to register cell)")
        }
        return cell
    }
}





