## Glossary
- **Threat Modeling**:it is about finding security threats based on an analysis of system architecture, implementation, and deployment.
- security principles
  - least privilege
  - Need to know 
  - Default to no access policy 
- **confuse deputy vulnerability**
- open redirection
- `scope`: defines the action request on the resource. It is part of a auth request.
- `principal`: an entity which claims to be some org, service, user etc.
- `access token`: jwt for authorization, it is for resource manager consumption.
- `identity token`
- `session cookies`
- **Hashing for Message Authention code(HMAC)** authentication algo run over payload and a shared secret key
---
# Attack
- **Dictionary attack**: try guessing password using dictionary password
---

---
# Encryption
## Encryption algorithm
  - AES
  - DES
  - Blowfish
  - Twofish
  - RC4, RC5, RC6
## Symmeteric encryption
  - Same key is used by both receiver and sender.
  - key size max length is 256 bit.
## Asymmeteric encryption
  - Also known as Public Key Infrastructure(PKI)
  - receiver send its public key to sender. sender encrypts the message using receiver's key and sends the message. receiver decrypt the message using its private key.
  - key size is around 2048 bit. 


---


# Attacks
 - Attack surface can be input of the program which includes http protocol properties like header, parameters cookies, filesystem, system property. Similar it can be the output of the program like responses, write to filesystem, database execute query etc
 - Man in the middle attack
 - replay attack
 - sql injection attack
 - cross-site scripting attack(XSS): 
   1. Malicious script run when the compromised website loads in a user browser. Malicious script is saved in website data when attacker put them in any user input. 
   2. In other type of XSS attacks user clicks on false link or false advertisement and it run some script in the browser 
 - Cross-site request forgery(CSRF)
   - user is already logged in the attacked website then user clicks on some attacked website url with some attacker forged payload.
   - solution includes the anti CSRF token is hidden in website forms and when the next time request is submitted by the user then the token is matched. 
 - Denial of service 
   - flood attack: can be based on a `ICMP flood` and `SYN flood`
   - crush attack: attacker somehow able to push bug in the server to crush it
   - Distributed denial of service attack:
   - solution includes Black hole routing and rate limiting

---


# Authentication methods
 - session based authentication ?
 - token based authentication ?
 - basic Auth: user and password are authenticated. the client’s username and password are concatenated, base64-encoded, and passed in the Authorization HTTP header.
 - digest authenticaion: md5 digest if username, password and sever nounce
 - Certificate based 
 - outh2 with openId:
 

---

## Https security
- transit data encryption
-  prevent man in the middle attack by checking domain name on the certificate
- Bidirectional encryption to prevent tempering and evesdropping of on-flight messages. read about hsps policy to allow only https traffic.
- Read about Content Security Policy (CSP) is a computer security standard introduced to prevent cross-site scripting (XSS), clickjacking and other code injection attacks resulting from execution of malicious content in the trusted web page context.
- `X-Frame-option: deny|same-origin` - it is set to prevent any malicious user to use your website inside an iframe
- `X-content-type-options: no-sniff` - it turn off browser's Mime type guessing algorithm for responses with unknown content type

### Secure Socket Layer
  - SSL certificate contains the name of the entity to which certificate is issued, public key of server, digital signature verification?, certificate issuers private key signed digital sinature
  - SSL is deprecated now 
  - Certification Authority: is an organization which is trusted with signing of digital certificate
  - There are different type of security ranging from small to high verification
    1. domain validation certificate
    2. organization validation certificate
    3. Extended validation certificate: owned by banks.
  - Different type of certificate based on domains
    1. single name certificate: not applicable to subdomain
    2. wildcard certificate: applicable to subdomain
    3. multi-domain certificate: applicable to many domains.  
### Transport Layer Security   
  - TLS handshake
    1. `client hello` message to server contains TLS version supported, cipher suite and client random number
    2. `server hello` message to client contains encryption algorithm choosen from client cipher suite, server random and SSL certifcate(public key, digital signature, domain name)
    3. After successful server certificate validation client sends an symmetric key signed with server's public key to server
    4. Session key calculation is done at both ends using symmetric key, client random and server random.
    5. client sends session key encrypted finish message.  
    6. server sends session key encrypted finish message.  


--- 


# Cookies
 - cookie contains following
  1. name of the cookie
  2. value of the cookie
  3. attributes like domain, expiry date, path and flags
 - first party cookie: cookies set by website which is actively viewed by user.
 - third party cookie
 - session cookie: only valid for a session with a website. These cookies are expired as soon as user closes the browser.
 - permanent cookies: valid till its expiry time reached.
 ## Rough
 - "If you visit a website and try to create an account, then you may provide certain information like name, address, phone number, and email address. If the website uses third-party cookies, then your contact information may get revealed to other parties in order to send you spam." 


---

