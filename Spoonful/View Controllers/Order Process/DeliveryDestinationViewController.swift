//
//  DeliveryDestinationViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 1/1/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import UIKit

class DeliveryDestinationViewController: UIViewController {

    var activeBuilding: String?

    let titleLabel: SpoonfulTitleLabel = {
        let label = SpoonfulTitleLabel()
        label.text = "Where Can We Find You?"
    
        return label
    }()
    
    let universityInputRow: UserInputRow = {
        let inputRow = UserInputRow(title: "University", placeholder: "")
        inputRow.isUserInteractionEnabled = false
        inputRow.translatesAutoresizingMaskIntoConstraints = false
        inputRow.textField.text = "University of Utah"
        return inputRow
    }()
    
    let buildingInputRow: UserInputRow = {
        let inputRow = UserInputRow(title: "Building", placeholder: "")
        inputRow.translatesAutoresizingMaskIntoConstraints = false
        inputRow.textField.text = "Select"
        inputRow.textField.tintColor = .clear
        inputRow.textField.isUserInteractionEnabled = false
        return inputRow
    }()
    
    let roomInputRow: UserInputRow = {
        let inputRow = UserInputRow(title: "Room", placeholder: "Optional")
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 40))
        inputRow.textField.rightView = paddingView
        inputRow.textField.rightViewMode = .always
        inputRow.translatesAutoresizingMaskIntoConstraints = false
        inputRow.textField.backgroundColor = .white
        inputRow.textField.textColor = .black
        inputRow.textField.leadingAnchor.constraint(equalTo: inputRow.centerXAnchor, constant: -50).isActive = true
        return inputRow
    }()
    
    let specialNotesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = lightTwo
        return view
    }()
    
    let specialNotesLabel: UILabel = {
        let label = UILabel()
        label.font = titleFont.withSize(20)
        label.text = "Special Notes"
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let specialNotesDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "e.g. Description"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let specialNotesTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.autocorrectionType = .no
        return textView
    }()
    
    let pickerToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.isTranslucent = false
        toolbar.barTintColor = darkOne
        toolbar.tintColor = .white
        return toolbar
    }()
    
    let buildingPicker: UIPickerView = {
        let view = UIPickerView()
        view.backgroundColor = .white
        return view
    }()
    
    let roomPicker: UIPickerView = {
        let view = UIPickerView()
        view.backgroundColor = .white
        return view
    }()
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Delivery Location"
        view.backgroundColor = main
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonPressed))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let buildingTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buildingRowTapped))
        buildingInputRow.addGestureRecognizer(buildingTapGestureRecognizer)
        
        setupViews()
        setupPickerViews()
        getLocations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK:- Setup Views
    
    private func setupViews(){
        view.addSubview(titleLabel)
        view.addSubview(universityInputRow)
        view.addSubview(buildingInputRow)
        view.addSubview(roomInputRow)
        
        view.addSubview(specialNotesView)
        specialNotesView.addSubview(specialNotesLabel)
        specialNotesView.addSubview(specialNotesDetailLabel)
        specialNotesView.addSubview(specialNotesTextView)
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        universityInputRow.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        universityInputRow.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        universityInputRow.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        universityInputRow.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        buildingInputRow.topAnchor.constraint(equalTo: universityInputRow.bottomAnchor, constant: 4).isActive = true
        buildingInputRow.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        buildingInputRow.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        buildingInputRow.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        roomInputRow.topAnchor.constraint(equalTo: buildingInputRow.bottomAnchor, constant: 4).isActive = true
        roomInputRow.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        roomInputRow.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        roomInputRow.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        //SPECIAL NOTES VIEW
        
        specialNotesView.topAnchor.constraint(equalTo: roomInputRow.bottomAnchor, constant: 4).isActive = true
        specialNotesView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        specialNotesView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        specialNotesView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        specialNotesLabel.topAnchor.constraint(equalTo: specialNotesView.topAnchor, constant: 4).isActive = true
        specialNotesLabel.leadingAnchor.constraint(equalTo: specialNotesView.leadingAnchor, constant: 8).isActive = true
//        specialNotesLabel.trailingAnchor.constraint(equalTo: specialNotesView.centerXAnchor).isActive = true
        
        specialNotesDetailLabel.centerYAnchor.constraint(equalTo: specialNotesLabel.centerYAnchor).isActive = true
        specialNotesDetailLabel.leadingAnchor.constraint(equalTo: specialNotesLabel.trailingAnchor, constant: 8).isActive = true
        specialNotesDetailLabel.trailingAnchor.constraint(equalTo: specialNotesView.trailingAnchor, constant: -8).isActive = true
        
        specialNotesLabel.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        specialNotesLabel.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        
        specialNotesTextView.topAnchor.constraint(equalTo: specialNotesLabel.bottomAnchor, constant: 4).isActive = true
        specialNotesTextView.bottomAnchor.constraint(equalTo: specialNotesView.bottomAnchor, constant: -8).isActive = true
        specialNotesTextView.leadingAnchor.constraint(equalTo: specialNotesView.leadingAnchor, constant: 8).isActive = true
        specialNotesTextView.trailingAnchor.constraint(equalTo: specialNotesView.trailingAnchor, constant: -8).isActive = true
        
    }
    
    //MARK:- Private Methods
    
    private func setupPickerViews() {
        
        setupPickerToolbar()
        
        buildingPicker.delegate = self
        buildingPicker.dataSource = self
        
        buildingInputRow.textField.inputView = buildingPicker
        buildingInputRow.textField.inputAccessoryView = pickerToolbar
        
        roomInputRow.textField.inputAccessoryView = pickerToolbar
        specialNotesTextView.inputAccessoryView = pickerToolbar
    }
    
    private func setupPickerToolbar() {
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(pickerCancelButtonPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pickerDoneButtonPressed))
        
        pickerToolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: true)
    }
    
    private func getLocations() {
        
//        if let path = locationDataPath {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path))
//                let jsonDecoder = JSONDecoder()
//                print(data)
//                let dict = try jsonDecoder.decode(LocationsJSONDict.self, from: data)
////                let locations = dict.locations
////                self.locations = locations
//
//                buildingInputRow.isUserInteractionEnabled = true
//                UIView.animate(withDuration: 0.2) {
//                    self.buildingInputRow.alpha = 1
//                }
//            } catch let e {
//                print(e.localizedDescription)
//            }
//        } else {
//            print("Could not get path")
//        }
    
    }
    
    //MARK:- Button Actions
    
    @objc private func nextButtonPressed() {
        let contactVC = ContactInfoViewController()
        
        guard let building = buildingInputRow.textField.text, let room = roomInputRow.textField.text, let specialNote = specialNotesTextView.text else {
            return
        }
        
        let newLocation = DeliveryLocation(building: building, room: room, specialNotes: specialNote)
        
        OrderController.shared.currentOrder.location = newLocation
        
        navigationController?.pushViewController(contactVC, animated: true)
    }
    
    @objc private func pickerCancelButtonPressed() {
        view.endEditing(true)
    }
    
    @objc private func pickerDoneButtonPressed() {
        
        if buildingInputRow.textField.isFirstResponder {
            let selectedIndex = buildingPicker.selectedRow(inComponent: 0)
            let selectedBuilding = ProductionData.mainBuildings[selectedIndex]
            
            buildingInputRow.textField.text = selectedBuilding
            buildingInputRow.textField.resignFirstResponder()
            
            activeBuilding = selectedBuilding
            
            roomInputRow.isUserInteractionEnabled = true
            roomPicker.selectRow(0, inComponent: 0, animated: false)
            
            navigationItem.rightBarButtonItem?.isEnabled = true
            
            UIView.animate(withDuration: 0.2) {
                self.roomInputRow.alpha = 1
            }
        } else {
            
            view.endEditing(true)
            
        }
//        else if roomInputRow.textField.isFirstResponder {
////            guard let activeBuilding = activeBuilding else {
////                print("Could not get active building")
////                return
////            }
////            let selectedIndex = roomPicker.selectedRow(inComponent: 0)
////            let selectedRoom = activeBuilding.rooms[selectedIndex]
////
////            roomInputRow.textField.text = selectedRoom
//            roomInputRow.textField.resignFirstResponder()
//
//            navigationItem.rightBarButtonItem?.isEnabled = true
//
//        }
        view.endEditing(true)
    }
    
    @objc private func buildingRowTapped() {
        let buildingChoiceVC = BuildingChoiceViewController()
        buildingChoiceVC.delegate = self
        navigationController?.pushViewController(buildingChoiceVC, animated: true)
    }

}

extension DeliveryDestinationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel();
        label.frame.size.width = self.view.frame.width - 32
        label.lineBreakMode = .byWordWrapping;
        label.numberOfLines = 0;
        label.textAlignment = .center
        label.text = ProductionData.mainBuildings[row]
        label.sizeToFit()
        return label;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case buildingPicker:
            return ProductionData.mainBuildings.count
//        case roomPicker:
//            if let building = activeBuilding {
//                return building.rooms.count
//            } else {
//                return 0
//            }
        default:
            return 0
        }
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        switch pickerView {
//        case buildingPicker:
//            return ProductionData.buildings[row]
////        case roomPicker:
////            if let building = activeBuilding {
////                return building.rooms[row]
////            } else {
////                return ""
////            }
//        default:
//            return ""
//        }
//    }
    
    
    
}

extension DeliveryDestinationViewController: BuildingChoiceViewControllerDelegate {
    func buildingPicked(building: String) {
        buildingInputRow.textField.text = building
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
}
