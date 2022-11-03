//
//  SocketHelper.swift
//  ReactionGame
//
//  Created by Benedikt Kaiser on 03.11.22.
//

import Foundation
import SocketIO

class SocketHelper {

    static let shared = SocketHelper()
    var socket: SocketIOClient!

    let manager = SocketManager(socketURL: URL(string: "http://10.29.19.211:6969")!, config: [.log(true), .compress])

    private init() {
        socket = manager.defaultSocket
    }

    func connectSocket(completion: @escaping(Bool) -> () ) {
        disconnectSocket()
        socket.on(clientEvent: .connect) {[weak self] (data, ack) in
            print("socket connected")
            self?.socket.removeAllHandlers()
            completion(true)
        }
        socket.connect()
    }

    func disconnectSocket() {
        socket.removeAllHandlers()
        socket.disconnect()
        print("socket Disconnected")
    }

    func checkConnection() -> Bool {
        if socket.manager?.status == .connected {
            return true
        }
        return false

    }

    enum Events {

        case search

        var emitterName: String {
            switch self {
            case .search:
                return "emt_search_tags"
            }
        }

        var listnerName: String {
            switch self {
            case .search:
                return "filtered_tags"
            }
        }

        func emit(params: [String : Any]) {
            SocketHelper.shared.socket.emit(emitterName, params)
        }

        func listen(completion: @escaping (Any) -> Void) {
            SocketHelper.shared.socket.on(listnerName) { (response, emitter) in
                completion(response)
            }
        }

        func off() {
            SocketHelper.shared.socket.off(listnerName)
        }
    }
}
