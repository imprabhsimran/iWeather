//
//  Networking.swift
//  iWeather
//
//  Created by Prabh Simran Singh on 31/10/22.
//

import Foundation
import SwiftUI
import MapKit

final class Networking: NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var location = ""
    @Published var name = ""
    @Published var visiblity = 0.0
    @Published var temp : Double?
    @Published var humidity: Double?
    @Published var pressure: Double?
    @Published var lon: Double?
    @Published var lat: Double?
    
    func getWeather() async {
        let weatherURL =  "https://api.openweathermap.org/data/2.5/weather?q=\(location)&appid=c7f1b9a9d56893d28d450a0b3f250214"

        guard let url = URL(string: weatherURL) else {
            return
        }
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(WeatherData.self, from: data) {
                name = decodedResponse.name
                visiblity = decodedResponse.visibility
                temp = decodedResponse.main.temp
                humidity = decodedResponse.main.humidity
                pressure = decodedResponse.main.pressure
                lon = decodedResponse.coord.lon
                lat = decodedResponse.coord.lat
                }
            }catch {
                print("error")
        }
    }
    
    func userWeather(coordinate: CLLocationCoordinate2D) async {
        let userLocUrl = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=c7f1b9a9d56893d28d450a0b3f250214"
        print(userLocUrl)
        
        guard let url = URL(string: userLocUrl) else {
            return
        }
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(WeatherData.self, from: data) {
                name = decodedResponse.name
                visiblity = decodedResponse.visibility
                temp = decodedResponse.main.temp
                humidity = decodedResponse.main.humidity
                pressure = decodedResponse.main.pressure
                lon = decodedResponse.coord.lon
                lat = decodedResponse.coord.lat
            }
        } catch {
              print("error")
        }
    }
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabelled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("loation not available")
        }
    }
    
    func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("parentel control")
        case .denied:
            print("you have denied permission")
        case .authorizedAlways,.authorizedWhenInUse:
            DispatchQueue.main.async {
                self.userLocation = locationManager.location!.coordinate
            }
        default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
