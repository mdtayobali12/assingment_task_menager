class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String registration = '$_baseUrl/registration';
  static String login = '$_baseUrl/login';
  static String createTask= '$_baseUrl/createTask';
  static String taskStatusCount= '$_baseUrl/taskStatusCount';
  static String newTaskList= '$_baseUrl/listTaskByStatus/New';
  static String deleteTaskStatus(String id)=> '$_baseUrl/deleteTask/$id';
  static String updateTaskStatus(String id, String status)=> '$_baseUrl/updateTaskStatus/$id/$status';
  static String RecoverVerifyEmail(String email)=> '$_baseUrl/RecoverVerifyEmail/$email';
  static String RecoverVerifyOTP(String email, String OTP)=>'$_baseUrl/RecoverVerifyOTP/$email/$OTP';
  static String CompletedTaskList= '$_baseUrl/listTaskByStatus/Completed';
  static String ProgressTaskList= '$_baseUrl/listTaskByStatus/Progress';
  static String CancelledTaskList= '$_baseUrl/listTaskByStatus/Cancelled';
  static String profileUpdate= '$_baseUrl/profileUpdate';
  static String RecoverResetPass='$_baseUrl/RecoverResetPass';
}