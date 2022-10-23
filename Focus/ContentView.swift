//
//  ContentView.swift
//  Focus
//
//  Created by Jacob Pantuso on 2022-10-22.
//

import SwiftUI
import IdleTimerState
import AVFoundation

struct ContentView: View {
    
    @State var countdownTimer = 3600
    @State var timerRunning = false
    @State var selectedTime = 3600
    @State private var breakOrfocus = true
    @State private var animateGradient = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    func convertSecondsToTime(timeInSeconds : Int) -> String {
        let minutes = timeInSeconds / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02i:%02i",
                                minutes,
                                seconds)
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(hex:0x020024), Color(hex:0x091279), Color(hex:0x004D69)], startPoint: animateGradient ? .topLeading : .bottomLeading, endPoint: animateGradient ? .bottomTrailing : .topTrailing)
                .onAppear{
                    withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
            VStack {
                HStack {
                    Spacer()
                    Menu {
                        Text("Focus Times")
                        Button(action: {countdownTimer=3600; selectedTime=3600; breakOrfocus=true}, label: {
                            Text("60 Minutes")
                        })
                        Button(action: {countdownTimer=2700; selectedTime=2700; breakOrfocus=true}, label: {
                            Text("45 Minutes")
                        })
                        Button(action: {countdownTimer=1800; selectedTime=1800; breakOrfocus=true}, label: {
                            Text("30 Minutes")
                        })
                        Text("Break Times")
                        Button(action: {countdownTimer=900; selectedTime=900; breakOrfocus=false}, label: {
                            Text("15 Minutes")
                        })
                        Button(action: {countdownTimer=600; selectedTime=600; breakOrfocus=false}, label: {
                            Text("10 Minutes")
                        })
                        Button(action: {countdownTimer=300; selectedTime=300; breakOrfocus=false}, label: {
                            Text("5 Minutes")
                        })
                    } label: {
                        (Image(systemName: "timer")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                        )
                    }
                }
                .padding(30)
                Spacer()
            }
            VStack(spacing: 20) {
                if breakOrfocus {
                    Text("Focus")
                        .foregroundColor(.white)
                        .font(.system(size:30))
                        .bold()
                } else {
                    Text("Break")
                        .foregroundColor(.white)
                        .font(.system(size:30))
                        .bold()
                }
                Text(convertSecondsToTime(timeInSeconds: countdownTimer))
                    .onReceive(timer) { _ in
                        if countdownTimer > 0 && timerRunning {
                            countdownTimer -= 1
                        } else {
                            timerRunning = false
                        }
                    }
                    .font(.system(size: 70).bold())
                    .foregroundColor(.white)
                HStack(spacing: 50) {
                    Button(action: {
                        if timerRunning {
                            timerRunning = false
                        } else {
                            timerRunning = true
                        }
                    }, label: {
                        Image(systemName: "playpause.fill")
                            .resizable()
                            .frame(width: 40, height: 30)
                    })
                    Button(action: {
                        countdownTimer = selectedTime
                        timerRunning = false
                    }, label: {
                        Image(systemName: "gobackward")
                            .resizable()
                            .frame(width:30, height: 30)
                            .foregroundColor(.red)
                    })
                }
                .foregroundColor(.white)
            }
        }
        .ignoresSafeArea(.all)
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

