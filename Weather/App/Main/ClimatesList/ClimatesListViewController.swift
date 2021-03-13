//
//  ClimatesListViewController.swift
//  Weather
//
//  Created by Test on 12/03/21.
//

import UIKit

class ClimatesListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate {
    
    private var climatesListPresenter: ClimatesListPresenter = ClimatesListPresenter(weaterServ: WeatherConector())
    
    let nf = "Not Found"
    
    var currentLocationData: ResponseStruct = ResponseStruct()
    var climatesCitiesData: [ResponseStruct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        climatesCll.delegate = self
        climatesCll.dataSource = self
        climatesCll.register(GaleryItemCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        
        citiesTbl.delegate = self
        citiesTbl.dataSource = self
        citiesTbl.layer.backgroundColor = UIColor.clear.cgColor
        citiesTbl.backgroundColor = .clear
        citiesTbl.register(ClimateTableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        view.backgroundColor = UIColor(named: "background")
        climatesListPresenter.attachView(view: self)
        climatesListPresenter.onGPS()
        createView()
    }
    
    func setCoordinates(lat: String, lon: String){
        DispatchQueue.main.async { [self] in
            coordinatesLbl.text = "Lat: \(lat), lon: \(lon)"
        }
    }
    
    func setDataCurrentLocation(data: ResponseStruct){
        currentLocationData = data
        DispatchQueue.main.async { [self] in
            iconClimateImg.load(urlString: "https://www.weatherbit.io/static/img/icons/\(currentLocationData.data?[0].weather.icon ?? "").png")
            cityCountryLbl.text = "\(currentLocationData.city_name ?? nf), \(currentLocationData.country_code ?? nf)"
            climatesCll.reloadData()
        }
    }
    
    func setDataClimateCity(data: ResponseStruct){
        climatesCitiesData.append(data)
        DispatchQueue.main.async {
            self.citiesTbl.reloadData()
        }
    }
    
    private let backLocationImg: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primary")
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconClimateImg: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let cityCountryLbl: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "fontSecundary")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let coordinatesLbl: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "fontSecundary")
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
    
