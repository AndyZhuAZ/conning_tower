import 'dart:convert';
import 'dart:io';

import 'package:conning_tower/constants.dart';
import 'package:conning_tower/generated/l10n.dart';
import 'package:conning_tower/helper.dart';
import 'package:conning_tower/main.dart';
import 'package:conning_tower/models/feature/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:validators/validators.dart';
import 'package:yaml/yaml.dart';

import '../utils/notification_util.dart';

part 'task_provider.freezed.dart';

part 'task_provider.g.dart';

Tasks latestTasks = const Tasks(items: []);
bool isFirstOpen = true;

@freezed
class TaskUtilState with _$TaskUtilState {
  factory TaskUtilState({
    required String source,
    required Tasks tasks,
    required String url,
    required TextEditingController urlSourceController,
    required TextEditingController textSourceController,
  }) = _TaskUtilState;
}

@riverpod
class TaskUtil extends _$TaskUtil {
  @override
  Future<TaskUtilState> build() async {
    return _fetchTaskUtilState();
  }

  Future<void> _loadLocalTasks() async {
    try {
      final file = await _localJsonFile;

      String contents = await file.readAsString();

      debugPrint(contents);

      latestTasks = Tasks.fromJson(jsonDecode(contents));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _saveLocalTasks() async {
    final file = await _localJsonFile;

    final directory = file.parent;
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    await file.writeAsString(jsonEncode(latestTasks.toJson()));
  }

  Future<void> deleteLocalTasks() async {
    final file = await _localJsonFile;

    if (file.existsSync()) {
      await file.delete();
    }
  }

  Future<TaskUtilState> _fetchTaskUtilState() async {
    final url = localStorage.getString("tasksUrl") ?? "";
    TaskUtilState taskUtilState = baseTaskUtilState("default", url);
    try {
      if (isFirstOpen) {
        await _loadLocalTasks();
        await notification.requestPermissions();
        isFirstOpen = false;
      }
      if (latestTasks.items.isNotEmpty) {
        taskUtilState = TaskUtilState(
            source: "runtime",
            tasks: latestTasks,
            url: url,
            urlSourceController: TextEditingController(text: url),
            textSourceController: TextEditingController(text: ""));
      }
      await _saveLocalTasks();
    } catch (e, s) {
      taskUtilState = TaskUtilState(
          source: "error",
          tasks: Tasks(items: [
            Task(
                id: "1",
                title: "Error: $e",
                time: kZeroTime,
                description: "$s",
                tag: "")
          ]),
          url: url,
          urlSourceController: TextEditingController(text: url),
          textSourceController: TextEditingController(text: ""));
    }
    return taskUtilState;
  }

  Tasks emptyTasks() => const Tasks(items: []);

  TaskUtilState baseTaskUtilState(String source, String url) => TaskUtilState(
      source: source,
      tasks: emptyTasks(),
      url: url,
      urlSourceController: TextEditingController(text: url),
      textSourceController: TextEditingController(text: ""));

  Future<File> get _localJsonFile async {
    final path = await localPath;
    return File('$path/providers/task/tasks.json');
  }

  Future<File> get _localYamlFile async {
    final path = await localPath;
    return File('$path/providers/task/tasks.yaml');
  }

  Future<void> setTasksUrl(String url) async {
    state = const AsyncValue.loading();
    if (isURL(url)) {
      localStorage.setString("tasksUrl", url);
      // localStorage.setString("tasksSource", "url");
      state = await AsyncValue.guard(() async {
        // latestTasks = emptyTasks();
        try {
          if (url.isNotEmpty) {
            if (!isURL(url)) {
              throw Exception(S.current.InvalidUrlError);
            }

            final json = await http.get(Uri.parse(url));

            if (json.statusCode != 200) {
              throw Exception("HTTP status code: ${json.statusCode}");
            }

            final tasksJson = jsonDecode(json.body);
            debugPrint(url);
            debugPrint(json.statusCode.toString());
            var tasks = Tasks.fromJson(tasksJson);

            if (tasks.items.length <= kMaxTaskNum) {
              latestTasks = tasks;
            } else {
              Fluttertoast.showToast(msg: S.current.TasksNumOverLimit);
            }
          }
        } catch (e, s) {
          return TaskUtilState(
              source: "error",
              tasks: Tasks(items: [
                Task(
                    id: "1",
                    title: "Error: $e",
                    time: kZeroTime,
                    description: "$s",
                    tag: "")
              ]),
              url: url,
              urlSourceController: TextEditingController(text: url),
              textSourceController: TextEditingController(text: ""));
        }
        return _fetchTaskUtilState();
      });
      debugPrint(state.toString());
    } else {
      Fluttertoast.showToast(msg: S.current.InvalidUrlError);
    }
  }

  Future<void> setTasksString(String content) async {
    state = const AsyncValue.loading();
    if (isJSON(content)) {
      try {
        state = await AsyncValue.guard(() async {
          // latestTasks = emptyTasks();
          await Future.delayed(const Duration(
              milliseconds:
                  100)); // When it must be async, the TasksSheet will be rebuilt after loading is completed
          latestTasks = Tasks.fromJson(jsonDecode(content));
          return _fetchTaskUtilState();
        });
        debugPrint(state.toString());
        // await _saveLocalTasks();
      } catch (e) {
        Fluttertoast.showToast(msg: S.current.InvalidJsonError);
      }
    } else if (isYaml(content)) {
      try {
        state = await AsyncValue.guard(() async {
          // latestTasks = emptyTasks();
          await Future.delayed(const Duration(
              milliseconds: 100)); // 必须为非同步时，完成loading才会重新构建TasksSheet
          latestTasks = parseYaml(content);
          return _fetchTaskUtilState();
        });
        debugPrint(state.toString());
        // await _saveLocalTasks();
      } catch (e) {
        Fluttertoast.showToast(msg: S.current.InvalidYamlError);
      }
    }
  }

  Tasks parseYaml(String yamlString) {
    final yamlList = loadYaml(yamlString) as YamlList;
    final tasks = yamlList.map((yamlMap) {
      final taskMap = yamlMap as YamlMap;
      return Task(
        id: taskMap['id'].toString(),
        title: taskMap['title'].toString(),
        time: taskMap['time'].toString(),
        description: taskMap['description'].toString(),
        tag: taskMap['tag'].toString(),
      );
    }).toList();
    return Tasks(items: tasks);
  }

  Future<void> testSetNotification() async {
    String taskString = '''{
        "id": "1",
        "title": "練習航海",
        "time": "00:01:00",
        "description": "鎮守府近海を航海し、艦隊の練度を高めよう！",
        "tag": "鎮守府海域"
    }''';

    Task task = Task.fromJson(jsonDecode(taskString));

    await setNotification(task);
  }

  Future<void> setNotification(Task task) async {
    String timeString = task.time;
    if (timeString == kZeroTime) return;

    // DateTime baseTime = DateTime(2023, 6, 1);
    // DateTime parsedDateTime = DateTime.parse('2023-06-01 $timeString');
    // Duration duration = parsedDateTime.difference(baseTime);
    List<String> parts = timeString.split(':');
    Duration duration = Duration(
      hours: int.parse(parts[0]),
      minutes: int.parse(parts[1]),
      seconds: int.parse(parts[2]),
    );

    // notification time for task creation
    tz.TZDateTime scheduledDateTime = tz.TZDateTime.now(tz.local).add(duration);

    // set the title and content of the notification
    String notificationTitle = S.current.TaskCompleted(task.title);
    String notificationBody = "";

    // create notification details
    var notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        kTaskChannelId,
        kTaskChannelName,
        channelDescription: kTaskChannelDescription,
      ),
    );

    await notification.zonedScheduleAlarmClockNotification(
        task.id.hashCode,
        notificationTitle,
        notificationBody,
        scheduledDateTime,
        notificationDetails);
    HapticFeedback.lightImpact();
    Fluttertoast.showToast(msg: S.current.TaskNotificationAdded);
  }

  Future<void> onPinTask(Task task) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(
          milliseconds:
              50)); // When it must be async, the TasksSheet will be rebuilt after loading is completed
      if (latestTasks.items.contains(task)) {
        debugPrint(latestTasks.toString());
        var items = latestTasks.items.toList();
        items.remove(task);
        items.insert(0, task);
        latestTasks = latestTasks.copyWith(items: items);
        debugPrint("after remove");
        debugPrint(latestTasks.toString());
      }
      return _fetchTaskUtilState();
    });
    debugPrint(state.toString());
    await _saveLocalTasks();
  }

  void onSaveSource(TaskUtilState tasksUtilState) {
    final url = tasksUtilState.urlSourceController.text;
    final text = tasksUtilState.textSourceController.text;

    if (url.isNotEmpty) {
      setTasksUrl(url);
    } else if (text.isNotEmpty) {
      setTasksString(text);
    } else {
      Fluttertoast.showToast(msg: S.current.EmptyFieldError);
    }
  }
}