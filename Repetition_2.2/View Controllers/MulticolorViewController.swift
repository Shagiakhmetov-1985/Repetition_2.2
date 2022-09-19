//
//  ViewController.swift
//  Repetition_2.2
//
//  Created by Marat Shagiakhmetov on 06.09.2022.
//

import UIKit

class MulticolorViewController: UIViewController {
    
    @IBOutlet weak var multicolorView: UIView!
    
    @IBOutlet weak var labelRed: UILabel!
    @IBOutlet weak var labelGreen: UILabel!
    @IBOutlet weak var labelBlue: UILabel!
    
    @IBOutlet weak var sliderRed: UISlider!
    @IBOutlet weak var sliderGreen: UISlider!
    @IBOutlet weak var sliderBlue: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    var colorMain: UIColor!
    var delegate: SettingMulticolorViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Multiview color
        setSliders()
        
        //View
        multicolorView.layer.shadowColor = UIColor.black.cgColor
        multicolorView.layer.shadowOffset = CGSize(width: 2, height: 2)
        multicolorView.layer.shadowRadius = 5
        multicolorView.layer.shadowOpacity = 0.6
        multicolorView.layer.cornerRadius = 15
        
        //Slider
        sliderRed.minimumValue = 0
        sliderRed.maximumValue = 1
        sliderGreen.minimumValue = 0
        sliderGreen.maximumValue = 1
        sliderBlue.minimumValue = 0
        sliderBlue.maximumValue = 1
        
        sliderRed.minimumTrackTintColor = .red
        sliderGreen.minimumTrackTintColor = .green
        sliderBlue.minimumTrackTintColor = .blue
        sliderRed.maximumTrackTintColor = .gray
        sliderGreen.maximumTrackTintColor = .gray
        sliderBlue.maximumTrackTintColor = .gray
        
        //Text field
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        //Start value
        setColor()
        labelColor(for: labelRed, labelGreen, labelBlue)
        textFieldColor(for: redTextField, greenTextField, blueTextField)
    }
    // MARK: - При смещении ползунка слайдера меняются данные лейбл и текстфилд, а также смена цвета вьюшки
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        
        switch sender {
        case sliderRed:
            labelColor(for: labelRed)
            textFieldColor(for: redTextField)
        case sliderGreen:
            labelColor(for: labelGreen)
            textFieldColor(for: greenTextField)
        default:
            labelColor(for: labelBlue)
            textFieldColor(for: blueTextField)
        }
    }
    // MARK: - Кнопка done возвращает на первый экран и передает цвет вьюшки на фон
    @IBAction func doneButton() {
        delegate.setColorValue(color: multicolorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    // MARK: - Формат лейбл в виде десятичных дробей 0.00
    private func labelColor(for values: UILabel...) {
        values.forEach { label in
            switch label {
            case labelRed:
                label.text = string(from: sliderRed)
            case labelGreen:
                label.text = string(from: sliderGreen)
            default:
                label.text = string(from: sliderBlue)
            }
        }
    }
    // MARK: - Формат текстфилд в виде десятичных дробей 0.00
    private func textFieldColor(for values: UITextField...) {
        values.forEach { textField in
            switch textField {
            case redTextField:
                textField.text = string(from: sliderRed)
            case greenTextField:
                textField.text = string(from: sliderGreen)
            default:
                textField.text = string(from: sliderBlue)
            }
        }
    }
    // MARK: - Метод для установки формата десятичных дробей 0.00
    private func string(from text: UISlider) -> String {
        String(format: "%.2f", text.value)
    }
    // MARK: - Установка цвета вьюшки
    private func setColor() {
        multicolorView.backgroundColor = UIColor(
            red: CGFloat(sliderRed.value),
            green: CGFloat(sliderGreen.value),
            blue: CGFloat(sliderBlue.value),
            alpha: 1
        )
    }
    // MARK: - От передачи цвета фона первого экрана на второй, меняются данные слайдеров
    private func setSliders() {
        let color = CIColor(color: colorMain)
        
        sliderRed.value = Float(color.red)
        sliderGreen.value = Float(color.green)
        sliderBlue.value = Float(color.blue)
    }
    // MARK: - Метод для alert сообщения на экране
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    // MARK: - Действие кнопки Done в тулбаре
    @objc private func didDoneButton() {
        view.endEditing(true)
    }
}

extension MulticolorViewController: UITextFieldDelegate {
    // MARK: - При тапании на любое свободное место завершить внос данных в тестфилд
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    // MARK: - Проверка формата данных в текстфилдах на числа
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        
        if let numberValue = Float(newValue) {
            switch textField {
            case redTextField:
                sliderRed.setValue(numberValue, animated: true)
                sliderAction(sliderRed)
            case greenTextField:
                sliderGreen.setValue(numberValue, animated: true)
                sliderAction(sliderGreen)
            default:
                sliderBlue.setValue(numberValue, animated: true)
                sliderAction(sliderBlue)
            }
            return
        }
        showAlert(title: "Wrong format!", message: "Please, type correct format from '0.00' to '1.00'")
    }
    // MARK: - При нажатии на кнопку Next на клавииатуре - завершает внос данных в текстфилд
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    // MARK: - Добавление над клавиатурой тулбара с кнопокой Done
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()

        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(didDoneButton)
        )

        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )

        keyboardToolbar.items = [flexBarButton, doneButton]
    }
}
