# General
 - In some cases interviewer tries to hide some major requirement 
 - Simplify requirements and system interfaces

## Ultra low latency
 1. e.g. Stock exchange, mission control system
 2. Move different components in a single server
 3. Use unix `mmap` for sharing data between different system. 

# Ticket master problem

# Chat application

# Tinder
 - Technology used
   - elastic search
   - websocket
   - google s3 service
   - dynamo db - for key value store usecases like user profile, matched


 - User matching suggestion based on geo location 
   - see common section for find nearby entity.
 - user changing location:

 - how users are matched based on their likeness.
   - right swiped matches are put on a stream
   - worker checks and save the `like` cache if other user has also liked
   - if yes then both users were notified using websockets and saved in `matched` DB. 
   - left swipe stream can be sinked to low-cost datastore like s3 for data analysis.

 - Services: 1. User Profile Service 2. User Recommendation Service 3. swipe services 


# S3 store
 ## Unique 
  - erasure encoding to achieve 99.999999% availablity
 
# Common problem
 1. find nearby entity

 2. Recommendation service