import SwiftUI
import Models

struct RedactedTasksListView: View {
	var body: some View {
		VStack {
			ForEach(Todo.placeholderTasks, id: \.id) { task in
				TaskRowView(task: task)
			}
			.redacted(reason: .placeholder)
		}
	}
}

struct RedactedTasksListView_Previews: PreviewProvider {
    static var previews: some View {
        RedactedTasksListView()
    }
}
