//
//  ConfirmRacePresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 17/05/23.
//

import Foundation

public class ConfirmRacePresenter {
    
    private let getAuthUser: GetAuthUser
    private let confirmRace: ConfirmRace
    private let parameter: ConfirmRaceParameter
    private let loadingView: LoadingView
    private let alertView: AlertView
    private let mapView: ConfirmRaceMapView
    private let geocodeLocation: GeocodeLocationManager
    
    public init(getAuthUser: GetAuthUser,
                confirmRace: ConfirmRace,
                parameter: ConfirmRaceParameter,
                loadingView: LoadingView,
                alertView: AlertView,
                mapView: ConfirmRaceMapView,
                geocodeLocation: GeocodeLocationManager) {
        self.getAuthUser = getAuthUser
        self.confirmRace = confirmRace
        self.parameter = parameter
        self.loadingView = loadingView
        self.alertView = alertView
        self.mapView = mapView
        self.geocodeLocation = geocodeLocation
    }
    
    public func load() {
        let point = makePointAnnotation()
        self.mapView.showPointAnnotation(point: point)
        self.mapView.setRegion(center: point.location, latitudinalMeters: 200, longitudinalMeters: 200)
    }
    
    public func didConfirmRace() {
        guard let user = getAuthUser.get() else { return }
        self.loadingView.display(viewModel: .init(isLoading: true))
        self.confirmRace.confirm(model: .init(parameter: self.parameter, driverEmail: user.email)) { [weak self] result in
            guard let self = self else { return }
            self.loadingView.display(viewModel: .init(isLoading: false))
            switch result {
            case .success:
                let point = self.makePointAnnotation()
                self.geocodeLocation.openInMaps(point: point)
            case .failure:
                self.alertView.showMessage(viewModel: .init(title: "Error", message: "Error ao tentar confirmar corrida.", buttons: [.init(title: "ok")]))
            }
        }
    }
    
    private func makePointAnnotation() -> PointAnnotationModel {
        let location = LocationModel(latitude: self.parameter.race.latitude, longitude: self.parameter.race.longitude)
        return PointAnnotationModel(title: self.parameter.race.name, location: location)
    }
}

private extension ConfirmRaceModel {
    
    convenience init(parameter: ConfirmRaceParameter, driverEmail: String) {
        self.init(email: parameter.race.email,
                  name: parameter.race.name,
                  latitude: parameter.race.latitude,
                  longitude: parameter.race.longitude,
                  driverLatitude: parameter.driverLocation.latitude,
                  driverLongitude: parameter.driverLocation.longitude,
                  driverEmail: driverEmail)
    }
}
