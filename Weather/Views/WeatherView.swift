//
//  WeatherView.swift
//  Weather
//
//  Created by Jacob Pantuso on 2022-03-11.
//

import SwiftUI

func getTime() -> String {
    let formatter = DateFormatter()
    
    formatter.timeStyle = .short
    
    let dateString = formatter.string(from: Date())
    return dateString
}

func getStatus(currentHour: String) -> String {
    if currentHour.suffix(2) == "AM" {
        return "Good morning"
    }
    if Int(currentHour.prefix(1))! >= 4 || Int(currentHour.prefix(1))! <= 9 && currentHour.suffix(2) == "PM" {
        return "Good afternoon"
    }
    return "NULL"
}

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold().font(.title)
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20)
                        {
                            Image(systemName: "cloud.snow")
                                .font(.system(size: 40))
                            
                            Text(weather.weather[0].main)
                        }
                        
                        Spacer()
                        
                        .frame(width: 150, alignment: .leading)
                        Text(weather.main.feelsLike.roundDouble() + "°")
                            .font(.system(size:100))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    Spacer()
                        .frame(height: 80)
                    
                    AsyncImage(url: URL(string:"https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                    
                }
                

                .frame(maxWidth:.infinity)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            VStack {
                Spacer()
                Text(getStatus(currentHour: getTime()))
                    .font(.system(size:20))
                    .fontWeight(.bold)
                VStack(alignment: .leading, spacing: 20) {
                    Text("Detailed Forecast")
                        .bold().padding(.bottom)
                    
                    HStack {
                        WeatherRow(logo: "arrow.down", name: "Min temp", value: weather.main.tempMin.roundDouble() + "°")
                        Spacer()
                        WeatherRow(logo: "arrow.up", name: "Max temp", value: weather.main.tempMin.roundDouble() + "°")
                    }
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind speed", value: weather.wind.speed.roundDouble() + "m/s")
                        Spacer()
                        WeatherRow(logo: "humidity.fill", name: "Humidity", value: weather.main.humidity.roundDouble() + "%")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.68, saturation: 0.768, brightness: 0.4))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft,.topRight])
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.68, saturation: 0.768, brightness: 0.4))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
