// DeepSeek Function Calling
const DSTools = [{
  'type': 'function',
  'function': {
    'name': 'get_weather',
    'description': '获取当地天气信息',
    'parameters': {
      'type': 'object',
      'properties': {
        'location': {
          'type': 'string',
          'description': '城市名称'
        }
      },
      'required': ['location']
    }
  }
}];


// GPT Function Calling
const GPTTools = [{
  'type': 'function',
  'function': {
    'name': 'get_weather',
    'description': '获取当地天气信息',
    'parameters': {
      'type': 'object',
      'properties': {
        'latitude': { type: 'number' },
        'longitude': { type: 'number' },
      },
      'required': ['latitude', 'longitude'],
      'additionalProperties': false
    }
  }
}];

// Claude Function Calling
const ClaudeTools = [{
  'type': 'function',
  'function': {
    'name': 'get_weather',
    'description': '获取当地天气信息',
    'input_schema': {
      'type': 'object',
      'properties': {
        'location': {
          'type': 'string',
          'description': '城市名称'
        }
      },
      'required': ['location']
    }
  }
}];