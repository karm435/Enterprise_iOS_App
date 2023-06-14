
// Models
public class Todo {
    public Guid id { get; set; }
    public string title { get; set; }
    public bool isCompleted { get; set; }
}

public class TodoDb {
    private static List<Todo> _todos = new List<Todo>() {
        new Todo { id = Guid.NewGuid(), title = "Do the thing", isCompleted = false },
        new Todo { id = Guid.NewGuid(), title = "Do the thing 2", isCompleted = false },
        new Todo { id = Guid.NewGuid(), title = "Do the thing 3" , isCompleted = true },
        new Todo { id = Guid.NewGuid(), title = "Do the thing 4", isCompleted = false },
        new Todo { id = Guid.NewGuid(), title = "Do the thing 5", isCompleted = true },
        new Todo { id = Guid.NewGuid(), title = "Do the thing 6", isCompleted = false }
    };

    public static IEnumerable<Todo> Get() => TodoDb._todos.ToArray();
    
    public static void Create(Todo todo) => _todos.Add(todo);

    public static Todo Update(Todo update) {
        _todos = _todos.Select(todo => {
            if(Guid.Equals(todo.id, update.id)) {
                todo.title = update.title;
                todo.isCompleted = update.isCompleted;
            }
            return todo;
        }).ToList();
        return update;
    }

    public static void Delete(Guid id) {
        _todos = _todos.FindAll(t => t.id != id).ToList();
    }
}