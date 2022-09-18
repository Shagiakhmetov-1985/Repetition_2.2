//
//  MainViewController.swift
//  Repetition_2.2
//
//  Created by Marat Shagiakhmetov on 18.09.2022.
//

import UIKit

protocol SettingMulticolorViewController {
    func setColorValue(color: UIColor)
}

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let multicolorVC = segue.destination as? MulticolorViewController else { return }
        multicolorVC.colorMain = view.backgroundColor
        multicolorVC.delegate = self
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
}

extension MainViewController: SettingMulticolorViewController {
    func setColorValue(color: UIColor) {
        view.backgroundColor = color
    }
}
