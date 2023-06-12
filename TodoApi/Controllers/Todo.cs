
// Models
public class Todo {
    public Guid id { get; set; }
    public string title { get; set; }
    public bool isCompleted { get; set; }
}

public class TodoDb {
    private static List<Todo> _todos = new List<Todo>() {
        new Todo { id = Guid.NewGuid(), title = "Do the thing", isCompleted = false },
        new Todo { id = Guid.NewGuid(), title = "Do the thing", isCompleted = false },
        new Todo { id = Guid.NewGuid(), title = "Do the thing", isCompleted = true },
        new Todo { id = Guid.NewGuid(), title = "Do the thing", isCompleted = false },
        new Todo { id = Guid.NewGuid(), title = "Do the thing", isCompleted = true },
        new Todo { id = Guid.NewGuid(), title = "Do the thing", isCompleted = false }
    };

    public static IEnumerable<Todo> Get() => TodoDb._todos.ToArray();
    
    public static void Create(Todo todo) => _todos.Add(todo);

    public static Todo Update(Todo update) {
        _todos = _todos.Select(todo => {
            if(todo.id == update.id) {
                todo.title = update.title;
                todo.isCompleted = update.isCompleted;
            }
            return update;
        }).ToList();
        return update;
    }

    public static void Delete(Guid id) {
        _todos = _todos.FindAll(t => t.id != id).ToList();
    }
}