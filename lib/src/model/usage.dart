class Usage {
  int promptTokens;
  int completionTokens;
  int totalTokens;

  Usage({required this.promptTokens, required this.completionTokens, required this.totalTokens});

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(
      promptTokens: json['prompt_tokens'],
      completionTokens: json['completion_tokens'],
      totalTokens: json['total_tokens'],
    );
  }
}