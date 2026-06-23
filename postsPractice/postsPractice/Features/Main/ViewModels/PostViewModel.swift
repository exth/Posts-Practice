import Foundation


@Observable
@MainActor
final class PostViewModel {
    var posts: [Post] = []
    var errorMessage: String?
    
    private let service: PostServiceProtocol
    
    init(service: PostServiceProtocol) {
        self.service = service
    }
    
    convenience init() {
        self.init(service: PostService())
    }
    
    func loadPosts() async {
        do {
            posts = try await service.fetchPosts()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
