//
//  ClimateTableViewCell.swift
//  Weather
//
//  Created by Test on 13/03/21.
//

import UIKit

class ClimateTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private var climateData: [ClimateStruct] = []
    
    private let cityLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor(named: "fontPrimary")
        label.font = UIFont(name: "System", size: 10.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let climatesCll: UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.itemSize = .init(width: 170, height: 180)
        
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0.0;
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.bounces = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    func setCityLbl(cityLbl: String){
        self.cityLbl.text = cityLbl
    }
    
    func setClimateData(climateData: [ClimateStruct]){
        self.climateData = climateData
    }
    
    func createCell(){
        
        climatesCll.delegate = self
        climatesCll.dataSource = self
        climatesCll.register(GaleryItemCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        
        self.addSubview(cityLbl)
        self.addSubview(climatesCll)
        
        cityLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        cityLbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        cityLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        cityLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        climatesCll.topAnchor.constraint(equalTo: cityLbl.bottomAnchor, constant: 5).isActive = true
        climatesCll.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        climatesCll.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        climatesCll.heightAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var rows = 0
        rows = climateData.count
        return rows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCellItem: GaleryItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! GaleryItemCollectionViewCell
        
        let climate: ClimateStruct = (climateData[indexPath.row])
        
        collectionCellItem.setThumbnailImg(urlString: "https://www.weatherbit.io/static/img/icons/\(climate.weather.icon).png")
        collectionCellItem.setDateLbl(dateLbl: climate.datetime)
        collectionCellItem.setMinLbl(minLbl: String(climate.min_temp))
        collectionCellItem.setMaxLbl(maxLbl: String(climate.max_temp))
        collectionCellItem.setDescriptionLbl(descriptionLbl: climate.weather.description)
        collectionCellItem.cahgeFontColorLabels()
        collectionCellItem.createCell()
        
        
        return collectionCellItem
    }
    
}
