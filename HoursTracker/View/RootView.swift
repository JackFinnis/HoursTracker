//
//  RootView.swift
//  HoursTracker
//
//  Created by Jack Finnis on 08/08/2023.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var vm: ViewModel
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var interval: TimeInterval {
        switch vm.state {
        case .active:
            return vm.accumulatedInterval + vm.dateResumed.intervalToNow
        case .inactive:
            return 0
        case .paused:
            return vm.accumulatedInterval
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                Menu(interval.formattedInterval()) {
                    Button {
                        UIPasteboard.general.string = interval.formattedInterval()
                        Haptics.tap()
                    } label: {
                        Label("Copy", systemImage: "doc.on.doc")
                    }
                } primaryAction: {}
                    .font(.system(size: 50).monospacedDigit())
                    .buttonStyle(.plain)
                    .foregroundColor(.primary)
                Spacer()
                HStack(spacing: 0) {
                    switch vm.state {
                    case .inactive:
                        Button("Start") {
                            vm.resume()
                        }
                        .frame(width: geo.size.width)
                    case .active, .paused:
                        Group {
                            Button("Reset", role: .destructive) {
                                vm.reset()
                            }
                            .buttonStyle(.bordered)
                            if vm.state == .paused {
                                Button("Resume") {
                                    vm.resume()
                                }
                            } else {
                                Button("Pause") {
                                    vm.pause()
                                }
                            }
                        }
                        .frame(width: geo.size.width / 2)
                    }
                }
                .font(.headline)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .padding(.bottom)
            }
        }
        .onReceive(timer) { date in
            vm.objectWillChange.send()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(ViewModel())
    }
}
