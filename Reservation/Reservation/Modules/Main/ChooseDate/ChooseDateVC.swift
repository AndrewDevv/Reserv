//
//  ChooseDateVC.swift
//  Reservation
//
//  Created by Андрей Антонов on 23.10.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import UIKit

final class ChooseDateVC: UIViewController {
    
    private let arrowBottomImage = UIImageView(image: UIImage(named: "arrowBottom"))
    private let clockStartImage = UIImageView(image: UIImage(named: "clock"))
    private let clockFinishImage = UIImageView(image: UIImage(named: "clock"))
    private let calendarImage = UIImageView(image: UIImage(named: "calendar"))
    
    private let labelDate: UILabel = {
        let label = UILabel()
        label.text = "Выберите время"
        label.textColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 23)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let startTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время начало"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let finishTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время завершения"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var reservationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Забронировать", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let box: UIView = {
        let box = UIView()
        box.backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        box.layer.cornerRadius = 15
        return box
    }()
    
    private let changeDateField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        textField.layer.cornerRadius = 5
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowRadius = 5
        textField.layer.shadowOpacity = 0.5
        textField.addTarget(self, action: #selector(tapOnText), for: .touchDown)
        return textField
    }()
    
    private let changeStartTimeField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 14)
        textField.backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        textField.layer.cornerRadius = 5
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowRadius = 5
        textField.layer.shadowOpacity = 0.5
        textField.addTarget(self, action: #selector(tapOnStartTimeField), for: .touchDown)
        return textField
    }()
    
    private let changeFinishTimeField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 14)
        textField.backgroundColor = UIColor(displayP3Red: 8/255, green: 252/255, blue: 232/255, alpha: 1)
        textField.layer.cornerRadius = 5
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowRadius = 5
        textField.layer.shadowOpacity = 0.5
        textField.addTarget(self, action: #selector(tapOnFinishField), for: .touchDown)
        return textField
    }()
    
    private let stack = UIStackView()
    
    private let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showDate()
        showTime()
    }
}

private extension ChooseDateVC {
    func showDate() {
        let formatter = DateFormatter()
        datePicker.datePickerMode = .date
        formatter.dateFormat = "dd.MM.yyyy"
        changeDateField.text = formatter.string(from: datePicker.date)
    }
    
    func showTime() {
        let formatter = DateFormatter()
        datePicker.datePickerMode = .time
        formatter.dateFormat = "HH:mm"
        changeStartTimeField.text = formatter.string(from: datePicker.date)
        changeFinishTimeField.text = formatter.string(from: datePicker.date)
    }
    
