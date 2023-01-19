//
//  ViewController.swift
//  Test
//
//  Created by Alessandro Cei on 18/01/23.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController, UIScrollViewDelegate {
    
    var SPMCViewModel = SendProfileMultipeerConnectivityViewModel()
    var profiles: [Profile] = ProfileManager.shared.profiles {
        didSet {
            updateUI()
        }
    }
    func updateUI() {
        NotificationCenter.default.post(name: .profilesGotUpdated, object: self)
    }
    let cellReuseIdentifier = "ContactCell"
    var tableData = [
        (title:"Name Surname", subtitle: "Surname"),
        (title:"Name Surname", subtitle: "Surname"),
        (title:"Name Surname", subtitle: "Surname"),
        (title:"Name Surname", subtitle: "Surname"),
        (title:"Name Surname", subtitle: "Surname"),
    ]
    let viewTitle: UILabel = {
        let label = UILabel()
        label.text = "Resumes"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let profileButton: UIButton = {
        let button = UIButton()
        var config = UIImage.SymbolConfiguration(paletteColors: [.systemBlue, .systemGray5])
        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20.0)))
        button.setImage(UIImage(systemName: "plus", withConfiguration: config), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let resumeScrollView: UIScrollView = {
        let scrollView : UIScrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    let resumePageControl: UIPageControl = {
        let pageControl : UIPageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    let contactsLabel: UILabel = {
        let label = UILabel()
        label.text = "Contacts"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    let addContactButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Add Contact", for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let swiftUIView = UIHostingController(rootView: SwiftUIView())
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 16, *) {
            print("This code only runs on iOS 16 and up")
            addChild(swiftUIView)
            view.addSubview(swiftUIView.view)
            swiftUIView.didMove(toParent: self)
            swiftUIView.view?.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                swiftUIView.view!.topAnchor.constraint(equalTo: view.topAnchor), swiftUIView.view!.leadingAnchor.constraint(equalTo: view.leadingAnchor), swiftUIView.view!.trailingAnchor.constraint(equalTo: view.trailingAnchor), swiftUIView.view!.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        } else {
            print("This code only runs on iOS 15 and lower")
            NotificationCenter.default.addObserver(self, selector: #selector(handleProfilesGotUpdated), name: .profilesGotUpdated, object: nil)
            setupUI()
            print(ProfileManager.shared.profiles[0])
        }
    }
    
    func setupUI() {
        ProfileManager.shared.addProfile(profile: Profile(name: "Mario", surname: "Rossi", birthDate: Date.now, description: "Lorem ipsum dolor sit amet", displayName: "Test"))
        view.addSubview(viewTitle)
        profileButton.addTarget(self, action: #selector(self.profilePressed), for: .touchUpInside)
        view.addSubview(profileButton)
        configurePageControl()
        resumeScrollView.delegate = self
        resumeScrollView.isPagingEnabled = true
        view.addSubview(resumeScrollView)
        
        for (index, element) in ProfileManager.shared.profiles.enumerated() {
            var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
            frame.origin.x = self.view.frame.width * 0.9 * CGFloat(index)
            frame.size = CGSize(width: self.view.frame.width * 0.9, height: self.view.frame.height * 0.23)
            let resume = Resume(frame: frame)
            resume.SPMCViewModel = SPMCViewModel
            resume.nameLabel.text = element.name
            resume.surnameLabel.text = element.surname
            self.resumeScrollView.addSubview(resume)
        }
        
        view.addSubview(contactsLabel)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.addSubview(addContactButton)
        addContactButton.addTarget(self, action: #selector(self.addContactPressed), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            viewTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20), viewTitle.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            profileButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20), profileButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            resumeScrollView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 30), resumeScrollView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor), resumeScrollView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.9), resumeScrollView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.23)
        ])
        NSLayoutConstraint.activate([
            resumePageControl.topAnchor.constraint(equalTo: resumeScrollView.bottomAnchor, constant: 1), resumePageControl.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor), resumePageControl.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.9)
        ])
        self.resumeScrollView.contentSize = CGSize(width: (self.view.frame.width * 0.9) * CGFloat(ProfileManager.shared.profiles.count), height: self.view.frame.height * 0.23)
        self.resumePageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
        NSLayoutConstraint.activate([
            contactsLabel.topAnchor.constraint(equalTo: resumePageControl.bottomAnchor, constant: 20), contactsLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            addContactButton.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.9), addContactButton.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.06), addContactButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor), addContactButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contactsLabel.bottomAnchor), tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor), tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor), tableView.bottomAnchor.constraint(equalTo: addContactButton.topAnchor, constant: -20)
        ])
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToProfile" {
//            if let destination = segue.destination as? ProfileViewController {
//                destination.delegate = self
//            }
//        }
//    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many resumes we have.
        self.resumePageControl.numberOfPages = ProfileManager.shared.profiles.count
        self.resumePageControl.currentPage = 0
        self.resumePageControl.pageIndicatorTintColor = UIColor.gray
        self.resumePageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(resumePageControl)
        
    }

    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(resumePageControl.currentPage) * self.view.frame.width * 0.9
        resumeScrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(resumeScrollView.contentOffset.x / self.view.frame.width * 0.9)
        resumePageControl.currentPage = Int(pageNumber)
    }
    @objc func profilePressed(sender: AnyObject) -> () {
        self.performSegue(withIdentifier: "goToProfile", sender: sender)
    }
    @objc func addContactPressed(sender: AnyObject) -> () {
        SPMCViewModel.host()
    }
    @objc func handleProfilesGotUpdated() {
        for x in self.view.subviews {
            x.removeFromSuperview()
        }

        setupUI()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "RECENTS"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = tableData[row].title
        cell.detailTextLabel?.text = tableData[row].subtitle
        
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete the row from the data
            tableData.remove(at: indexPath.row)
            // Delete the row from the table itself
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension Notification.Name {
    static let profilesGotUpdated = Notification.Name("profilesGotUpdated")
}

