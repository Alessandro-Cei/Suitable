//
//  Resume.swift
//  Test
//
//  Created by Alessandro Cei on 18/01/23.
//

import UIKit

class Resume: UIView, UIDocumentPickerDelegate {
    let sendButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Send", for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    let surnameLabel: UILabel = {
        let label = UILabel()
        label.text = "Surname"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let color = UIColor.systemBlue
        self.backgroundColor = color.withAlphaComponent(0.1)
        self.layer.cornerRadius = 15
        self.addSubview(sendButton)
        sendButton.addTarget(self, action: #selector(self.sendPressed), for: .touchUpInside)
        self.addSubview(nameLabel)
        self.addSubview(surnameLabel)
        
        NSLayoutConstraint.activate([
            sendButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20), sendButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20), sendButton.widthAnchor.constraint(equalToConstant: self.frame.width * 0.3), sendButton.heightAnchor.constraint(equalToConstant: self.frame.height * 0.2)
        ])
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20), nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20), nameLabel.widthAnchor.constraint(equalToConstant: self.frame.width * 0.3), nameLabel.heightAnchor.constraint(equalToConstant: self.frame.height * 0.2)
        ])
        NSLayoutConstraint.activate([
            surnameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -20), surnameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20), surnameLabel.widthAnchor.constraint(equalToConstant: self.frame.width * 0.3), surnameLabel.heightAnchor.constraint(equalToConstant: self.frame.height * 0.2)
        ])
        
        
    }
    @objc func sendPressed(sender: AnyObject) -> () {

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
