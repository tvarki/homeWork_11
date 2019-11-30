//
//  ThirdController.swift
//  homeWork_11
//
//  Created by Дмитрий Яковлев on 28.11.2019.
//  Copyright © 2019 Дмитрий Яковлев. All rights reserved.
//

import UIKit

//MARK:- ThirdController
class ThirdController: UIViewController {
    
    var menu = Menu()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = Menu(frame: CGRect(x: -220, y: 80 ,width: 220 , height: 220),view: 2,items: ["Первый","Второй","Третий","Четвертый"])
        menu.delegate = self
        view.addSubview(menu)
        menu.delegate = self
    }
    
    //MARK:- MenuAction Item Clicked
    @IBAction func menuClicked(_ sender: UIButton) {
        menu.animateTo(menu: menu)
    }
}

//MARK:- ExtensionMenuDelegate
extension ThirdController : MenuDelegate {
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
            viewController = storyboard.instantiateViewController(withIdentifier: "First")
            
        }
//        UIApplication.shared.keyWindow?.rootViewController = viewController
        navigationController?.setViewControllers([viewController], animated: false)
        
    }
}

