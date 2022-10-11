//
//  ViewController.swift
//  LLDB workshops
//
//  Created by Patryk Budzinski on 10/10/2022.
//

import UIKit
import Combine

final class ViewController: UIViewController {
    private lazy var descriptionLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .systemFont(ofSize: 24, weight: .regular)
        v.textColor = .systemBlue
        v.text = "You clicked the button"
        return v
    }()
    
    private lazy var counterLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .systemFont(ofSize: 64, weight: .bold)
        v.textColor = .systemBlue
        v.text = "0"
        return v
    }()
    
    private lazy var timesLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .systemFont(ofSize: 24, weight: .regular)
        v.textColor = .systemBlue
        v.text = "times!"
        return v
    }()
    
    private lazy var button: UIButton = {
        var c = UIButton.Configuration.tinted()
        c.title = "Click here!"
        let v = UIButton(configuration: c)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addTarget(nil, action: #selector(handleButtonTouch), for: .touchUpInside)
        return v
    }()
    @objc func handleButtonTouch() { vm.handleCounterIncrement() }
    
    private var vm = ViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        NSLayoutConstraint.activate(constraints)
        bindViewModel()
    }
    
    private func addSubviews() {
        view.addSubview(button)
        view.addSubview(counterLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(timesLabel)
    }
    
    private func bindViewModel() {
        vm.$counter
            .map { "\($0)" }
            .assign(to: \.text, on: counterLabel)
            .store(in: &cancellables)
    }
    
    private var constraints: [NSLayoutConstraint] {
        [
            // counterLabel
            counterLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            // descriptionLabel
            descriptionLabel.bottomAnchor.constraint(equalTo: counterLabel.topAnchor, constant: -15),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            // timesLabel
            timesLabel.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 15),
            timesLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            // button
            button.topAnchor.constraint(equalTo: timesLabel.bottomAnchor, constant: 20),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ]
    }
}
