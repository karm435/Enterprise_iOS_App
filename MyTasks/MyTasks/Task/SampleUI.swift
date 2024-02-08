
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
    
    @Published var header: String = "Header 2"
    
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


class SampleUI3ViewModel: ObservableObject {
    init() {
        print("sample ui 3 viewmodel")
    }
    @Published var header: String = "Header 3"
}

struct SampleUI3: View {
    @StateObject var viewModel = SampleUI3ViewModel()
    var body: some View {
        VStack {
            Text(viewModel.header)
        }
    }
}
