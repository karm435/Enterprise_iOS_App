
import Foundation
import Models

public class MockNetworkClient: NetworkClientProtocol {
	public var mockReponse: Any? = nil
	
	public func delete(endPoint: EndPoint) async throws {
		if mockReponse != nil {
			return
		}
		
		throw ServerError(error: "Error message")
	}
	
	public func post(endPoint: EndPoint) async throws {
		if mockReponse != nil {
			return
		}
		
		throw ServerError(error: "Error message")
	}
	
	public func put(endPoint: EndPoint) async throws {
		if mockReponse != nil {
			return
		}
		
		throw ServerError(error: "Error message")
	}
	
	
	public func get<Entity>(endPoint: EndPoint) async throws -> Entity where Entity : Decodable {
		guard let mockReponse else {
			throw ServerError(error: "Response not set")
		}
		
		if mockReponse is Entity {
			return mockReponse as! Entity
		}
		
		throw ServerError(error: "Response not set for the type")
	}
}

// Error mock
extension MockNetworkClient {
	public static var errorClient: NetworkClientProtocol {
		let mock = MockNetworkClient()
		mock.mockReponse = nil
		return mock
	}
}

// Tasks mock
extension MockNetworkClient {
	public static var tasksMockClient: NetworkClientProtocol {
		let mock = MockNetworkClient()
		mock.mockReponse = Todo.placeholderTasks
		return mock
	}
}
