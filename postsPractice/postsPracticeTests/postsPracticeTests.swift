import XCTest

@testable import postsPractice


@MainActor
final class PostsViewModelTests: XCTestCase {
    private var vm: PostViewModel!
    private var mockService: MockPostService!
    
    override func setUp() {
        super.setUp()
        mockService = MockPostService()
        vm = PostViewModel(service: mockService)
    }
    
    override func tearDown() {
        vm = nil
        mockService = nil
        super.tearDown()
    }
    
    
    func test_loadPosts_success_shouldFillPostsArray() async {
        mockService.postsToReturn = [
            Post(id: 1, title: "Title", body: "Body")
        ]
        
        await vm.loadPosts()
        
        XCTAssertEqual(vm.posts.count, 1)
        XCTAssertNil(vm.errorMessage)
    }
    
    
    func test_loadPosts_failure_shouldSetErrorMessage() async {
        mockService.errorToThrow = .invalidRequest
        
        await vm.loadPosts()
        
        XCTAssertEqual(vm.posts.count, 0)
        XCTAssertNotNil(vm.errorMessage)
        XCTAssertEqual(vm.errorMessage, "Internal error. Try again later")
    }
}
