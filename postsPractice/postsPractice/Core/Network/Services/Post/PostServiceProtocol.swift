import Foundation


protocol PostServiceProtocol {
    func fetchPosts() async throws -> [Post]
}
