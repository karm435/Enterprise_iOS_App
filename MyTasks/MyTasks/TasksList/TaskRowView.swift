import SwiftUI
import Models

struct TaskRowView: View {
	let task: Todo
	var body: some View {
		HStack {
			Text(task.title)
			Spacer()
			Image(systemName: "checkmark.circle.fill")
				.foregroundColor(.green)
				.opacity(task.isCompleted ? 1 : 0)
		}
	}
}

struct TaskRowView_Previews: PreviewProvider {
	static var previews: some View {
		TaskRowView(task: Todo.placeholder)
	}
}
