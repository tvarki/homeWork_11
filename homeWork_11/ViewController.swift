//
//  ViewController.swift
//  homeWork_11
//
//  Created by Дмитрий Яковлев on 28.11.2019.
//  Copyright © 2019 Дмитрий Яковлев. All rights reserved.
//

import UIKit

//MARK:- ViewController
class ViewController: UIViewController {
    
    var menu = Menu()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // only first 4 items work.. Several for ScrollView Test
        menu = Menu(frame: CGRect(x: -220, y: 80 ,width: 220 , height: 220),view: 0,items: ["Первый","Второй","Третий","Четвертый","Пятый","Шестой","Седьмой","Восьмой","Девятый","Десятый","Одиннадцатый","Двенадцатый"])
        menu.delegate = self
        view.addSubview(menu)
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- MenuAction Item Clicked
    @IBAction func menuClicked(_ sender: Any) {
        menu.animateTo(menu: menu)
    }
}

//MARK:- ExtensionMenuDelegate
extension ViewController : MenuDelegate {
    func menuItemClicked(index:Int){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UIViewController
        switch index {
        case 0:
            viewController = storyboard.instantiateViewController(withIdentifier: "First")
        case 1:
            viewController = storyboard.instantiateViewController(withIdentifier: "Second")
        case 2:
            viewController = storyboard.instantiateViewController(withIdentifier: "Third")
        case 3:
            viewController = storyboard.instantiateViewController(withIdentifier: "Fourth")
        default:
            showToast(message: "В разработке", font: .systemFont(ofSize: 18))
            return
        }
    
//        UIApplication.shared.keyWindow?.rootViewController = viewController
        navigationController?.setViewControllers([viewController], animated: false)
    }
}


extension ViewController {

func showToast(message : String, font: UIFont) {

       let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
