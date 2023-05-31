import Foundation

public class NetworkClient {
	private let urlSession: URLSession
	private let decoder = JSONDecoder()
	
	public init() {
		urlSession = URLSession.shared
	}
	
	public func get<Entity: Decodable>(endPoint: EndPoint) async throws -> Entity {
		guard let url = makeURL(endPoint) else {
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
	
	private func makeURL(scheme: String = "http",
						_ endPoint: EndPoint) -> URL? {
		var components = URLComponents()
		components.scheme = scheme
		components.host = ""
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
