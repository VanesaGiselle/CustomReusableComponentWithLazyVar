//
//  ViewController.swift
//  LayoutWithLazyVarAndPickerDelegate
//
//  Created by Vanesa Korbenfeld on 21/01/2022.
//

import UIKit

class ViewController: UIViewController {
    lazy var firstButton = createFirstButton()
    lazy var secondButton = createSecondButton()
    lazy var thirdButton = createThirdButton()
    lazy var firstPickerWithInputOptionView = createFirstPickerWithInputOptionView()
    lazy var secondPickerWithInputOptionView = createSecondPickerWithInputOptionView()

    func createFirstButton() -> CustomButton {
        let button = CustomButton()
        button.setTitle("First Button", for: .normal)
        button.addTarget(self, action: #selector(onTappedFirstButton), for: .touchUpInside)
        return button
    }
    
    func createSecondButton() -> CustomButton {
        let button = CustomButton()
        button.setTitle("Second Button", for: .normal)
        button.addTarget(self, action: #selector(onTappedSecondButton), for: .touchUpInside)
        return button
    }
    
    func createThirdButton() -> CustomButton {
        let button = CustomButton()
        button.setTitle("Third Button", for: .normal)
        button.addTarget(self, action: #selector(onTappedThirdButton), for: .touchUpInside)
        return button
    }
    
    func createFirstPickerWithInputOptionView() -> PickerWithInputOptionView {
        let pickerWithInput = PickerWithInputOptionView()
        pickerWithInput.descriptionLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        pickerWithInput.optionArray = ["option 1", "option 2"]
        pickerWithInput.inputTextfield.placeholder = "Custom option"
        return pickerWithInput
    }
    
    func createSecondPickerWithInputOptionView() -> PickerWithInputOptionView {
        let pickerWithInput = PickerWithInputOptionView()
        pickerWithInput.descriptionLabel.text = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered."
        pickerWithInput.optionArray = ["account 1", "account 2"]
        pickerWithInput.inputTextfield.placeholder = "Custom account"
        return pickerWithInput
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let principalStackView = UIStackView(arrangedSubviews: [firstButton, secondButton, thirdButton, firstPickerWithInputOptionView, secondPickerWithInputOptionView])
        principalStackView.distribution = .fill
        principalStackView.axis = NSLayoutConstraint.Axis.vertical
        principalStackView.alignment = UIStackView.Alignment.fill
        principalStackView.spacing = 16.0
        principalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(principalStackView)

        NSLayoutConstraint.activate([
            principalStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            principalStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            principalStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            principalStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func onTappedFirstButton() {
        //To do
    }
    
    @objc func onTappedSecondButton() {
        //To do
    }
    
    @objc func onTappedThirdButton() {
        //To do
    }
}


class PickerWithInputOptionView: UIStackView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    lazy var descriptionLabel = createDescriptionLabel()
    var optionArray: [String] = []
    lazy var optionPicker = createOptionPicker()
    lazy var inputTextfield = createInputTextfield()
    
    func createDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }
    
    func createOptionPicker() -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }
    
    func createInputTextfield() -> UITextField {
        let textfield = UITextField()
        textfield.textAlignment = .center
        textfield.font = UIFont.systemFont(ofSize: 14)
        textfield.borderStyle = .roundedRect
        textfield.delegate = self
        textfield.addTarget(self, action: #selector(self.inputTextFieldChanged), for: .editingChanged)
        return textfield
    }
    
    func setupView() {
        self.axis = NSLayoutConstraint.Axis.vertical
        self.alignment = UIStackView.Alignment.fill
        self.translatesAutoresizingMaskIntoConstraints = false
        self.distribution = .fill
        
        optionPicker.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.addArrangedSubview(descriptionLabel)
        self.addArrangedSubview(optionPicker)
        self.addArrangedSubview(inputTextfield)
    }
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return optionArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       let row = optionArray[row]
       return row
    }
    
    @objc func inputTextFieldChanged() {
        if inputTextfield.text == nil || inputTextfield.text == "" {
            optionPicker.isUserInteractionEnabled = true
            optionPicker.setValue(UIColor.black, forKey: "textColor")
        } else {
            optionPicker.isUserInteractionEnabled = false
            optionPicker.setValue(UIColor.lightGray, forKey: "textColor")
            optionPicker.backgroundColor = .white
        }
    }
}

class CustomButton: UIButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    func setupView() {
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        self.setTitleColor(.systemBlue, for: .normal)
    }
}
