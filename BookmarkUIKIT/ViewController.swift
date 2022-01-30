//
//  ViewController.swift
//  BookmarkUIKIT
//
//  Created by Aisaule Sibatova on 27.01.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "bg")
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "Save all interesting links in one app"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Let's start collection", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 16
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
       setLayout()
       
        }
    
    @objc func buttonAction() {
        print("pressed")
//        self.navigationController?.pushViewController(AddViewController(), animated: false)
        self.navigationController?.present(AddViewController(), animated: true, completion: nil)
    }
    
    private func setLayout() {
        view.insertSubview(imageView, at: 0)
        view.addSubview(button)
        view.addSubview(label)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
        
        button.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
      
        label.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(button.snp.top).offset(-16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)

        }
    }
}


