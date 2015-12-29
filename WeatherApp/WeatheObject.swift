//
//  WeatheObject.swift
//  WeatherApp
//
//  Created by LeavingStone on 28.12.15.
//  Copyright © 2015 Tinatin Charkviani. All rights reserved.
//

import Foundation
import UIKit

class WeatheObject: NSObject {
    private var _time: Int!
    
    //var main: NSObject!
    private var _humidity: Int!
    private var _pressure: Int!
    private var _temperature: Int!
    
    private var _sunrise: Int!
    private var _sunset: Int!
    
    private var _maindescription: String!
    private var _windSpeed: Double!
    private var _degree: Int!
    
      
    
    init(time: Int, humidity: Int,pressure: Int, temperature: Int, sunrise: Int, sunset: Int, maindescription: String, windSpeed: Double, degree: Int){
        _time = time
        _humidity = humidity
        _pressure = pressure
        _temperature = temperature
        
        _sunrise = sunrise
        _sunset = sunset
        
        _maindescription = maindescription
        _windSpeed = windSpeed
        _degree = degree
    }
    
    var time:Int {
        get{
            return _time
        }
    }
    
    var humidity: Int {
        get{
            return _humidity
        }
    }
    
    var pressure: Int {
        get{
            return _pressure
        }
    }
    
    var temperature: Int{
        get{
            return _temperature
        }
    }
    
    var sunrise: Int {
        get{
            return _sunrise
        }
    }
    
    var sunset: Int {
        get{
            return _sunset
        }
    }
    
    var mainDescription: String {
        get{
            return _maindescription
        }
    }
    
    var windSpeed: Double {
        get{
            return _windSpeed
        }
    }
    
    var degree: Int{
        get{
            return _degree
        }
    }
    
    
    
}
