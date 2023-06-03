//
//  AddressSearchView.swift
//  UberClone
//
//  Created by Gilberto Silva on 02/06/23.
//

import Foundation
import UIKit

public class AddressSearchView: UIView {
    
    let mainStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 5
        return view
    }()
    
    let originField: SearchFieldView = {
        let view = SearchFieldView()
        view.text = "Meu Local"
        view.markerColor = .green
        view.isInputTexEnabled = false
        return view
    }()
    
    let destinyField: SearchFieldView = {
        let view = SearchFieldView()
        view.placeHolder = "Digite seu destino"
        view.markerColor = .lightGray
        return view
    }()
    
    public init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ViewCode
extension AddressSearchView: ViewCode {
    func setupViewHierarchy() {
        mainStack.addArrangedSubviews([originField, destinyField])
        self.addSubview(mainStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            self.mainStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            self.mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.backgroundColor = .white
        self.alpha = 0.9
    }
    
}
