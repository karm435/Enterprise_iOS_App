import SwiftUI
import Models

struct TaskUpdateView: View {
	@StateObject private var viewModel: TaskViewModel
	
	init(id: UUID) {
		_viewModel = StateObject(wrappedValue: .init(id: id))
	}
	
	init(task: Todo) {
		_viewModel = StateObject(wrappedValue: .init(task: task))
	}
	
	var body: some View {
		Group {
			switch viewModel.state {
				case .loading:
					ProgressView()
						.foregroundColor(.gray)
				case let .error(error):
					Text("error: \(error.localizedDescription)")
				case .display:
					Form {
						TextField("Title", text: $viewModel.task.title)
							.textFieldStyle(.roundedBorder)
					}
					.scrollContentBackground(.hidden)
					.background(.white)
					.navigationTitle(Text(viewModel.task.title))
					.toolbar {
						ToolbarItem(placement: .navigationBarTrailing) {
							Button(action:  {
								Task {
									await viewModel.saveTask(isUpdating: true)
								}
							}) {
								Text("Update")
									.padding(.trailing, 10)
									.disabled(viewModel.cannotSave)
							}
						}
					}
			}
		}
		.onAppear {
			Task {
				await viewModel.fetchTask()
			}
		}
	}
}

struct TaskUpdateView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationStack {
			TaskUpdateView(id: UUID())
		}
    }
}
