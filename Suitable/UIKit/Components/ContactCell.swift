//
//  ContactCell.swift
//  Test
//
//  Created by Alessandro Cei on 18/01/23.
//

import UIKit

class ContactCell: UITableViewCell {
    static let reuseId = "ContactCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
