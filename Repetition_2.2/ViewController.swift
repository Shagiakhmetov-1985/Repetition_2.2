//
//  ViewController.swift
//  Repetition_2.2
//
//  Created by Marat Shagiakhmetov on 06.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var multicolorView: UIView!
    
    @IBOutlet weak var labelRed: UILabel!
    @IBOutlet weak var labelGreen: UILabel!
    @IBOutlet weak var labelBlue: UILabel!
    
    @IBOutlet weak var sliderRed: UISlider!
    @IBOutlet weak var sliderGreen: UISlider!
    @IBOutlet weak var sliderBlue: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        sliderRed.value = 0.2
        sliderGreen.value = 0.4
        sliderBlue.value = 0.6
        
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
}

