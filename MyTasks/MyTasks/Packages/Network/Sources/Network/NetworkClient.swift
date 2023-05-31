import Foundation

public class NetworkClient {
	private let urlSession: URLSession
	private let decoder = JSONDecoder()
	
	public init() {
		urlSession = URLSession.shared
	}
	
	public func get<Entity: Decodable>(requestUrl: URL) async throws -> Entity {
		let urlRequest = URLRequest(url: requestUrl)
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
	
	private func logResponseOnError(httpResponse: URLResponse, data: Data) {
		if let httpResponse = httpResponse as? HTTPURLResponse, httpResponse.statusCode > 299 {
			print(httpResponse)
			print(String(data: data, encoding: .utf8) ?? "")
		}
	}
}
