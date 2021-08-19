# Create a New Post

Create a new post with 1000 limit of characters and maximum an Attachment per post.

**URL** : `/post/`

**Method** : `POST`

**Auth required** : NO

**Permissions required** : None

**Data constraints**

Provide message to create a new post.

```json
{
    "message": "[more than 1000 chars]"
}
```

**Data example**

```json
{
    "message": "New post #new",
    "file": ["select a file or leave it blank"]
}
```

## Success Response

**Condition** : If everything is OK.

**Code** : `200 OK`

**Content example**

```json
    "Post created successfully"
```

## Error Responses

**Condition** : If message field is empty or out of max characters.

**Code** : `400 BAD REQUEST`

**Content example**

```json
    "Please provide a message or message out of maximum characters length, try below 1000."
```

### Or

**Condition** : If attachment (file) is not allowed

**Code** : `400 BAD REQUEST`

**Content example**

```json
    "File Not allowed"
```