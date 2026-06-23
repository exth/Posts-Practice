import Foundation


final class PostService: PostServiceProtocol {
    private let baseURL = "https://jsonplaceholder.typicode.com/posts"
    
    private let session: URLSession
    private let decoder = JSONDecoder()
    
    init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.timeoutIntervalForResource = 60
        config.allowsCellularAccess = true
        config.waitsForConnectivity = false
        self.session = URLSession(configuration: config)
    }
    
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: "\(baseURL)") else {
            throw NetworkError.invalidRequest
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.serverError(httpResponse.statusCode)
            }
            
            return try decoder.decode([Post].self, from: data)
        } catch {
            throw NetworkError.unknown
        }
    }
}

// This is s test project. Other errors wil be added in the future.
