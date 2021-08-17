# Create a New Comment

Create a new comment on spesific post with 1000 limit of characters and maximum an Attachment per comment.

**URL** : `/comment/`

**Method** : `POST`

**Auth required** : NO

**Permissions required** : None

**Data constraints**

Provide message to create a new comment.

```json
{
    "message": "[more than 1000 chars]"
}
```

**Data example**
Note.
    * You need provide **post_id** related to existing post

```json
{
    "post_id": 123,
    "message": "New comment #new",
    "file": ["select a file or leave it blank"]
}
```

## Success Response

**Condition** : If everything is OK.

**Code** : `200 OK`

## Error Responses

**Condition** : If **post_id** doesn't related with exist post.

**Code** : `400 BAD REQUEST`

**Content example**

```json
    "Post you want to comment not found"
```

### Or

**Condition** : If message field is out of max characters.

**Code** : `400 BAD REQUEST`

**Content example**

```json
    "You out of maximum characters length, try below 1000."
```

### Or

**Condition** : If attachment (file) is not allowed

**Code** : `400 BAD REQUEST`

**Content example**

```json
    "File Not allowed"
```