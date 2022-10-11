//
//  ConfettiView.swift
//  LLDB workshops
//
//  Created by Patryk Budzinski on 10/10/2022.
//

import UIKit

final class ConfettiView: UIView {
    private static var confettiEmoji = "🎉"
    private static var numberOfConfettis = 40
    
    private lazy var confettiViews = confettiViewsFactory()
    
    func confettiViewsFactory() -> [UIView] {
        var container = [UIView]()
        for _ in 0...Self.numberOfConfettis {
            let v = UILabel()
            v.text = Self.confettiEmoji
            v.font = .systemFont(ofSize: 64)
            container.append(v)
        }
        return container
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
    }
    
    private func setup() {
        backgroundColor = .systemGreen.withAlphaComponent(0.2)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: intrinsicContentSize.height),
            widthAnchor.constraint(equalToConstant: intrinsicContentSize.width)
        ])
        
        confettiViews
            .forEach {
                addSubview($0)
                let p = UIScreen.main.getRandomCoordinate()
                $0.frame = CGRect(origin: p, size: CGSize(width: 64, height: 64))
            }
        
        UIView.animate(withDuration: 3) {
            for view in self.confettiViews {
                view.center.y += CGFloat.random(in: 100...500)
            }
        }
        
        UIView.animate(withDuration: 2, delay: 1) {
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
}

private extension UIScreen {
    func getRandomCoordinate() -> CGPoint {
        let xRange = bounds.minX...bounds.maxX
        let yRange = bounds.minY...bounds.maxY
        return CGPoint(
            x: CGFloat.random(in: xRange),
            y: CGFloat.random(in: yRange)
        )
    }
}
