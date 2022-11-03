//
//  ServerModule.swift
//  ReactionGame
//
//  Created by Benedikt Kaiser on 03.11.22.
//

import Foundation
final class ServerModule: ObservableObject {
    private var webSocketTask: URLSessionWebSocketTask? // 1
    // MARK: - Connection
    func connect() { // 2
        let url = URL(string: "ws://127.0.0.1:8080/chat")! // 3
        webSocketTask = URLSession.shared.webSocketTask(with: url) // 4
        webSocketTask?.receive(completionHandler: onReceive) // 5
        webSocketTask?.resume() // 6
    }
    
    func disconnect() { // 7
        webSocketTask?.cancel(with: .normalClosure, reason: nil) // 8
    }
    
    private func onReceive(incoming: Result<URLSessionWebSocketTask.Message, Error>) {
        // Nothing yet...
    }
    
    deinit { // 9
        disconnect()
    }
}
