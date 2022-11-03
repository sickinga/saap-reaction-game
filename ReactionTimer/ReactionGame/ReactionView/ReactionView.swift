//
//  ReactionView.swift
//  ReactionGame
//
//  Created by Benedikt Kaiser on 03.11.22.
//

import SwiftUI


struct ReactionView: View {
    @ObservedObject var vm = ReactionViewModel()
    var body: some View {
        ZStack {
            if vm.reactionTimerStarted {
                
                Color.green
                    .ignoresSafeArea()
            } else {
                Color.red
                    .ignoresSafeArea()
            }
            VStack {
                if let time = vm.reactionTime {
                    Text(String(format: "%.3fs", time))
                }
                Button("Test") {
                    vm.stopReactionEvent()
                }
                .buttonStyle(.borderedProminent)
                .disabled(!vm.reactionTimerStarted)
            }
        }}
}

struct ReactionView_Previews: PreviewProvider {
    static var previews: some View {
        ReactionView()
    }
}
