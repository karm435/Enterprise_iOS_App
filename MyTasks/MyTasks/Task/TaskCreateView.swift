
import SwiftUI

struct TaskCreateView: View {
	@StateObject private var viewModel: TaskViewModel = .init()
	
    var body: some View {
		Form {
			TextField("Title", text: $viewModel.task.title)
		}
		.scrollContentBackground(.hidden)
		.background(.white)
		.navigationTitle("New Task")
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(action:  {
					Task {
						await viewModel.saveTask()
					}
				}) {
					Text("Save")
						.padding(.trailing, 10)
						.disabled(viewModel.cannotSave)
				}
			}
		}
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationStack {
			TaskCreateView()
		}
    }
}
