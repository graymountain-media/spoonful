//
//  BuildingChoiceViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 1/24/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import UIKit

protocol BuildingChoiceViewControllerDelegate: class {
   func buildingPicked(building: String)
}

class BuildingChoiceViewController: UIViewController {
    
    var mainCampusBuildings: [[String]] = []
    var dormBuildings: [[String]] = []
    let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    weak var delegate: BuildingChoiceViewControllerDelegate?
    
    let buildingTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Main Campus","Dorms"])
        control.backgroundColor = .white
        control.tintColor = lightTwo
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(controlValueChanged), for: .valueChanged)
        return control
    }()
    
    var isShowingMainCampus = true {
        didSet {
            buildingTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = darkOne
        self.title = "Buildings"
        
        setupViews()
        getBuildings()
    }
    
    private func getBuildings() {
        mainCampusBuildings = sortBuildings(buildings: ProductionData.mainBuildings)
        dormBuildings = sortBuildings(buildings: ProductionData.dormBuildings)
    }
    
    private func sortBuildings(buildings: [String]) -> [[String]] {
        let alphabeticalBuildings = buildings.sorted()
        var sortedBuildings: [[String]] = []
        for i in 0...25 {
            sortedBuildings.insert([], at: i)
        }
        for building in alphabeticalBuildings {
            let firstLetter = Character(building.prefix(1).uppercased())
            if let index = alphabet.firstIndex(of: firstLetter) {
                let distance = alphabet.distance(from: alphabet.startIndex, to: index)
                sortedBuildings[distance].append(building)
            }
        }
        return sortedBuildings
        
    }
    
    private func setupViews() {
        view.addSubview(buildingTableView)
        buildingTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        buildingTableView.dataSource = self
        buildingTableView.delegate = self
        
        view.addSubview(segmentedControl)
        
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        buildingTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        buildingTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        buildingTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        buildingTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true    }
    
    @objc private func controlValueChanged() {
        isShowingMainCampus = (segmentedControl.selectedSegmentIndex == 0)
    }
}

extension BuildingChoiceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowingMainCampus {
            return mainCampusBuildings[section].count
        } else {
            return dormBuildings[section].count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 26
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let alphabetArray = Array(alphabet)
        return String(alphabetArray[section])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        if isShowingMainCampus{
            let building = mainCampusBuildings[indexPath.section][indexPath.row]
            cell.textLabel?.text = building
        } else {
            let building = dormBuildings[indexPath.section][indexPath.row]
            cell.textLabel?.text = building
        }
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let alphabetArray = Array(alphabet)
        let stringAlphabetArray = alphabetArray.compactMap({String($0)})
        return stringAlphabetArray
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let building = isShowingMainCampus ? mainCampusBuildings[indexPath.section][indexPath.row] : dormBuildings[indexPath.section][indexPath.row]
        delegate?.buildingPicked(building: building)
        navigationController?.popViewController(animated: true)
    }
}
