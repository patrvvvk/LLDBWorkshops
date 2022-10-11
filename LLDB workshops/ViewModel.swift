//
//  ViewModel.swift
//  LLDB workshops
//
//  Created by Patryk Budzinski on 10/10/2022.
//

import Combine
import Foundation
import UIKit

final class ViewModel {
    @Published var counter: Int = 0
    
    func handleCounterIncrement() {
        counter += 1
        if counter > 100 {
            startConfetti()
        }
    }
    
    private func startConfetti() {
        let view = ConfettiView()
        view.translatesAutoresizingMaskIntoConstraints = false
        guard let scene = UIApplication.shared.connectedScenes.first,
              let delegate = scene.delegate as? UIWindowSceneDelegate,
              let window = delegate.window else {
            return
        }
        window?.addSubview(view)
    }
}
