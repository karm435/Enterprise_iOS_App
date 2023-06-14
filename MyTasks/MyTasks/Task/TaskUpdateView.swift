import SwiftUI
import Models

struct TaskUpdateView: View {
	@StateObject private var viewModel: TaskViewModel = .init()
	
	init(id: UUID) {
		
	}
	
	init(task: Todo) {
		
	}
	
	var body: some View {
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
						await viewModel.saveTask()
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

struct TaskUpdateView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationStack {
			TaskUpdateView(id: UUID())
		}
    }
}
