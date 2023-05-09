//
//  PassengerMapPresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class PassengerMapPresenter {
    private let alertView: AlertView
    private let loadingView: LoadingView
    private let requestButtonStateview: RequestButtonStateView
    private let callRace: CallRace
    private let logoutAuth: LogoutAuth
    private let cancelRace: CancelRace
    private var isCalledRace = false
    var dismiss: (() -> Void)!
    
    public init(alertView: AlertView,
                loadingView: LoadingView,
                requestButtonStateview: RequestButtonStateView,
                callRace: CallRace,
                logoutAuth: LogoutAuth,
                cancelRace: CancelRace) {
        self.alertView = alertView
        self.loadingView = loadingView
        self.callRace = callRace
        self.logoutAuth = logoutAuth
        self.cancelRace = cancelRace
        self.requestButtonStateview = requestButtonStateview
    }
    
    public func logout() {
        self.logoutAuth.logout { [weak self] isLogout in
            if isLogout {
                self?.dismiss?()
            }
        }
    }
    
    public func callRaceAction(request: CallRaceRequest) {
        if self.isCalledRace {
            requestCancelRace()
        } else {
            requestCallRace(request)
        }
    }
    
    private func requestCallRace(_ request: CallRaceRequest) {
        self.loadingView.display(viewModel: .init(isLoading: true))
        self.callRace.request(request: request) { [weak self] result in
            self?.loadingView.display(viewModel: .init(isLoading: false))
            switch result {
            case .success:
                self?.isCalledRace = true
                self?.requestButtonStateview.change(state: .cancel)
            case .failure:
                self?.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao realizar a requisição."))
            }
        }
    }
    
    private func requestCancelRace() {
        self.loadingView.display(viewModel: .init(isLoading: true))
        self.cancelRace.cancel() { [weak self] cancelResult in
            self?.loadingView.display(viewModel: .init(isLoading: false))
            switch cancelResult {
            case .success:
                self?.isCalledRace = false
                self?.requestButtonStateview.change(state: .call)
            case .failure:
                self?.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao tentar cancelar a corrida."))
            }
        }
    }
}