    private let cityTxt: UITextField = {
        let textfield = UITextField()
        textfield.textAlignment = .center
        textfield.backgroundColor = .white
        textfield.textColor = .black
        textfield.layer.cornerRadius = 15
        textfield.placeholder = "City"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let countryTxt: UITextField = {
        let textfield = UITextField()
        textfield.textAlignment = .center
        textfield.backgroundColor = .white
        textfield.textColor = .black
        textfield.layer.cornerRadius = 15
        textfield.placeholder = "Country"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let searchBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.titleLabel?.textColor = UIColor(named: "background")
        button.backgroundColor = UIColor(named: "primary")
        button.layer.cornerRadius = 15
        button.addTarget(self, action:#selector(findClimate(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let citiesTbl: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let cloudLbl: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "fontPrimary")
        label.text = "Can search clouds"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func createView(){
        
        var padding = CGFloat(50)
        let heightTxt = CGFloat(40)
        let heightLbl = CGFloat(20)
        
        if Sesion.instance.typeDevice == "phone"{
            padding = CGFloat(50)
        }else if Sesion.instance.typeDevice == "pad"{
            padding = CGFloat(150)
        }
        
        
        self.view.addSubview(backLocationImg)
        
        backLocationImg.topAnchor.constraint(equalTo: view.topAnchor, constant: -10).isActive = true
        backLocationImg.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backLocationImg.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backLocationImg.heightAnchor.constraint(equalToConstant: Sesion.instance.topPadding + 350).isActive = true
        
        backLocationImg.addSubview(iconClimateImg)
        backLocationImg.addSubview(cityCountryLbl)
        backLocationImg.addSubview(coordinatesLbl)
        backLocationImg.addSubview(climatesCll)
        
        
        iconClimateImg.topAnchor.constraint(equalTo: view.topAnchor, constant: Sesion.instance.bottomPadding).isActive = true
        iconClimateImg.leftAnchor.constraint(equalTo: backLocationImg.leftAnchor).isActive = true
        iconClimateImg.rightAnchor.constraint(equalTo: backLocationImg.rightAnchor).isActive = true
        iconClimateImg.heightAnchor.constraint(equalToConstant: 120).isActive = true
        iconClimateImg.centerXAnchor.constraint(equalTo: backLocationImg.centerXAnchor).isActive = true
        
        cityCountryLbl.topAnchor.constraint(equalTo: iconClimateImg.bottomAnchor, constant: 5).isActive = true
        cityCountryLbl.leftAnchor.constraint(equalTo: backLocationImg.leftAnchor, constant: padding).isActive = true
        cityCountryLbl.rightAnchor.constraint(equalTo: backLocationImg.rightAnchor, constant: -padding).isActive = true
        cityCountryLbl.heightAnchor.constraint(equalToConstant: heightLbl).isActive = true
        cityCountryLbl.centerXAnchor.constraint(equalTo: backLocationImg.centerXAnchor).isActive = true
        
        coordinatesLbl.topAnchor.constraint(equalTo: cityCountryLbl.bottomAnchor, constant: 5).isActive = true
        coordinatesLbl.leftAnchor.constraint(equalTo: backLocationImg.leftAnchor, constant: padding).isActive = true
        coordinatesLbl.rightAnchor.constraint(equalTo: backLocationImg.rightAnchor, constant: -padding).isActive = true
        coordinatesLbl.heightAnchor.constraint(equalToConstant: heightLbl).isActive = true
        
        climatesCll.topAnchor.constraint(equalTo: coordinatesLbl.bottomAnchor, constant: 40).isActive = true
        climatesCll.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        climatesCll.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        climatesCll.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        view.addSubview(cityTxt)
        view.addSubview(countryTxt)
        view.addSubview(searchBtn)
        view.addSubview(citiesTbl)
        view.addSubview(cloudLbl)
        
        let widthTxt = self.view.frame.width - 140
        
        cityTxt.topAnchor.constraint(equalTo: backLocationImg.bottomAnchor, constant: 15).isActive = true
        cityTxt.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        cityTxt.rightAnchor.constraint(equalTo: countryTxt.leftAnchor, constant: -5).isActive = true
        cityTxt.heightAnchor.constraint(equalToConstant: heightTxt).isActive = true
        
        countryTxt.topAnchor.constraint(equalTo: backLocationImg.bottomAnchor, constant: 15).isActive = true
        countryTxt.rightAnchor.constraint(equalTo: searchBtn.leftAnchor, constant: -5).isActive = true
        countryTxt.widthAnchor.constraint(equalToConstant: widthTxt/2).isActive = true
        countryTxt.heightAnchor.constraint(equalToConstant: heightTxt).isActive = true
        
        searchBtn.topAnchor.constraint(equalTo: backLocationImg.bottomAnchor, constant: 15).isActive = true
        searchBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        searchBtn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        searchBtn.heightAnchor.constraint(equalToConstant: heightTxt).isActive = true
        
        citiesTbl.topAnchor.constraint(equalTo: searchBtn.bottomAnchor, constant: 15).isActive = true
        citiesTbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        citiesTbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        citiesTbl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        citiesTbl.isHidden = true
        
        cloudLbl.topAnchor.constraint(equalTo: backLocationImg.bottomAnchor, constant: 150).isActive = true
        cloudLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        cloudLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        cloudLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    @objc
    func findClimate(sender: UIButton){
        climatesListPresenter.climateCity(city: cityTxt.text ?? "", country: countryTxt.text ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var rows = 0
        rows = currentLocationData.data?.count ?? 0
        return rows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCellItem: GaleryItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! GaleryItemCollectionViewCell
        
        let climate: ClimateStruct = (currentLocationData.data?[indexPath.row])!
        
        collectionCellItem.setThumbnailImg(urlString: "https://www.weatherbit.io/static/img/icons/\(climate.weather.icon).png")
        collectionCellItem.setDateLbl(dateLbl: climate.datetime)
        collectionCellItem.setMinLbl(minLbl: String(climate.min_temp))
        collectionCellItem.setMaxLbl(maxLbl: String(climate.max_temp))
        collectionCellItem.setDescriptionLbl(descriptionLbl: climate.weather.description)
        
        collectionCellItem.createCell()
        
        
        return collectionCellItem
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        rows = climatesCitiesData.count
        
        if rows != 0{
            citiesTbl.isHidden = false
            cloudLbl.isHidden = true
        }
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ClimateTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClimateTableViewCell
        
        let city: ResponseStruct = climatesCitiesData[indexPath.row]
        
        cell.setCityLbl(cityLbl: "\(city.city_name ?? ""), \(city.country_code ?? "")")
        cell.setClimateData(climateData: city.data!)
        
        cell.createCell()
        cell.backgroundColor = .clear
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func error(title: String, message: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
