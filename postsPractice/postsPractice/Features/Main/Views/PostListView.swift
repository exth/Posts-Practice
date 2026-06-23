import SwiftUI


struct PostListView: View {
    @State private var vm: PostViewModel
    
    init(vm: PostViewModel) {
        _vm = State(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if let errorMessage = vm.errorMessage {
                    VStack(spacing: 12) {
                        Text(errorMessage)
                            .foregroundColor(.red)
                        Button("Retry") {
                            Task {
                                await vm.loadPosts()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding(.horizontal)
                } else if vm.posts.isEmpty {
                    ProgressView("Loading...")
                } else {
                    List(vm.posts) { post in
                        VStack(alignment: .leading) {
                            Text(post.title)
                                .font(.headline)
                            Text(post.body)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Posts")
            .task {
                await vm.loadPosts()
            }
        }
    }
}


// MARK: - Previews -
#Preview("Original") {
    PostListView(vm: PostViewModel())
}


#Preview("Successful loading (Mock)") {
    let mockService = MockPostService()
    
    mockService.postsToReturn = [
        Post(id: 1, title: "Title number one", body: "Some content"),
        Post(id: 2, title: "Title number two", body: "Some content to second title")
    ]
    
    return PostListView(vm: PostViewModel(service: mockService))
}


#Preview("Network Error (Mock)") {
    let mockService = MockPostService()
    
    mockService.errorToThrow = .invalidRequest
    
    return PostListView(vm: PostViewModel(service: mockService))
}
