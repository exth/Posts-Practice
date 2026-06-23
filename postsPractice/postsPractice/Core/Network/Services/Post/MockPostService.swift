#if DEBUG
import Foundation


final class MockPostService: PostServiceProtocol {
    var postsToReturn: [Post] = []
    var errorToThrow: NetworkError?
    
    func fetchPosts() async throws -> [Post] {
        if let error = errorToThrow {
            throw error
        }
        
        return postsToReturn
    }
}
#endif
