class Urls{
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';

  static const String registration = '$_baseUrl/registration';
  static const String logIn = '$_baseUrl/login';
  static const String addNewTask = '$_baseUrl/createTask';
  static const String taskCountByStatus = '$_baseUrl/taskStatusCount';
  static const String newTaskList = '$_baseUrl/listTaskByStatus/New';
  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
  static String updateTaskStatus(String id , String status) => '$_baseUrl/updateTaskStatus/$id/$status';
  static const String completedTaskList = '$_baseUrl/listTaskByStatus/Completed';
  static const String progressTaskList = '$_baseUrl/listTaskByStatus/Progress';
  static const String cancelledTaskList = '$_baseUrl/listTaskByStatus/Cancelled';
}