import Foundation
import XCTest
import Network
@testable import MyTasks

final class TaskViewModelTests: XCTestCase {
    func test_ShouldSetViewStateToError() async {
        TasksContainer.shared.networkService.register(factory: {
            MockNetworkClient.errorClient
        })
        
        let viewModel = TasksListViewModel()
        
        await viewModel.onAppear()
        
        XCTAssertEqual(viewModel.state, TasksListViewModel.State.loading)
    }
}
