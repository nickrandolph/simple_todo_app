# swagger
No description provided (generated by Swagger Codegen https://github.com/swagger-api/swagger-codegen)

This Dart package is automatically generated by the [Swagger Codegen](https://github.com/swagger-api/swagger-codegen) project:

- API version: v1
- Build package: io.swagger.codegen.languages.DartClientCodegen

## Requirements

Dart 1.20.0 or later OR Flutter 0.0.20 or later

## Installation & Usage

### Github
If this Dart package is published to Github, please include the following in pubspec.yaml
```
name: swagger
version: 1.0.0
description: Swagger API client
dependencies:
  swagger:
    git: https://github.com//.git
      version: 'any'
```

### Local
To use the package in your local drive, please include the following in pubspec.yaml
```
dependencies:
  swagger:
    path: /path/to/swagger
```

## Tests

TODO

## Getting Started

Please follow the [installation procedure](#installation--usage) and then run the following:

```dart
import 'package:swagger/api.dart';


var api_instance = new TasksApi();

try {
    var result = api_instance.callGet();
    print(result);
} catch (e) {
    print("Exception when calling TasksApi->callGet: $e\n");
}

```

## Documentation for API Endpoints

All URIs are relative to *https://localhost*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*TasksApi* | [**callGet**](docs//TasksApi.md#callget) | **GET** /api/Tasks | 


## Documentation For Models

 - [Task](docs//Task.md)


## Documentation For Authorization

 All endpoints do not require authorization.


## Author



