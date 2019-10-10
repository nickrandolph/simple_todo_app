part of swagger.api;

class Task {
  
  String title = null;
  

  bool completed = null;
  
  Task();

  @override
  String toString() {
    return 'Task[title=$title, completed=$completed, ]';
  }

  Task.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    title =
        json['title']
    ;
    completed =
        json['completed']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed
     };
  }

  static List<Task> listFromJson(List<dynamic> json) {
    return json == null ? new List<Task>() : json.map((value) => new Task.fromJson(value)).toList();
  }

  static Map<String, Task> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Task>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Task.fromJson(value));
    }
    return map;
  }
}

