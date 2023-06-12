import Foundation

public protocol NetworkClientProtocol {
	func get<Entity: Decodable>(endPoint: EndPoint) async throws -> Entity
	func post(endPoint: EndPoint) async throws
}

public class NetworkClient: NSObject, NetworkClientProtocol {
	private var urlSession: URLSession?
	private let decoder = JSONDecoder()
	
	public override init() {
		super.init()
		urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
	}
	
	public func post(endPoint: EndPoint) async throws {
		guard let urlSession, let url = makeURL(endPoint) else {
			throw ServerError(error: "Endpoint parsing error")
		}
		
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = "POST"
		
		if let json = endPoint.jsonValue {
			let encoder = JSONEncoder()
			do {
				let jsonData = try encoder.encode(json)
				urlRequest.httpBody = jsonData
				urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
			} catch {
				throw ServerError(error: "Client Error encoding JSON: \(error.localizedDescription)")
			}
		}
		
		let (data, httpResponse) = try await urlSession.data(for: urlRequest)
		if let httpResponse = httpResponse as? HTTPURLResponse, httpResponse.statusCode > 299 {
			print(httpResponse)
			throw ServerError(error: String(data: data, encoding: .utf8) ?? "Error with code \(httpResponse.statusCode)")
		}
	}
	
	public func get<Entity: Decodable>(endPoint: EndPoint) async throws -> Entity {
		guard let urlSession, let url = makeURL(endPoint) else {
			throw ServerError(error: "Endpoint parsing error")
		}
		
		let urlRequest = URLRequest(url: url)
		
		let (data, httpResponse) = try await urlSession.data(for: urlRequest)
		logResponseOnError(httpResponse: httpResponse, data: data)
		do {
			return try decoder.decode(Entity.self, from: data)
		} catch {
			if let serverError = try? decoder.decode(ServerError.self, from: data) {
				throw serverError
			}
			throw error
		}
	}
	
	private func makeURL(scheme: String = "https",
						_ endPoint: EndPoint) -> URL? {
		var components = URLComponents()
		components.scheme = scheme
		components.host = "localhost"
		components.port = 7111
		components.path += "/api/\(endPoint.path())"
		return components.url
	}
	
	private func logResponseOnError(httpResponse: URLResponse, data: Data) {
		if let httpResponse = httpResponse as? HTTPURLResponse, httpResponse.statusCode > 299 {
			print(httpResponse)
			print(String(data: data, encoding: .utf8) ?? "")
		}
	}
}
