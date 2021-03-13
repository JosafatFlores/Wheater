//
//  WeatherConector.swift
//  Weather
//
//  Created by Test on 12/03/21.
//

import Foundation
class WeatherConector: NSObject {
    
    let subpath = "/forecast/daily"
    
    func getWeatherByCity(city: String, country: String, _ resultData: @escaping ResultWeather){
        
        var errorResponse: String = ""
        

        var apiPath = Sesion.instance.api + subpath
        apiPath += "?key=\(Sesion.instance.apiKey)"
        apiPath += "&lang=\(Sesion.instance.lang)"
        apiPath += "&city=\(city)"
        apiPath += "&country=\(country)"
        apiPath += "&days=5"
        
        print(apiPath)
        var request = URLRequest(url: URL(string: apiPath)!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            
            if let error = err {
                errorResponse = "error"
                resultData(nil, error.localizedDescription)
                print(error)
                return
            }
            let httpResponse = res as! HTTPURLResponse
            if httpResponse.statusCode == 200{
                if let data = data {
                    let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    let dataRecived:Data = (dataString?.data(using: String.Encoding.utf8.rawValue))!
                    
                    do{
                        let responseData = try JSONDecoder().decode(ResponseStruct.self, from: dataRecived)
                        
                        resultData(responseData, "Sucessful")
                    }catch let jsonErr{
                        print(jsonErr)
                        errorResponse = "error"
                        resultData(nil, errorResponse)
                    }
                }
            }else if httpResponse.statusCode == 400{
                
                resultData(nil, "The clouds are lost")
            }else if httpResponse.statusCode == 422{
                
                resultData(nil, "Can't get the clouds")
            }else {
                errorResponse = String(httpResponse.statusCode)
                resultData(nil, errorResponse)
            }
        }
        task.resume()
    }
    
    func getWeatherByCoordinates(lat: String, lon: String, _ resultData: @escaping ResultWeather){
        
        var errorResponse: String = ""
        

        var apiPath = Sesion.instance.api + subpath
        apiPath += "?key=\(Sesion.instance.apiKey)"
        apiPath += "&lang=\(Sesion.instance.lang)"
        apiPath += "&lat=\(lat)"
        apiPath += "&lon=\(lon)"
        apiPath += "&days=5"
        
        print(apiPath)
        var request = URLRequest(url: URL(string: apiPath)!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            
            if let error = err {
                errorResponse = "error"
                resultData(nil, error.localizedDescription)
                print(error)
                return
            }
            let httpResponse = res as! HTTPURLResponse
            if httpResponse.statusCode == 200{
                if let data = data {
                    let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    let dataRecived:Data = (dataString?.data(using: String.Encoding.utf8.rawValue))!
                    
                    do{
                        let responseData = try JSONDecoder().decode(ResponseStruct.self, from: dataRecived)
                        
                        resultData(responseData, "Sucessful")
                    }catch let jsonErr{
                        print(jsonErr)
                        errorResponse = "error"
                        resultData(nil, errorResponse)
                    }
                }
            }else if httpResponse.statusCode == 400{
                resultData(nil, "The clouds are lost")
            }else if httpResponse.statusCode == 422{
                resultData(nil, "Can't get the clouds")
            }else {
                errorResponse = String(httpResponse.statusCode)
                resultData(nil, errorResponse)
            }
        }
        task.resume()
    }
}
