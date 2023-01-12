//
//  WeatherData.swift
//  iWeather
//
//  Created by Prabh Simran Singh on 31/10/22.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let coord: Coord
    let main: Main
    let weather: [Weather]
    let visibility : Double
}

struct Main: Codable {
    let temp: Double
    let humidity: Double
    let pressure: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

struct Coord: Codable{
    let lon: Double
    let lat: Double
}

