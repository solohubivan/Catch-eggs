//
//  StartScreenViewModel.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 22.12.2025.
//

import Foundation
import Combine


final class StartScreenViewModel: ObservableObject {

    @Published var progress: Double = 0

    private let duration: Double = 2.0
    private let timerTick: Double = 0.02

    private var timer: Timer?

    func startFakeLoading(onFinished: @escaping () -> Void) {
        progress = 0
        timer?.invalidate()

        let totalSteps = Int(duration / timerTick)
        var step = 0

        timer = Timer.scheduledTimer(withTimeInterval: timerTick, repeats: true) { [weak self] timer in
            guard let self else { return }

            step += 1
            let value = (Double(step) / Double(totalSteps)) * 100

            self.progress = min(100, value)

            if self.progress >= 100 {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    onFinished()
                }
            }
        }
    }

    deinit {
        timer?.invalidate()
    }
}
