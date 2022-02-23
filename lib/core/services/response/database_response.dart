abstract class Response {
  Future<DatabaseResponse> find({Map<String, dynamic>? paramter});

  Future<DatabaseResponse> insert({required Map<String, dynamic> model});

  Future<DatabaseResponse> update({required Map<String, dynamic> model});

  Future<DatabaseResponse> delete({required int id});

}

class DatabaseResponse {
  final dynamic data;
  final bool response;

  DatabaseResponse({required this.data, required this.response});
}
