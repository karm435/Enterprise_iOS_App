
import Foundation
import Network
import Factory

public final class TasksContainer: SharedContainer {
    public static let shared = TasksContainer()
    
    public let manager: ContainerManager = ContainerManager()
    
    public init() {}
}

extension TasksContainer {
    var networkService: Factory<NetworkClientProtocol> {
        self { NetworkClient()}.singleton
    }
    
    var tasksService: Factory<MyTasksServiceProtocol> {
        self { MyTasksService()}.scope(.unique)
    }
}
