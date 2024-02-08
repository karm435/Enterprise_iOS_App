
import Foundation
import Network
import Factory

protocol MyTasksServiceProtocol {
    func getTasks() async
}

struct MyTasksService: MyTasksServiceProtocol {
    @Injected(\TasksContainer.networkService) var networkClient: NetworkClientProtocol
    
    init() {
        print("new instance is created for MyTasksService")
    }
    
    func getTasks() async {
        await networkClient.getTasks()
    }
}
