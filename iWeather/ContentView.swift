//
//  ContentView.swift
//  iWeather
//
//  Created by Prabh Simran Singh on 31/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var network = Networking()
    
    var body: some View {
        NavigationView{
            List{
                HStack{
                    TextField("Enter the Location", text: $network.location)
                        .padding()
                        .foregroundColor(.blue)
                    Button{
                        Task{
                            await network.getWeather()
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }.navigationTitle("iWeather")
                HStack{
                    Text("City")
                        .foregroundColor(.gray)
                    Spacer()
                    Text(network.name)
                }
                HStack{
                    Text("Visibility")
                        .foregroundColor(.gray)
                    Spacer()
                    Text(String(format: "%.2f", network.visiblity))
                }
                HStack{
                    Text("Temperature")
                        .foregroundColor(.gray)
                    Spacer()
                    Text(String(format: "%.2f", network.temp ?? 0.0))
                    Text("F")
                }
                HStack{
                    Text("Humidity")
                        .foregroundColor(.gray)
                    Spacer()
                    Text(String(format: "%.2f", network.humidity ?? 0.0))
                }
                HStack{
                    Text("Preasure")
                        .foregroundColor(.gray)
                    Spacer()
                    Text(String(format: "%.2f", network.pressure ?? 0.0))
                }
                HStack{
                    Text("Latitude")
                        .foregroundColor(.gray)
                    Spacer()
                    Text(String(format: "%.2f", network.lat ?? 0.0))
                }
                HStack{
                    Text("Longitude")
                        .foregroundColor(.gray)
                    Spacer()
                    Text(String(format: "%.2f", network.lon ?? 0.0))
                }
//                HStack{
//                    Text("Get weather of current Location")
//                    Spacer()
//                    Button{
//                        Task{
//                            await network.userWeather(coordinate: network.userLocation!)
//                        }
//                    } label: {
//                        Image(systemName: "location")
//                            .foregroundColor(.blue)
//                    }
//                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
