class PendingTaskAction {
  final String? actionType;
  final String? summary;
  final Map<String, dynamic>? payload;
  final String? proposedByEmployeeId;
  final String? actionId;

  PendingTaskAction({
    this.actionType,
    this.summary,
    this.payload,
    this.proposedByEmployeeId,
    this.actionId,
  });

  factory PendingTaskAction.fromJson(Map<String, dynamic> json) {
    return PendingTaskAction(
      actionType: json['action_type']?.toString(),
      summary: json['summary']?.toString(),
      payload: json['payload'] is Map<String, dynamic>
          ? json['payload'] as Map<String, dynamic>
          : null,
      proposedByEmployeeId: json['proposed_by_employee_id']?.toString(),
      actionId: json['action_id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'action_type': actionType,
        'summary': summary,
        'payload': payload,
        'proposed_by_employee_id': proposedByEmployeeId,
        'action_id': actionId,
      };
}

class PendingActionModel {
  final String actionId;
  final PendingTaskAction? action;
  final String? summary;
  final String? actionType;

  PendingActionModel({
    required this.actionId,
    this.action,
    this.summary,
    this.actionType,
  });

  factory PendingActionModel.fromJson(Map<String, dynamic> json) {
    final actJson = json['action'] is Map<String, dynamic>
        ? json['action'] as Map<String, dynamic>
        : null;

    final act = actJson != null ? PendingTaskAction.fromJson(actJson) : null;

    return PendingActionModel(
      actionId: json['action_id']?.toString() ?? act?.actionId ?? '',
      action: act,
      summary: json['summary']?.toString() ?? act?.summary,
      actionType: json['action_type']?.toString() ?? act?.actionType,
    );
  }
}

class AiChatResponseModel {
  final bool success;
  final String response;
  final String threadId;
  final List<String> targetAgents;
  final PendingActionModel? pendingAction;

  AiChatResponseModel({
    required this.success,
    required this.response,
    required this.threadId,
    required this.targetAgents,
    this.pendingAction,
  });

  factory AiChatResponseModel.fromJson(Map<String, dynamic> json) {
    final rawAgents = json['target_agents'];
    final agents = <String>[];
    if (rawAgents is List) {
      for (final a in rawAgents) {
        if (a != null) agents.add(a.toString());
      }
    }

    PendingActionModel? pending;
    if (json['pending_action'] is Map<String, dynamic>) {
      pending = PendingActionModel.fromJson(
        json['pending_action'] as Map<String, dynamic>,
      );
    }

    return AiChatResponseModel(
      success: json['success'] == true,
      response: json['response']?.toString() ?? '',
      threadId: json['thread_id']?.toString() ?? '',
      targetAgents: agents,
      pendingAction: pending,
    );
  }
}

class ChatMessageModel {
  final String id;
  final String role; // 'user' or 'assistant'
  final String text;
  final List<String> targetAgents;
  final PendingActionModel? pendingAction;
  final DateTime createdAt;
  final bool isConfirmed;

  ChatMessageModel({
    required this.id,
    required this.role,
    required this.text,
    this.targetAgents = const [],
    this.pendingAction,
    required this.createdAt,
    this.isConfirmed = false,
  });

  ChatMessageModel copyWith({
    String? id,
    String? role,
    String? text,
    List<String>? targetAgents,
    PendingActionModel? pendingAction,
    DateTime? createdAt,
    bool? isConfirmed,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      role: role ?? this.role,
      text: text ?? this.text,
      targetAgents: targetAgents ?? this.targetAgents,
      pendingAction: pendingAction ?? this.pendingAction,
      createdAt: createdAt ?? this.createdAt,
      isConfirmed: isConfirmed ?? this.isConfirmed,
    );
  }
}
