using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c => {
    c.SwaggerDoc("v1", new OpenApiInfo { Title = "Todos Api", Description = "Todos api for sample iOS app." });
});
builder.Services.AddCors(options => {});
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c => {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Todo Api V1");
    });
}

app.MapGet("/todos", () => {
    var todos = TodoDb.Get();
    return todos;
});
app.MapGet("/todos/{id}", (int id) => TodoDb.Get().SingleOrDefault(t => t.id == id));
app.MapPost("/todos", (Todo todo) => TodoDb.Create(todo));
app.MapPut("/todos", (Todo todo) => TodoDb.Update(todo));
app.MapDelete("/todos", (int id) => TodoDb.Delete(id));

app.UseRouting();
app.UseEndpoints(endpoints => {
    endpoints.MapControllers();
});

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
