import java.net.ServerSocket
import java.net.Socket
import kotlin.concurrent.thread

fun main(args: Array<String>) {
    val server = ServerSocket(6969)
    println("Server is running on port ${server.localPort}")

    val playerList: MutableList<Socket> = mutableListOf<Socket>()

    thread {
        while (true) {
            val client = server.accept()
            println("Client connected: ${client.inetAddress.hostAddress}")
            playerList.add(client)
        }
    }

    while (true) {
        if(!playerList.stream().anyMatch { it.isConnected }) {
            Thread.sleep((Math.random() * 5000 + 5000).toLong())

            playerList.forEach { it.getOutputStream().write("GO".toByteArray()) }

            Thread.sleep(3000)
        }
    }
}


