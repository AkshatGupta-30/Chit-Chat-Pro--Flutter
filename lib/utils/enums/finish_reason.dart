enum FinishReason {
  stop, length, contentFilter, toolCalls, functionCall;
  
  static FinishReason fromStr(String str) {
    switch (str) {
      case 'stop': return FinishReason.stop;
      case 'length': return FinishReason.length;
      case 'content_filter': return FinishReason.contentFilter;
      case 'tool_calls': return FinishReason.toolCalls;
      default: return FinishReason.functionCall;
    }
  }

  String get toStr {
    switch(this) {
      case FinishReason.stop: return 'stop';
      case FinishReason.length: return 'length';
      case FinishReason.contentFilter: return 'content_filter';
      case FinishReason.toolCalls: return 'tool_calls';
      default: return 'function_call';
    }
  }
}