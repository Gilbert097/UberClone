//
//  DriverListFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/05/23.
//

import Foundation

public final class DriverListFactory {
    
    public static func build(nav: NavigationController) -> DriverListViewController {
        let databaseAdapter = FirebaseDatabaseAdapter()
        let authAdapter = FirebaseAuthAdapter()
        let viewController = DriverListViewController()
        let router = DriverListRouter(nav: nav)
        let presenter = DriverListPresenter(getRaces: RemoteGetRaces(observeClient: databaseAdapter),
                                            logoutAuth: RemoteLogoutAuth(authLogoutClient: authAdapter),
                                            refreshListView: viewController)
        viewController.load = presenter.load
        viewController.logout = presenter.logout
        presenter.dismiss = router.dismiss
        return viewController
    }
}

