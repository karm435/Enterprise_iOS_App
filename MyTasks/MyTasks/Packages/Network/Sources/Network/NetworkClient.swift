import Foundation

public protocol NetworkClientProtocol {
	func get<Entity: Decodable>(endPoint: EndPoint) async throws -> Entity
}

public class NetworkClient: NSObject, NetworkClientProtocol {
	private var urlSession: URLSession?
	private let decoder = JSONDecoder()
	
	public override init() {
		super.init()
		urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
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
