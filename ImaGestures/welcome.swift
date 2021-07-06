//
//  welcomeVC.swift
//  RecipeApp
//
//  Created by DCS on 25/06/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class welcome: UIViewController {
    
    
    
    private let mybutton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Play", for: .normal)
        btn.addTarget(self, action: #selector(nextscreen), for: .touchUpInside)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.init(red: 0, green: 1, blue: 1, alpha: 0.6)
        btn.layer.cornerRadius = 50
        return btn
    }()
    
    private let myimageview:UIImageView = {
        let imgv = UIImageView()
        imgv.image = UIImage(named: "logo2")
        imgv.layer.cornerRadius = 50
        
        imgv.clipsToBounds = true
        return imgv
    }()
    
    @objc func nextscreen(){
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back-5")!)
        
        let bckimage = UIImageView(frame: UIScreen.main.bounds)
        bckimage.image = UIImage(named: "back-7")
        bckimage.contentMode = .scaleToFill
        self.view.insertSubview(bckimage, at: 0)
        
        //view.addSubview(mylabel)
        view.addSubview(mybutton)
        view.addSubview(myimageview)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        myimageview.frame = CGRect(x: 100, y: 200, width: 150, height: 150)
        //mylabel.frame = CGRect(x: 40, y: myimageview.bottom + 20, width: view.width - 80, height: 40)
        mybutton.frame = CGRect(x: 40, y: myimageview.bottom + 50, width: view.width - 80, height: 40)
        
    }
    
}
