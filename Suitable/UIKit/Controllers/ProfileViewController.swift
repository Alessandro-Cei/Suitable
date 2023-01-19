//
//  ProfileViewController.swift
//  Test
//
//  Created by Alessandro Cei on 18/01/23.
//

import UIKit

class ProfileViewController: UIViewController {
    let saveProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let photoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let profileSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "PROFILE"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let name: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.backgroundColor = UIColor.white
        tf.layer.cornerRadius = 10
        tf.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let surname: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Surname"
        tf.backgroundColor = UIColor.white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let birthdate: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Birthdate"
        tf.backgroundColor = UIColor.white
        tf.layer.cornerRadius = 10
        tf.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isEnabled = false
        return tf
    }()
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.date = Date.now
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    let aboutYouSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "ABOUT YOU"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let selfDescription: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Description"
        tf.backgroundColor = UIColor.white
        tf.layer.cornerRadius = 10
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let linksSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "LINKS"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let links: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Links"
        tf.backgroundColor = UIColor.white
        tf.layer.cornerRadius = 10
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleProfilesGotUpdated), name: .profilesGotUpdated, object: nil)
        self.view.backgroundColor = UIColor.systemGray5
        self.view.addSubview(saveProfileButton)
        saveProfileButton.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
        self.view.addSubview(photoView)
        self.view.addSubview(profileSectionLabel)
        self.view.addSubview(name)
        self.view.addSubview(surname)
        self.view.addSubview(birthdate)
        self.view.addSubview(datePicker)
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        self.view.addSubview(aboutYouSectionLabel)
        self.view.addSubview(selfDescription)
        self.view.addSubview(linksSectionLabel)
        self.view.addSubview(links)
        
        NSLayoutConstraint.activate([
            saveProfileButton.widthAnchor.constraint(equalToConstant: 40), saveProfileButton.heightAnchor.constraint(equalToConstant: 40), saveProfileButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10), saveProfileButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            photoView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.8), photoView.heightAnchor.constraint(equalToConstant: self.view.frame.height / 6), photoView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor), photoView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100)
        ])
        
        NSLayoutConstraint.activate([
            profileSectionLabel.widthAnchor.constraint(equalToConstant: 100), profileSectionLabel.heightAnchor.constraint(equalToConstant: 30), profileSectionLabel.leadingAnchor.constraint(equalTo: photoView.leadingAnchor), profileSectionLabel.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 30)
        ])
        NSLayoutConstraint.activate([
            name.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.8), name.heightAnchor.constraint(equalToConstant: 40), name.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor), name.topAnchor.constraint(equalTo: profileSectionLabel.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            surname.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.8), surname.heightAnchor.constraint(equalToConstant: 40), surname.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor), surname.topAnchor.constraint(equalTo: name.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            birthdate.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.8), birthdate.heightAnchor.constraint(equalToConstant: 40), birthdate.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor), birthdate.topAnchor.constraint(equalTo: surname.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            datePicker.centerYAnchor.constraint(equalTo: birthdate.centerYAnchor), datePicker.trailingAnchor.constraint(equalTo: birthdate.trailingAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            aboutYouSectionLabel.widthAnchor.constraint(equalToConstant: 100), aboutYouSectionLabel.heightAnchor.constraint(equalToConstant: 30), aboutYouSectionLabel.leadingAnchor.constraint(equalTo: photoView.leadingAnchor), aboutYouSectionLabel.topAnchor.constraint(equalTo: birthdate.bottomAnchor, constant: 30)
        ])
        NSLayoutConstraint.activate([
            selfDescription.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.8), selfDescription.heightAnchor.constraint(equalToConstant: 40), selfDescription.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor), selfDescription.topAnchor.constraint(equalTo: aboutYouSectionLabel.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            linksSectionLabel.widthAnchor.constraint(equalToConstant: 100), linksSectionLabel.heightAnchor.constraint(equalToConstant: 30), linksSectionLabel.leadingAnchor.constraint(equalTo: photoView.leadingAnchor), linksSectionLabel.topAnchor.constraint(equalTo: selfDescription.bottomAnchor, constant: 30)
        ])
        NSLayoutConstraint.activate([
            links.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.8), links.heightAnchor.constraint(equalToConstant: 40), links.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor), links.topAnchor.constraint(equalTo: linksSectionLabel.bottomAnchor)
        ])
        
    }
    @objc func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let selectedDate = dateFormatter.string(from: sender.date)
        birthdate.text = selectedDate
    }
    @objc func saveButtonPressed(_ sender: UIDatePicker) {
//        ProfileManager.shared.addProfile(profile: Profile(name: name.text ?? "", surname: surname.text ?? "", birthDate: datePicker.date, description: selfDescription.text ?? "", displayName: "Test"))
        let mainVC = self.presentationController?.presentingViewController as? MainViewController
        mainVC?.profiles.append(Profile(name: name.text ?? "", surname: surname.text ?? "", birthDate: datePicker.date, description: selfDescription.text ?? "", displayName: "Test"))
        self.dismiss(animated: true)
    }
    @objc func handleProfilesGotUpdated() {
        print("Im updating 1")
    }
}