# Oauth
 Oauth main purpose is to allow third-party applications to log in a user on your app. it is an authorization protocol. It do not do any user authentication so in real usecases it comes with separate authentication mechanism.

## Glossary
- `Resource server`: capable to check the access token validity and send back the requested resource.
- `Client`: can be third party or non user id requesting access to a user's resources on behalf of owner user.
- `Resource`: an object or user's data that needs to be protected and stored by resource server.
- `client-id` and `client-secret` belongs to an App through which user with his own credential wants to connect.
- `Authorization server` : handles the client authorization prompting to user and issues access token.
- `Protected resource metadata` is a document offered by resource server.  
- `Authorization request`: request for resource access from client to resource server.
- `Token request`: request form client to auth server for access token.
- `Authorization code`: Code which codifies user credential and client uses the authorization code to redeem access token and refresh token.
- `PKCE`: 
- `redirect URIs`
- `state`: The application generates a random string and includes it in the request. It should then check that the same value is returned after the user authorizes the app. This is used to prevent CSRF attacks.

# Oauth2.0
 - Questions: 
    1. why two steps one for authorization-code and then other for access token ? 
    - To understand this you must first know about two concepts: Front channel: Less secure browser/mobile app to the server channel. Back channel: Highly secure server to server communication channel.It is not safe to share the client secret and get the access token on the front channel.Therefore, we first fetch the authorization code using the front channel and then request the access token using the back channel.
 	2. How authorization code is verified by the authorization server ?
 	3. why shouldnt oauth2 should be used for authentication

 - Resource server:
   1. should return `WWW-Authenticate` http header pointing to location of Resource Metadata location when returning 401 response.

 - Oauth2 Grant-type: A grant type is a flow, a series of steps to gain an access token that is needed to grant limited access to a resource.
  1. password
  2. authorization code: `code` is its response type
  3. refresh token: It is not for resource access but for refreshing the access token without any user redirection.
  4. Implicit: `token` is its resoponse type. Access token is returned in redirect url and it is of a shorter duration. Used in cases for apps with no backend to store client-secret.
  5. client-credential type: for server-server authorization. Happens over POST call with `grant-type:client-credential`. There is no user in this flow. 
  6. resource owner credential: used to migrate from basic/digest authentication to oauth2 authorization

 - Dynamic client registration protocol: 
   1. it allows client to get access token from auth server without user intervention. Provide `client-id` to the new client and  `client-secret` credentials. 
   2. client registration flow ??

 - Auth server handles oauth2 process: 
    1. clientid and scope is sent to Authorization server from a third party client. 
    2. Auth server sends the request to user who owns the resource. 
    3. User approve or reject third party client's request for resource access. If approved auth server send back `Authorization grant` to third party client. 
    4. Third party client then sends `Authorization grant`, it's own `client Id` and `secret` in get access token api. Then authorization server sends the `access token` back to client.
    5. Third party client then sends the `access token` in resource access request. 
 - Resource server 
   1. Error handing: 
      1. it should return 401 in case of expired or invalid token.
      2. it should return 403 in case of insufficient permission in access token.
      3. it should return 400 in case of malformed requests.

---
# Oauth2.1
- replaces oauth 2.0
- application to authorize by resource owner by approval orchestration or by allowing application to access on its own behalf.

