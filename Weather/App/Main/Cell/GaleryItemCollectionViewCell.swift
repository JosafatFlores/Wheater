//
//  GaleryItemCollectionViewCell.swift
//  Weather
//
//  Created by Test on 12/03/21.
//

import UIKit

class GaleryItemCollectionViewCell: UICollectionViewCell {
    
    private var changeColorFont = false
    
    private let thumbnailImg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loadingImage")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let dateLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor(named: "fontSecundary")
        label.font = UIFont(name: "System", size: 10.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let maxLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.textColor = UIColor(named: "fontSecundary")
        label.font = UIFont(name: "System", size: 10.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor(named: "fontSecundary")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func cahgeFontColorLabels(){
        self.changeColorFont = true
    }
    
    func setThumbnailImg(urlString: String){
        self.thumbnailImg.load(urlString: urlString)
    }
    
    func setDateLbl(dateLbl: String){
        self.dateLbl.text = dateLbl
    }
    
    func setMinLbl(minLbl: String){
        self.minLbl.text = "Min: \(minLbl)º"
    }
    
    func setMaxLbl(maxLbl: String){
        self.maxLbl.text = "Max: \(maxLbl)º"
    }
    
    func setDescriptionLbl(descriptionLbl: String){
        self.descriptionLbl.text = descriptionLbl
    }
    
    
    func createCell(){
        
        self.addSubview(thumbnailImg)
        self.addSubview(dateLbl)
        self.addSubview(minLbl)
        self.addSubview(maxLbl)
        self.addSubview(descriptionLbl)
        
        dateLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        dateLbl.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        dateLbl.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        dateLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        minLbl.topAnchor.constraint(equalTo: dateLbl.bottomAnchor, constant: 3).isActive = true
        minLbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        minLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        minLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        maxLbl.topAnchor.constraint(equalTo: dateLbl.bottomAnchor, constant: 3).isActive = true
        maxLbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        maxLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        maxLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        thumbnailImg.topAnchor.constraint(equalTo: minLbl.bottomAnchor).isActive = true
        thumbnailImg.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        thumbnailImg.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        thumbnailImg.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        descriptionLbl.topAnchor.constraint(equalTo: thumbnailImg.bottomAnchor, constant: 3).isActive = true
        descriptionLbl.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        descriptionLbl.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        descriptionLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        if changeColorFont == true{
            dateLbl.textColor = UIColor(named: "fontPrimary")
            minLbl.textColor = UIColor(named: "fontPrimary")
            maxLbl.textColor = UIColor(named: "fontPrimary")
            descriptionLbl.textColor = UIColor(named: "fontPrimary")
        }
    }
    
}
