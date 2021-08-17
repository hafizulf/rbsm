# Show All User

Retrieve all users data.

**URL** : `/user/`

**Method** : `GET`

**Auth required** : NO

**Permissions required** : None

## Success Response

**Code** : `200 OK`

**Content examples**

For a User that has saved an username, email and bio description information.

```json
[
    {
        "id": 2,
        "username": "Skuyngoding",
        "email": "skuy@ex.com",
        "bio_desc": "Hi, there!"
    }
]
```