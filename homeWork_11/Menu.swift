//
//  Menu.swift
//  homeWork_11
//
//  Created by Дмитрий Яковлев on 28.11.2019.
//  Copyright © 2019 Дмитрий Яковлев. All rights reserved.
//

import UIKit

//MARK:- MenuDelegateProtocol
protocol MenuDelegate: class{
    func menuItemClicked(index:Int)
}

var backgroundTask: UIBackgroundTaskIdentifier = .invalid

//MARK:- Menu Class
class Menu: UIView {
    
    weak var delegate : MenuDelegate?
    private var task : DispatchWorkItem?
    private var y = 0
    private var viewButton : UIButton!
    private var closeViewButton : UIButton!
    private var scrollView: UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //MARK:- Menu Class init with curent View Number and list of menu ItemsName
    init(frame: CGRect, view: Int, items: [String]) {
        super.init(frame:frame)
        setup(view: view, items: items)
        setBackgrountTimer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
    
    func setup(view: Int, items: [String]){
        
        scrollView = UIScrollView(frame: bounds)
        scrollView.backgroundColor = UIColor.systemGray2

        items.forEach { item in
            viewButton = UIButton(frame: CGRect(x: 10,y: self.y + 20,width: 200,height: 20))
            viewButton.setTitle(item, for: .normal)
            viewButton.tag = items.firstIndex(of: item)!
            viewButton.addTarget(self, action: #selector(onUniverseButtonClicked), for: .touchUpInside)
            if viewButton.tag == view {
                viewButton.backgroundColor = .systemBlue
                viewButton.titleLabel?.font = UIFont.italicSystemFont(ofSize: 18)
            }
            y+=20
            scrollView.addSubview(viewButton)
        }
        if y < 160{
            y = 160
        }
        closeViewButton = UIButton(frame: CGRect(x: 10,y: self.y + 40,width: 200,height: 20))
        closeViewButton.setTitle("Закрыть", for: .normal)
        closeViewButton.setTitleColor(.red, for: .normal)
        closeViewButton.addTarget(self, action: #selector(onCloseButtonClicked), for: .touchDown)
        scrollView.addSubview(closeViewButton)
        
        scrollView.contentSize = CGSize(width: 200,height: (items.count+3)*20)
        addSubview(scrollView)
    }
    
    func setBackgrountTimer(){
        backgroundTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {[weak self] in
            self?.endBackgroudTask()
        })
    }
    
    func endBackgroudTask(){
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
        //        menu.animateFrom(menu: menu)
        print ("finish")
    }
    
    //     func closeMenuItemClicked(){
    //            animateFrom(menu: self)
    //        }
    
    //MARK:- Buttons clicker actions
    @objc private func onCloseButtonClicked(){
        scrollView.setContentOffset(.zero, animated: true)
        animateFrom(menu: self)
    }
    
    @objc private func onUniverseButtonClicked(sender:UIButton){
        animateHide(menu: self)
        scrollView.setContentOffset(.zero, animated: true)
        menuItemClicked(index: sender.tag)
    }
    
    //MARK:- Functions for delegate
    func menuItemClicked(index:Int){
        delegate?.menuItemClicked(index: index)
    }
}

//MARK:- Animation Extension
extension Menu{
    
    //MARK:- Animation of menu visible. as completion async thread will exec menu close animation in 29 seconds after first animation finish
    func animateTo(menu: Menu) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [.curveEaseIn],animations: {
            menu.layer.position = CGPoint(x: 110, y: menu.layer.position.y)}
            ,completion: { isCompleted in
                guard isCompleted else { return }
                let delay = 29
                self.task = DispatchWorkItem { self.animateFrom(menu: menu) }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(delay), execute: self.task!)
        })
    }
    
    //MARK:- Menu closing + cancel thread
    func animateFrom(menu: Menu) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [.curveEaseIn],animations:  {
            menu.layer.position = CGPoint(x: -110, y: menu.layer.position.y)
        }
            ,completion: {
                isCompleted in
                guard isCompleted else { return }
                menu.layer.removeAllAnimations()
                guard self.task != nil else {return}
                self.task!.cancel()
        })
        
    }
    //MARK:- Menu visible gone
    func animateHide(menu: Menu) {
        guard self.task != nil else {return}
        self.task!.cancel()
        UIView.animate(withDuration: 0, delay: 0, options: [.curveEaseIn],animations:  {
            menu.layer.position = CGPoint(x: -110, y: menu.layer.position.y)
        })
        
    }
}
