//
//  ClimatesListPresenter.swift
//  Weather
//
//  Created by Test on 12/03/21.
//

import Foundation
class ClimatesListPresenter: NSObject {
    weak private var climatesListView: ClimatesListViewController?
    
    private var weatherService: WeatherConector?
    
    private let gps: GPS = GPS()
    
    init(weaterServ: WeatherConector){
        weatherService = weaterServ
    }
    
    func attachView(view: ClimatesListViewController){
        climatesListView = view
    }
    
    func onGPS(){
        gps.onGPS()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.currentLocation()
        }
    }
    
    func currentLocation(){
        
        if let currentLocation = gps.currentLocation(){
            
            weatherService?.getWeatherByCoordinates(lat: String(currentLocation.latitude), lon: String(currentLocation.longitude)){ (data, message)  in
                
                
                self.climatesListView?.setCoordinates(lat: String(currentLocation.latitude), lon: String(currentLocation.longitude))
                
                if message == "Sucessful"{
                    if data?.data?.count != 0{
                        self.climatesListView?.setDataCurrentLocation(data: data!)
                    }else{
                        self.climatesListView?.error(title: "Climate", message: "Your climate not found")
                    }
                }else{
                    self.climatesListView?.error(title: "Climate", message: "Can't connect with cloude \nCode: \(message)")
                }
            }
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.currentLocation()
            }
        }
    }
    
    func climateCity(city: String, country: String){
        
        weatherService?.getWeatherByCity(city: city, country: country){ (data, message)  in
            
            if message == "Sucessful"{
                if data?.data?.count != 0{
                    self.climatesListView?.setDataClimateCity(data: data!)
                }else{
                    self.climatesListView?.error(title: "Climate", message: "City not found")
                }
                
            }else{
                self.climatesListView?.error(title: "Climate", message: "Can't connect with cloude \nCode: \(message)")
            }
        }
    }
}
