//
//  ViewController.swift
//  WeatherApp
//
//  Created by LeavingStone on 24.12.15.
//  Copyright © 2015 Tinatin Charkviani. All rights reserved.
//

import UIKit
var cityName = "Tbilisi"
class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var SearchFielf: UITextField!
    @IBOutlet weak var currentLocation: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var currentWeekDay: UILabel!
    
    
    @IBOutlet weak var weatherMainDescription: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    
    @IBOutlet weak var sunriseTimeLb: UILabel!
    @IBOutlet weak var sunsetTimeLb: UILabel!
    
    
    @IBOutlet weak var windSpeedLb: UILabel!
    @IBOutlet weak var barometerLb: UILabel!
    @IBOutlet weak var humidityLb: UILabel!
    
    
    @IBOutlet weak var mainView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.SearchFielf.delegate = self
        parsingJson()

    
    }
    
    func parsingJson(){
        currentLocation.text = cityName
        
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName),uk&appid=2de143494c0b295cca9337e1e96b00e0"
        let URL = NSURL(string: url)!
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithURL(URL) { (data: NSData?,response: NSURLResponse?,error: NSError?) -> Void in
            
            
            if let responsedata = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(responsedata, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let time = json["dt"] as? Int,
                        let h = json["main"]!!["humidity"] as? Int,
                        let p = json["main"]!!["pressure"] as? Int,
                        let t = json["main"]!!["temp"] as? Int,
                        let sunrise = json["sys"]!!["sunrise"] as? Int,
                        let sunset = json["sys"]!!["sunset"] as? Int,
                        let w = json["wind"]!!["speed"] as? Double,
                        let d = json["wind"]!!["deg"] as? Int,
                        let mainDescr = ((json["weather"]! as! NSArray)[0] as! NSDictionary)["description"] {
                            let myWeatherObject: WeatheObject = WeatheObject(time: time, humidity: h, pressure: p, temperature: t, sunrise: sunrise, sunset: sunset, maindescription: mainDescr as! String, windSpeed: w, degree: d)
                            
                            let datepicker = NSTimeInterval(time + 120)
                            let date: NSDate = NSDate(timeIntervalSince1970: datepicker)
                            let formatter = NSDateFormatter()
                            formatter.dateStyle = NSDateFormatterStyle.MediumStyle
                            formatter.timeStyle = .ShortStyle
                            print(datepicker)
                            
                            
                            let timeOfSunRise = NSTimeInterval(sunrise + 180)
                            let sunriseTime = NSDate(timeIntervalSince1970: timeOfSunRise)
                            let calendar = NSCalendar.currentCalendar()
                            let comp = calendar.components([.Hour, .Minute], fromDate: sunriseTime)
                            let hourOfSunRise = comp.hour
                            let minuteOfSunRise = comp.minute
                            
                            
                            let timeOfSunset = NSTimeInterval(sunset + 180)
                            let sunsetTime: NSDate = NSDate(timeIntervalSince1970: timeOfSunset)
                            let compset = calendar.components([.Hour, .Minute], fromDate: sunsetTime)
                            let hourOfSunset = compset.hour
                            let minuteOfSunset = compset.minute
                            
                            
                            let datestring: String = formatter.stringFromDate(date)
                            self.currentDate.text = "\(datestring)"
                            
                            self.humidityLb.text = "\(myWeatherObject.humidity)%"
                            
                            self.barometerLb.text = "\(myWeatherObject.pressure)hPa"
                            
                            self.weatherMainDescription.text = myWeatherObject.mainDescription
                            
                            self.sunriseTimeLb.text = "\(hourOfSunRise):\(minuteOfSunRise)am"
                            
                            self.sunsetTimeLb.text = "\(hourOfSunset):\(minuteOfSunset)pm"
                            self.temperature.text = "\(myWeatherObject.temperature - 273)\u{00B0}"
                            self.windSpeedLb.text = "\(myWeatherObject.windSpeed)mph"
                            print("fbdgdf")
                            print("\(mainDescr)")
                            
                    }
                    
                    print (json)
                } catch {
                    print("could not serialiaze")
                }
            }
            print(error.debugDescription)
            }.resume()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }


    func textFieldDidEndEditing(textField: UITextField) {
        if SearchFielf.text != nil && SearchFielf.text != "" {
            currentLocation.text = SearchFielf.text
            cityName = SearchFielf.text!.capitalizedString
            parsingJson()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}

