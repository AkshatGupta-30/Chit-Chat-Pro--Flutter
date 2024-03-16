enum GPTmodel {
  turbo16k, turbo1106, turbo16k0613, turbo, turbo0125, turbo0301, turbo0613;

  static GPTmodel fromStr(String modelText) {
    switch (modelText) {
      case 'gpt-3.5-turbo-16k': return GPTmodel.turbo16k;
      case 'gpt-3.5-turbo-1106': return GPTmodel.turbo1106;
      case 'gpt-3.5-turbo-16k-0613': return GPTmodel.turbo16k0613;
      case 'gpt-3.5-turbo': return GPTmodel.turbo;
      case 'gpt-3.5-turbo-0125': return GPTmodel.turbo0125;
      case 'gpt-3.5-turbo-0301': return GPTmodel.turbo0301;
      default: return GPTmodel.turbo0613;
    }
  }

  String get toStr {
    switch (this) {
      case GPTmodel.turbo16k: return 'gpt-3.5-turbo-16k';
      case GPTmodel.turbo1106: return 'gpt-3.5-turbo-1106';
      case GPTmodel.turbo16k0613: return 'gpt-3.5-turbo-16k-0613';
      case GPTmodel.turbo: return 'gpt-3.5-turbo';
      case GPTmodel.turbo0125: return 'gpt-3.5-turbo-0125';
      case GPTmodel.turbo0301: return 'gpt-3.5-turbo-0301';
      default: return 'gpt-3.5-turbo-0613';
    }
  }
}