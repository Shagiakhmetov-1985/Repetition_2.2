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
    
    var colorMain: UIColor!
    var delegate: SettingMulticolorViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Multiview color
//        multicolorView.backgroundColor = colorMain
        setSliders()
        
        //View
        multicolorView.layer.shadowColor = UIColor.black.cgColor
        multicolorView.layer.shadowOffset = CGSize(width: 2, height: 2)
        multicolorView.layer.shadowRadius = 5
        multicolorView.layer.shadowOpacity = 0.6
        
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
        
        //Start value
        setColor()
        labelColor(for: labelRed, labelGreen, labelBlue)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        
        switch sender {
        case sliderRed:
            labelColor(for: labelRed)
        case sliderGreen:
            labelColor(for: labelGreen)
        default:
            labelColor(for: labelBlue)
        }
    }
    
    @IBAction func doneButton() {
        delegate.setColorValue(color: multicolorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
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
    
    private func string(from text: UISlider) -> String {
        String(format: "%.2f", text.value)
    }
    
    private func setColor() {
        multicolorView.backgroundColor = UIColor(
            red: CGFloat(sliderRed.value),
            green: CGFloat(sliderGreen.value),
            blue: CGFloat(sliderBlue.value),
            alpha: 1
        )
    }
    
    private func setSliders() {
        let color = CIColor(color: colorMain)
        
        sliderRed.value = Float(color.red)
        sliderGreen.value = Float(color.green)
        sliderBlue.value = Float(color.blue)
    }
}

