# Show All Posts With Certain Hashtag

Retrieve all posts information identify by certain Hashtag.

**URL** : `/post/{param}`

**Method** : `GET`

**Auth required** : NO

**Permissions required** : None

## Success Response

**Code** : `200 OK`

**Content examples**

Retrieve all posts with hashtag `new`

* Request

```sh
    http://testserver/post/new
```

* Result

```json
[
    {
        "id":1,
        "message":"Lorem ipsum dolor amet. #new #post",
        "tag":"new"
    },
    {
        "id":2,
        "message":"Lorem ipsum dolor amet. #new",
        "tag":"new"
    }
]
```
