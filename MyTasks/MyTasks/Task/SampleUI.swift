
import SwiftUI
import Factory

class SampleUIViewModel: ObservableObject {
    @Injected(\TasksContainer.tasksService) var myTasksService: MyTasksServiceProtocol
    
    @Published var header: String = "Header"
    
    func getTasks() async {
        await myTasksService.getTasks()
    }
}

struct SampleUI: View {
    @StateObject var viewModel = SampleUIViewModel()
    var body: some View {
        VStack {
            Text(viewModel.header)
        }
        .task {
           await viewModel.getTasks()
        }
    }
}



class SampleUI2ViewModel: ObservableObject {
    @Injected(\TasksContainer.tasksService) var myTasksService: MyTasksServiceProtocol
    
    @Published var header: String = "Header"
    
    func getTasks() async {
        await myTasksService.getTasks()
    }
}

struct SampleUI2: View {
    @StateObject var viewModel = SampleUI2ViewModel()
    var body: some View {
        VStack {
            Text(viewModel.header)
        }
        .task {
           await viewModel.getTasks()
        }
    }
}
