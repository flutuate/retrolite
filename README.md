# retrolite
**retrolite** is a RESTful API client for Dart and Flutter, with a simple API syntax, without reflection.

This package uses the abstraction classes from [**flutuate_api**](https://github.com/flutuate/retrolite/blob/master/lib/flutuate_api.dart),
used to create RESTful api clients. 

## Configuration
Add `retrolite` to `pubspec.yaml` under the `dependencies` field.

```yaml
dependencies:
  retrolite: ^latest_version
```

## Import
Add the following import in your library :

```dart
import 'package:retrolite/retrolite.dart';
```

## Example
Below, a simple provider sample to [REQ|RES](https://reqres.in) API:
```dart
/// [REQ|RES](https://reqres.in) API provider 
class ReqResApi extends IApi {
  /// Get the users list.
  Future<Response<ListUsers>> listUsers(int page) => 
    client.get<ListUsers>(
      'api/users?page=$page',
      contentType: ContentType.json,
      deserializer: ListUsers.deserialize,
    );

  /// Request the users list with delay.
  Future<Response<ListUsers>> listUsersWithDelay(int delay) => 
    client.get<ListUsers>(
      'api/users',
      queryParameters: {
        'delay': delay
      },
      contentType: ContentType.json,
      deserializer: ListUsers.deserialize,
    );

  /// Request the register service with success.
  Future<Response<RegisterResult>> register(RegisterContent content) => 
    client.post<RegisterResult>(
      'api/register',
      deserializer: RegisterResult.deserialize,
      contentType: ContentType.json,
      body: content
    );
}
```

## Usage
The [sample project](https://github.com/flutuate/retrolite/tree/master/example) has more details about how to use the Retrolite package.

## Features and bugs
Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/flutuate/retrolite/issues
