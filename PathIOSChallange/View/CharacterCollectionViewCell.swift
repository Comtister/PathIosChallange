//
//  CharacterTableViewCell.swift
//  PathIOSChallange
//
//  Created by Oguzhan Ozturk on 9.03.2022.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    private var label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var title : String{
        get{
            return label.text ?? ""
        }set{
            label.text = newValue
        }
    }
    
    var characterImageView : UIImageView = {
        let favIconView = UIImageView()
        favIconView.translatesAutoresizingMaskIntoConstraints = false
        return favIconView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 2
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 10
        
        self.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
                
        self.addSubview(characterImageView)
        characterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        characterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        characterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        characterImageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
