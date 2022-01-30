//
//  CustomTableViewCell.swift
//  BookmarkUIKIT
//
//  Created by Aisaule Sibatova on 27.01.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    var bookMarks = [BookMarks] ()
    var customView:UIView = {
       let customView = UIView()
        return customView
    }()
    
    var title: UILabel = {
        let title = UILabel()
        return title
    }()
    
    var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "link")
        
        return image
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addView() {
        self.addSubview(customView)
        [title, image].forEach {customView.addSubview($0)}
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }
        
        image.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-12)
        }
        customView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-1)
            make.height.equalTo(50)
            
        }
        
    }
    
    func configure(name: String) {
        title.text = name
    }

}