    func setupUI() {
        view.addSubview(labelDate)
        view.addSubview(reservationButton)
        view.addSubview(box)
        view.addSubview(stack)
        view.addSubview(changeDateField)
        view.addSubview(changeStartTimeField)
        view.addSubview(changeFinishTimeField)
        view.addSubview(clockStartImage)
        view.addSubview(clockFinishImage)
        view.addSubview(calendarImage)
        view.addSubview(dateLabel)
        view.addSubview(datePicker)
        view.addSubview(startTimeLabel)
        view.addSubview(finishTimeLabel)
        
        arrowBottomImage.image = arrowBottomImage.image?.withRenderingMode(.alwaysTemplate)
        arrowBottomImage.tintColor = .white
        
        clockStartImage.image = clockStartImage.image?.withRenderingMode(.alwaysTemplate)
        clockStartImage.tintColor = .white
        
        clockFinishImage.image = clockFinishImage.image?.withRenderingMode(.alwaysTemplate)
        clockFinishImage.tintColor = .white
        
        calendarImage.image = calendarImage.image?.withRenderingMode(.alwaysTemplate)
        calendarImage.tintColor = .white
        
        stack.addArrangedSubview(arrowBottomImage)
        stack.addArrangedSubview(calendarImage)

        changeDateField.rightView = stack
        changeDateField.rightViewMode = .always
        
        changeStartTimeField.rightView = clockStartImage
        changeStartTimeField.rightViewMode = .always
        
        changeFinishTimeField.rightView = clockFinishImage
        changeFinishTimeField.rightViewMode = .always
        
        view.backgroundColor = .white
        
        datePicker.isHidden = true
        
        clockStartImage.image?.withRenderingMode(.alwaysTemplate)
        clockStartImage.tintColor = .white
        
        clockFinishImage.image?.withRenderingMode(.alwaysTemplate)
        clockFinishImage.tintColor = .white
        
        calendarImage.image?.withRenderingMode(.alwaysTemplate)
        calendarImage.tintColor = .white
        
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelDate.topAnchor.constraint(equalTo: view.topAnchor, constant: 98),
            labelDate.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        reservationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reservationButton.widthAnchor.constraint(equalToConstant: 165),
            reservationButton.heightAnchor.constraint(equalToConstant: 55),
            reservationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 546),
            reservationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        box.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            box.widthAnchor.constraint(equalToConstant: 300),
            box.heightAnchor.constraint(equalToConstant: 160),
            box.topAnchor.constraint(equalTo: view.topAnchor, constant: 153),
            box.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 38)
            ])
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: box.topAnchor, constant: 20),
            dateLabel.leftAnchor.constraint(equalTo: box.leftAnchor, constant: 70)
            ])
        changeDateField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeDateField.widthAnchor.constraint(equalToConstant: 130),
            changeDateField.heightAnchor.constraint(equalToConstant: 30),
            changeDateField.topAnchor.constraint(equalTo: box.topAnchor, constant: 45),
            changeDateField.leftAnchor.constraint(equalTo: box.leftAnchor, constant: 20)
            ])
        startTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startTimeLabel.topAnchor.constraint(equalTo: box.topAnchor, constant: 20),
            startTimeLabel.rightAnchor.constraint(equalTo: box.rightAnchor, constant: -30)
            ])
        finishTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            finishTimeLabel.topAnchor.constraint(equalTo: box.topAnchor, constant: 90),
            finishTimeLabel.centerXAnchor.constraint(equalTo: box.centerXAnchor)
            ])
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        changeStartTimeField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeStartTimeField.widthAnchor.constraint(equalToConstant: 80),
            changeStartTimeField.heightAnchor.constraint(equalToConstant: 30),
            changeStartTimeField.topAnchor.constraint(equalTo: box.topAnchor, constant: 45),
            changeStartTimeField.rightAnchor.constraint(equalTo: box.rightAnchor, constant: -30)
            ])
        changeFinishTimeField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeFinishTimeField.widthAnchor.constraint(equalToConstant: 80),
            changeFinishTimeField.heightAnchor.constraint(equalToConstant: 30),
            changeFinishTimeField.topAnchor.constraint(equalTo: box.topAnchor, constant: 115),
            changeFinishTimeField.centerXAnchor.constraint(equalTo: box.centerXAnchor)
            ])
        arrowBottomImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrowBottomImage.widthAnchor.constraint(equalToConstant: 20),
            arrowBottomImage.heightAnchor.constraint(equalToConstant: 20),
            arrowBottomImage.rightAnchor.constraint(equalTo: calendarImage.leftAnchor, constant: -5)
            ])
        calendarImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarImage.widthAnchor.constraint(equalToConstant: 20),
            calendarImage.heightAnchor.constraint(equalToConstant: 20)
            ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.widthAnchor.constraint(equalToConstant: 40),
            stack.heightAnchor.constraint(equalToConstant: 20),
            stack.rightAnchor.constraint(equalTo: changeDateField.rightAnchor, constant: -5)
            ])
    }
}

// MARK: - Tap on custom view
private extension ChooseDateVC {
    @objc func tapOnText() {
        showDatePiker()
        datePicker.isHidden = false
    }
    
    func showDatePiker() {
        datePicker.backgroundColor = .white
        datePicker.datePickerMode = .date
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDateButton))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDateButton))
        
        toolBar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        changeDateField.inputAccessoryView = toolBar
    }
    
    @objc func doneDateButton() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        changeDateField.text = dateFormatter.string(from: datePicker.date)
        datePicker.isHidden = true
        self.view.endEditing(true)
    }
    
    @objc func cancelDateButton() {
        datePicker.isHidden = true
        self.view.endEditing(true)
    }
}

// MARK: - Change start time
private extension ChooseDateVC {
    @objc func tapOnStartTimeField() {
        showStartPicker()
        datePicker.isHidden = false
    }
    
    func showStartPicker() {
        datePicker.backgroundColor = .white
        datePicker.datePickerMode = .time
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneStartTime))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelStartTime))
        
        toolBar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        changeStartTimeField.inputAccessoryView = toolBar
    }
    
    @objc func doneStartTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        changeStartTimeField.text = formatter.string(from: datePicker.date)
        datePicker.isHidden = true
        self.view.endEditing(true)
    }
    
    @objc func cancelStartTime() {
        datePicker.isHidden = true
        self.view.endEditing(true)
    }
}

// MARK: - Change finish time
private extension ChooseDateVC {
    @objc func tapOnFinishField() {
        showFinishPicker()
        datePicker.isHidden = false
    }
    
    func showFinishPicker() {
        datePicker.backgroundColor = .white
        datePicker.datePickerMode = .time
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DoneFinishTime))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CancelFinishTime))
        
        toolBar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        changeFinishTimeField.inputAccessoryView = toolBar
    }
    
    @objc func DoneFinishTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        changeFinishTimeField.text = formatter.string(from: datePicker.date)
        datePicker.isHidden = true
        self.view.endEditing(true)
    }
    
    @objc func CancelFinishTime() {
        datePicker.isHidden = true
        self.view.endEditing(true)
    }
}
