
// Models
public class Todo {
    public int id { get; set; }
    public string title { get; set; }
    public bool isCompleted { get; set; }
}

public class TodoDb {
    private static List<Todo> _todos = new List<Todo>() {
        new Todo { id = 1, title = "Do the thing", isCompleted = false },
        new Todo { id = 2, title = "Do the thing", isCompleted = false },
        new Todo { id = 3, title = "Do the thing", isCompleted = true },
        new Todo { id = 4, title = "Do the thing", isCompleted = false },
        new Todo { id = 5, title = "Do the thing", isCompleted = true },
        new Todo { id = 6, title = "Do the thing", isCompleted = false }
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

    public static void Delete(int id) {
        _todos = _todos.FindAll(t => t.id != id).ToList();
    }
}