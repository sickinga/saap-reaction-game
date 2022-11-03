//
//  ReactionViewModel.swift
//  ReactionGame
//
//  Created by Benedikt Kaiser on 03.11.22.
//

import Foundation
import Starscream

class ReactionViewModel: ObservableObject, WebSocketDelegate {
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocket) {
        print(event)
    }
    
    @Published var reactionTimerStarted = false
    @Published var reactionTime: Double?
    let stopWatch = StopWatchManager()
//    var manager: SocketManager = SocketManager(socketURL: URL(string: "http://192.168.0.119:6969")!, config: [.log(true), .compress])
    private var webSocketTask: URLSessionWebSocketTask? // 1
    private var socket: WebSocket?
//    private let stream = WebSocketStream(url: "wss://192.168.0.119:6969")
    
    init() {
//        connect()
        
        
        
        
        var request = URLRequest(url: URL(string: "http://localhost:8080")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        guard let socket else { return }
        socket.delegate = self
        socket.connect()
        
        
        
        
//        let server = ServerModule()
//        server.connect()
        
        //        manager = SocketManager(socketURL: URL(string: "http://192.168.0.119:6969")!, config: [.log(true), .compress])
        
        
        //        manager.defaultSocket.on(clientEvent: .connect) {data, ack in
        //            print("socket connected")
        //        }
        //        manager.defaultSocket.on("go") { data, ack in
        //            print("event started")
        //            self.startReactionEvent()
        //
        //        }
        //        manager.defaultSocket.onAny { event in
        //            print("event")
        
        //            self.startReactionEvent()
        //        }
        //        manager.defaultSocket.connect()
        
        //        let url = URL(string: "ws://192.168.0.119:6969")! // 3
        //                webSocketTask = URLSession.shared.webSocketTask(with: url) // 4
        //                webSocketTask?.receive(completionHandler: onReceive) // 5
        //                webSocketTask?.resume() // 6
        
    }
    
    // MARK: - Connection
        func connect() { // 2
            let url = URL(string: "ws://192.168.0.119:6969")! // 3
            webSocketTask = URLSession.shared.webSocketTask(with: url) // 4
            webSocketTask?.receive(completionHandler: onReceive) // 5
            webSocketTask?.resume() // 6
        }
        
        func disconnect() { // 7
            webSocketTask?.cancel(with: .normalClosure, reason: nil) // 8
        }

        private func onReceive(incoming: Result<URLSessionWebSocketTask.Message, Error>) {
            // Nothing yet...
            print("incoming")
        }
        
        deinit { // 9
            disconnect()
        }
    
//    func disconnect() { // 7
//        webSocketTask?.cancel(with: .normalClosure, reason: nil) // 8
//    }
    
//    private func onReceive(incoming: Result<URLSessionWebSocketTask.Message, Error>) {
//        // Nothing yet...
//        print("something received")
//    }
    

    
    func startReactionEvent() {
        reactionTimerStarted = true
        stopWatch.start()
    }
    
    func stopReactionEvent() {
        reactionTime = stopWatch.stop()
        reactionTimerStarted = false
    }
}