## References
- [oauth2.0 dynamic client registration protocol](https://datatracker.ietf.org/doc/html/rfc7591)
- [oauth resource protected metadata](https://datatracker.ietf.org/doc/html/rfc9728)
- [oauth2.0 authorization server metdadata](https://datatracker.ietf.org/doc/html/rfc8414)
- [Resource indicator for oauth2.0](https://www.rfc-editor.org/rfc/rfc8707.html)
- [Draft oauth2.1 auth framework](https://datatracker.ietf.org/doc/html/draft-ietf-oauth-v2-1-14)
- [JWT for oauth2.0](https://www.rfc-editor.org/rfc/rfc9068.html)

## Rough
- client should implement PKCE for authentication code protection
- "PKCE helps prevent authorization code interception and injection attacks by requiring clients to create a secret verifier-challenge pair, ensuring that only the original requestor can exchange an authorization code for tokens."
- client must have redirect URIs registered with the authorization server.
---

# OpenId
## OpenID 1.0
## OpenID 2.0
## OpenID Connect (OIDC)
- It is a authentication extension on top of Oauth2 that adds the claimed login and profile information of the user that is logged in.
- it is the third iteration of OpenId protocol.
- Relying Party: is same as client in OAuth2.
- Identity Provider: This is a server that provides identity information about the End User. This is called Authorization Server in OAuth.
- Authorization server endpoints:
  - Authorization endpoint
  - token endpoint: It exchanges authorization code with access token as well as identity token.
  - userdetails endpoint: returns basic user details for request with access tocken.

- Any of the above API request:
  - `scope`: it can be one or combination of email, phone, profile, openId or address. When scope is openId only identity token is returned and it should be sent in both first authorization API request and token API request.    
  - `claims`: optional field can be one of these-email, email_verified, phone_number, phone_number_verified, name, family_name, given_name, middle_name, nickname, preferred_username, profile picture, website, gender, birthdate, zoneinfo, locale, updated_at, address. Scope field covers some of the category of claims.

- `Identity token`: jwt for authentication response it is for client application.
    - `iss`: authentication server identity.
    - `exp`: token's expiry time.
    - `aud`: client must validate whether it is for client itself.
    - `nonce`: ID token requests may come with a nonce request parameter to protect from replay attacks. When the request parameter is included, the server will embed a nonce claim in the issued ID token with the same value of the request parameter.
    - `auth_time`: time when the end-user authentication occurred.
    - `iat`: millisec time at which identity token was issued.
- Implict Authorization grant flow is similar to oAuth2 flow. But client can access to identity token from authorization as well given the `id_token` is also set in `response_type` request field and scope contains `openId`
- 

---
## Session based authentication
  - website store sessionId cookie in user web browser to know if user is already logged in. It maintains the sessionId to user map on the server side. Each time user sends the request to the server it sends the sessionId. Session id based authetication have limitaions - cookie fraud, performance issue. It is superceded with JWT based authentication

## JSON Web Token(JWT)
 - it can be encrypted, signed, insecured and encrypted with signed.
 - Signed JWT allow other parties to see the data but they will not be able to see it. while encrypted data is for secrecy between two parties.
 - Token structure consist of three parts- Header, payload and signature. All three are base64 encoded.
   1. Header: is a json with two fields - alg, typ. Alg represents the algorithm and type represent whether token is encrypted or signed.
   2. payload: 
      - identify the user name and claim. There are three type of claim
      A. Registered claim Names
        1. `iss`: identifies the principal that issued the JWT.
        2. `sub`: identifies the principal that is the subject of the JWT.
        3. `aud`: identifies the recipients that the JWT is intended for.
        4. `exp`: identifies the expiration time at or after which the JWT MUST NOT be accepted for processing.
        5. `nbf`: identifies the time before which the JWT MUST NOT be accepted for processing.
        6. `iat`: identifies the time at which the JWT was issued.
        7. `jti`: The JWT ID is a unique identifier for the JWT. The identifier value MUST be assigned in a manner that ensures that there is a negligible probability that the same value will be accidentally assigned to a different data object. It can be used to prevent the JWT from being replayed. This is helpful for a one-time use token.

      B. Public claim names
        1. Public claim names are JSON Web Token Claims that can be defined at will by those using JWTs. However, in order to prevent collisions, any new claim name SHOULD either be defined in the IANA Registry, JSON Web Token Claims Registry, or be defined as a URI that contains a collision resistant namespace.

      C. Private claim names
        A producer and consumer of a JWT may agree to any Private claim name that is not a Reserved claim name or a Public claim name. Unlike Public claim names, these Private claim names are subject to collision and should be used with caution.

    3. Signature
    The third and final part of JWT is the signature. It is created by combining the header and payload parts of JWT and then hashing them using a secret key.
    Algo(base64(header) +  base64(payload), secretkey)
 - Signing
   1. JWT token can use HMAC for symmetric encryption or RSA for Asymmetric encryption.
   2. HMAC is used in case of only one server and secret key is shared with client and the single server
   3. RSA is used in case there are multiple server. Signing is done by private key of one server. When token is sent to any other server it is decrypted using public key of the server. RSA is a digital signature algorithm.
 - scope
 - access token
 - refresh token: very dangerous if it is leaked hence it is mostly kept one time only. 
 - custom parameter


----


## CORS
 - `CORS policy` is a set on server to allow or disallow web requests from different domain than that of a server.
 - server sets headers `Access-Control-Allow-Origin=<*|>`, `Access-Control-Allow-Methods=<GET|POST|OPTIONS>`,`Access-Control-Max-Age=<number e.g. 3600>` and `Access-Control-Allow-Headers=<headers list e.g. X-PINGOTHER,Content-Type,X-Requested-With,accept,Origin,Access-Control-Request-Method,Access-Control-Request-Headers,Authorization`

----

## Spring boot security
 - `OncePerRequestFilter` 
 - security filter chain 
 - `UserDetails`

----

----
# Authorization 

# Authorization Models

## Access Control List
- Resource have access control list
- users are directly added into the list.
- also called Identity based authorization control
- suffers from `privilege creep` - as you stay longer within org you tend to accumulate lot of privileges.

## Role Based Authorizaition Control
- anti-pattern: permission based identity token.
- Modeling:
  - User
    - Role(N)
      - Grant/Permission(N) 
        - Action(N)
  - Project
  - Resource
    - action
  - Policy
    - Resource
    - Rules
      - action(N), 
      - effect(deny/allow)
      - Role(N)
    - Condition  
  - Org
- Resource can be a project, org, feature flag      
- Policy have scopes
- user have roles. Cross organization role? 
- Each role is granular action permission over a resource
- admin role can access other admin data ?
- resource ownership role, admin role
- Policy Enforcement point (PEP) calls Policy Descision Point to check whether to allow user to perform certain action.
- Policy Decision Point calls Policy Information Point to gather more data from the service
- Policy Administration point manages policies that are enforced with PDP.
- Authorization interface
  - isAuthorized(policy, user, action, resource) 
  - list_resources(policy, user, action, resourceType)
  - list_action_type(policy, user, resource)
  - user.role
  - role.grants(grants means assigned permission)
  - resource.permission
  - Policy(role, grants, permission)
- problems
  - coupling of domain data with authorization data. domain data have user/group ownership which needs to be checked during authorization. Domain data about resource is public/private/private within group. Authorization data is user roles and policy. 
  - performance problem in listing of resources user can see, as it needs authorization check for all the list members.
- Centralized Authorization server 
  - what is role inheritance?
  - what is project scoping
  - environment specific restriction

## Rule based access control or policy based access control
- "If-then" logic in access control list.
- Used for network devices

## x.509 authorisation certificates  



## Relationship-based access control
 - FGA fine grained authorization 
 - heirarchical and transitive permission
 - implementation OpenFGA

## Attribute based access control
- Permission are assigned based on user or resource attributes.

## Policy 
- used for complex access policies

## Library
- Cerbos(Authorization server)

----

# Authentication
 - Type 1 authentication: based something you know
 - Type 2 authentication: based something you have
 - Type 3 authentication: based something you are like biometrics

## Identity provider
- solutions auth0, okta, internal OIDC compliant system
- Provider isssues a identity JWToken which contain basic info like user id, email, role claim etc.
----

## Kerberos
- built in os
- single sign on for network
- `Authentication server` grants Ticket Granted Ticket TGT to username and encrypt it with user password. If user decrypt it successfully that means password is correct. Hence no password on the network.
- mutual authentication: For any other service access `Ticket granting service` check user's decrypted TGT and grant session keys. Session key is again encrypted with user password.  On that ticket, two copies of the exact same session key. One copy of the session key is encrypted once again with my password. That's only available if I typed my password in correctly. The second copy of that session key is encrypted with the service's password or key. So what that means is I have a session key that I can use to encrypt my communication with only if I'm legitimately me. I encrypt my communication to the print server with that session key. And that print server can only decrypt it if that's the legitimate print server because only the legitimate print server can decrypt the session key that's necessary to decrypt my communication. 
## LDAP
- Active directory for authentication server
## SPML and SCIM
## Security Assertion Markup Language SAML
- protocol to extract identity across different fedrated servers.
- Different APP needs SAML token from identity provider and user dont need to login again if user is already sign on.
## OpenId Connect
- protocol to extract identity across different fedrated servers
----

# OpenFGA
## Glossary 
 - tuple(user:relation#object, condition). condition is optional.
 - type: blueprint of an object
 - type definition: mentions relations between types
 - authorization model: set of type definitions
 - store: set of authorization model files
 - object: single instance of an entity in the system
 - user: can be a object(to represent object can relate to an object), user entity, an optional relation(to represent set of user)
 - relation: arbitrary string
 - relation definition: different rules for a specific relation depending upon the different user and object.
 - directly related user type: specific user definition syntax mentioned in relation definition.
 - condition: an expression that evaluates to boolean.
 - Relationship: is instantiation of user and object according to relation definition
 - checkRequest API returns boolean if specified tuple exisits
 - listObject API returns list of objects for which given user have given relationship.
 - listUser API returns list of users for are in given relationship for a given object.
 - contextual tuples are tuples that are additionally added to the API requests
## flow
 ```mermaid
 A[application] --write-> B[openFGA]
 A -read-> B
 ``` 
----

## Rough
- federated authorization protocols such as OAuth to integrate securely with third-party services??
- shared authorization vs service specific authorization
we take this shared secret, combine it with the contents of the webhook by using a cryptographic hash function called HMAC, and get back a long, random-seeming, but entirely deterministic “signature” for the webhook.

- OAuth and OpenID Connect code authentication with the PKCE flow.

Third-party integration for authentication and authorisation using openid-connect standards
Instead, before storing a password, we must first hash it using a hash function such as bcrypt.

Submit action to j_security_check


Message certification is to not to hide the data but certificate is provided means data is not tempered since data is sent from source.
Message encryption is to hide sensitive data at source. Tunnel encryption encrypts all data travelling through tunnel.
 Apitoken are bind to username and seed DRBG algorithm is used to generate random salt

