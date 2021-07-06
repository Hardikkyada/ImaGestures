//
//  ViewController.swift
//  ImaGestures
//
//  Created by DCS on 05/07/21.
//  Copyright © 2021 HRK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    private let text:UILabel = {
        let text = UILabel()
        text.text = "Click on the Image To Add new image."
        return text
    }()
    
    
    private let customview:UIView = {
        let view = UIView()
        //view.layer.borderColor = UIColor.lightGray.cgColor
        //view.layer.borderWidth = 5
        //view.backgroundColor = .red
        return view
    }()
    
    private let imagepic:UIImagePickerController = {
        let imgpic = UIImagePickerController()
        imgpic.allowsEditing = false
        return imgpic
    }()
    
    private let imgv:UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFit
        imgv.image = UIImage(named: "back1")
        return imgv
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imgv.isUserInteractionEnabled = true
        
        let tapg = UITapGestureRecognizer(target: self, action: #selector(ontap(_:)))
        tapg.numberOfTapsRequired = 1
        imgv.isUserInteractionEnabled = true
        imgv.addGestureRecognizer(tapg)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(onpinch(_:)))
        imgv.addGestureRecognizer(pinch)
        
        let rotede = UIRotationGestureRecognizer(target: self, action: #selector(onroted(_:)))
        imgv.addGestureRecognizer(rotede)
        
        
        
        let swiperigth = UISwipeGestureRecognizer(target: self, action: #selector(onswipe(_:)))
        swiperigth.direction = .right
        customview.addGestureRecognizer(swiperigth)
        
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(onswipe(_:)))
        swipeleft.direction = .left
        customview.addGestureRecognizer(swipeleft)
        
        let swipedown = UISwipeGestureRecognizer(target: self, action: #selector(onswipe(_:)))
        swipedown.direction = .down
        customview.addGestureRecognizer(swipedown)
        
        let swipeup = UISwipeGestureRecognizer(target: self, action: #selector(onswipe(_:)))
        swipeup.direction = .up
        customview.addGestureRecognizer(swipeup)
        
        
        let pangest = UIPanGestureRecognizer(target: self, action: #selector(onpan(_:)))
        imgv.addGestureRecognizer(pangest)
        
        view.addSubview(customview)
        view.addSubview(text)
        //view.addSubview(imgv)
        customview.addSubview(imgv)
        imagepic.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        text.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 2, width: view.width - 60, height: 80)
        customview.frame = CGRect(x: 20, y: text.bottom + 2, width: view.width - 60, height: view.fullscrh)
        
    
        imgv.frame = CGRect(x: 20, y: (customview.height/2) - 200, width: customview.width - 60, height: 250)
    }
    
    @objc func ontap(_ sender:UITapGestureRecognizer){
        imagepic.sourceType = .photoLibrary
        
        DispatchQueue.main.async {
            self.present(self.imagepic,animated: true)
        }
        
        text.isHidden = true
    }
    
    
    @objc func onpinch(_ sender:UIPinchGestureRecognizer){
        print("pinch....")
        /*self.view.bringSubviewToFront(imgv)
        sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1.0*/
        //let minscale = 0
        //let maxscale = 10
        
        imgv.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
        //sender.scale = 1.0
    }
    
    @objc func onroted(_ sender:UIRotationGestureRecognizer){
        print("roated")
        imgv.transform = imgv.transform.rotated(by: sender.rotation)
        //sender.rotation = 1.0
    }
    
    @objc func onswipe(_ sender:UISwipeGestureRecognizer){
        print("swipe")
        if sender.direction == .right{
            print("Right Swiped")
            UIView.animate(withDuration: 1.0) {
                self.imgv.frame = CGRect(x: self.imgv.left + 20, y: self.imgv.top , width: self.imgv.width, height: self.imgv.height)
            }
            
        }else if sender.direction == .left {
            print("Left Swiped")
            
            UIView.animate(withDuration: 1.0) {
                self.imgv.frame = CGRect(x:  self.imgv.left - 20 , y: self.imgv.top , width: self.imgv.width, height: self.imgv.height)
            }
        }else if sender.direction == .up{
            print("up")
            UIView.animate(withDuration: 1.0) {
                self.imgv.frame = CGRect(x:  self.imgv.left , y: self.imgv.top - 20 , width: self.imgv.width, height: self.imgv.height)
            }
        }else if sender.direction == .down{
            print("down")
            UIView.animate(withDuration: 1.0) {
                
                self.imgv.frame = CGRect(x:  self.imgv.left , y: self.imgv.top + 20 , width: self.imgv.width, height: self.imgv.height)
            }
        }
    }
    
    @objc func onpan(_ sender:UIPanGestureRecognizer){
        print("pen")
        
        if sender.state == .changed{
            let translation = sender.translation(in: imgv)
            
            imgv.center = CGPoint(x: imgv.center.x + translation.x, y: imgv.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: imgv)
        }
    }
   
}


extension ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            print("selected")
            imgv.image = selectedImage
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

