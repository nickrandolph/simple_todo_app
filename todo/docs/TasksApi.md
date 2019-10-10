# swagger.api.TasksApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**callGet**](TasksApi.md#callGet) | **GET** /api/Tasks | 


# **callGet**
> List<Task> callGet()



### Example 
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

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<Task>**](Task.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

