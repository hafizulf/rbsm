# Save User Detail

Allow User to save their details.

**URL** : `/user/`

**Method** : `POST`

**Auth required** : NO

**Permissions required** : None

**Data constraints**

```json
{
    "email": "skuy@ex.com"
}
```
* Note that `username` field is **required**
* Note that `id` is currently read only field.

**Data examples**

Partial data is allowed.

```json
{
    "username": "Skuyngoding",
    "email": "skuy@ex.com",
    "bio_desc": "Hi, there!"
}
```

**Email** and **bio_desc** are allowed to Empty fields.

## Success Responses

**Condition** : Data provided is valid.

**Code** : `200 OK`

**Content example** :

```json
    "User successfully saved"
```

## Error Response

**Condition** : If provided data is invalid, e.g. username field is empty.

**Code** : `400 Bad Request`

**Content example** :

```json
    "Please provide a username"
```

## Notes

* Endpoint will ignore irrelevant and read-only data such as parameters that
  don't exist, or fields that are not editable like `id`.