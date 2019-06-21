# 2019/06/20
 * Create parameter in `ResponseBuilder´ to deserialize body errors. For example, TMDB api returns this json when occurs errors:
    ```json
    {
      "status_code": 7,
      "status_message": "Invalid API key: You must be granted a valid key."
    }
    ```
 * Create response converters to XML, json, etc.
 * Implement ResponseBuilder to `BigInt`, `DateTime`, `List`, `Map`, `Null` (?), `Set`.

# 2019/06/17
 * Add conversion (`ResponseBuilder`) providers, such as `dynamic` to XML, when `post` method called.
