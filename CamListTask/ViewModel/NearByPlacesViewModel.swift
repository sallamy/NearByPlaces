//
//  NearByPlacesViewModel.swift
//  CamListTask
//
//  Created by mohamed salah on 10/21/21.
//

import Foundation
import RxSwift
import RxRelay

enum Mode: Int {
    case realTime
    case single
    
    var title: String {
        switch self {
        case .realTime:
            return "Single"
        case .single:
            return "Real time"
        }
    }
}
class NearByPlacesViewModel {
    
    let repository = FourSquareRepository()
    let error  =  BehaviorRelay<String>(value: "")
    let isLoading = BehaviorRelay<Bool>(value: false)
    let isGetData = BehaviorRelay<Bool>(value: false)
    let places: BehaviorRelay<[Item]> = BehaviorRelay(value: [])
    var lat = ""
    var lang = ""
    var mode: Mode  {
        get {
            return Mode.init(rawValue: UserDefaults.standard.integer(forKey: "mode")) ?? .realTime
        }
    }
    var locationManager: LocationManager?
    
    init() {
        locationManager = LocationManager(self)
        locationManager?.didGetLocation = { coordinate in
            self.lat = "\(coordinate.latitude)"
            self.lang = "\(coordinate.longitude)"
            self.getPlaces()
        }
    }
    
    func startRealtime() {
        locationManager?.startUpdate()
    }
    
    func getPlaces(){
        self.isLoading.accept(true)
        repository.getPlaces(lat: lat, lang: lang) { success, response, error in
            if(success){
                if let places = response {
                    self.places.accept(places)
                    self.isLoading.accept(false)
                    self.isGetData.accept(true)
                }
            }else {
                self.isLoading.accept(false)
                self.error.accept(error ?? "")
                
            }
        }
    }
}
