# Concepts
- User is assigned a role.
- A role is granted set of permissions on a resource.
- Each resource have permissions

# API
- POST `/auth/login`: authenticate a user and send the access token back.
- POST `/auth/logout`: expires the access token
- Get `/permissions/resource/{resourceId}` list user permission for resource
- POST `/permissions/resource/{resourceId}` grant or update user permission for resource.
- Delete `/permissions/resource/{resoureId}/user/{userId}` revokes all given user permission for the given resource.
