# Show Trending Hashtags in The Last 24 Hours

Retrieve 5 trending hashtags in The Last 24 Hours.

**URL** : `/trend/`

**Method** : `GET`

**Auth required** : NO

**Permissions required** : None

## Success Response

**Code** : `200 OK`

**Content examples**

Retrieve 5 most posted hashtag in the past 24 hours

```json
[
    {
        "tag":"new",
        "Total Posted":4
    },
    {
        "tag":"post",
        "Total Posted":3
    }
]
```