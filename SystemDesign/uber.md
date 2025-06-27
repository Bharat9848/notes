## Concepts
1. **Contraction hierarchies** is a speed-up method optimized to exploit the properties of graphs representing road networks. The speed-up is achieved by creating shortcuts in a preprocessing phase, which are then used during a shortest-path query to skip over unimportant vertices
2. supply: can be of car/seat granality
3. demand: can be of car/seat granuality

## requirement
 1. As a rider
   - search cabs before journey starts: after destination selection system shows the driver locations
   - show cab before journey starts: system should show location of cab once driver accepts the trip
   - start/stop of trip notification once driver starts/stops the trip.
   - During the trip, system should show the ETA and trip location
   - payment of the trip
 2. As a driver
   - able to recieve new trips
   - start of the trip
   - end of the trip 

## Non functional requirement
- System reliability
- Availability
- scalability 
- consistent view
- security and data privacy
- Fraud detections
  - Driver drives intentionally slow
  - Driver uses malicious GPS or fradulent trips etc  

## Resource estimation
### Base facts
1. 20 million rides daily - 100 bytes data
2. 500 Million riders with rider metadata like name, id etc - 1000 bytes
3. 5 Million drivers with driver metadata like name, id etc - 1000 bytes
4. Driver location metadata 50 bytes sync freq every 4 sec
### storage requirement
- Riders metadata storage = 500 * 10^6 * 1000 byte = 500GB
- driver metadata storage = 5 * 10^6 * 1000 byte = 5GB
- driver location = (5* 10^6)drivers * 50 bytes = 250 MB/ping
- trip data = (20 * 10^6)trips * 100 bytes = 2GB/day
###  bandwidth
- Trip data ((20 * 10^6)/10^5)rides/sec * 100 bytes per ride  = 20KB/s = 160kbs
- Driver ping: (5 * 10^6)drivers * 50 bytes / 4 sec
- Rider - driver location metadata sync: (500 * 10^6)riders * (8 (driverId) + 50 location) bytes/sec 
### No of servers
- QPS per server = 64000 
- 20 million trips 
- peak load = (20 * 10^6)/64000 = 312 servers

## APIs
1. updateDriverInformation(driverId, newLat, newLong, oldLat, oldLong)
2. findNearbyDrivers(riderId, lat, long)
3. requestRide(riderId, lat, long, dropLat, dropLong, carType)
4. showEta(driverId, eta) ???
5. confirmPickup(driverId, riderId, timestamp)
6. tripUpdates(tripId, riderId, driverId, lat, long, timeElapsed, timeRemaining)
7. endTrip(tripId, riderId, driverId, timestamp, lat, long)

- Entities
  1. trip(sourcewaypoint, destwaypoint, viaWaypoint)
  2. supply(driver, optionalTrip, orderListOfWaypoint, isOnline)

- Cassandra as data store
- Redis as cache  
## Flows
1. Booking
 1. Dispatcher asks the location service for nearby drivers
 2. Then dispatcher asks ETA service to find how really nearby above drivers.(There might be non connected spaces b/w two nearby locations like river etc)
 3. send signals to driver service through supply service about new ride. 
 4. Driver accepts the ride
 5. send notification about booking to rider.

## Components
- Dispatcher
  - match logic
  - asks location service for nearby drivers
  - routing/eta service
- Location service
 - "Geo by supply" API sends geo location of driver
 - "geo by demand" API sends geo location of rider.
 - updates the position of driver to rider irrespective of the trip.
 - work in tendem with quad-tree map service.
 - Do the driver matching
 - proximity data of other drivers also helps in dynamic pricing calculation.
- QuadTreeMap service
  - Map the current location of drivers in the quadtree.
  - quadtree stores the driveId in a segment dynamically
  - split the nodes if driver moves to busy location. Updation is latency heavy so it is done offline. Hash table is used to temporarily cache the location of driver.
- Trip Manager service
  - manages trip related tasks
- ETA service
  - returns the pickup ETA
  - internally calculates the shortest distance and eta between two locations.
  - intersections are nodes, road are edges and traffic is weights
- Driver service
  - exposes `findDriver` service  
- Rider service
  - exposes `requestRide` API and calls driver service to find matching driver   

## New features
- virtual queue at airports
- 3-side marketplace at uber eat
- reservation of car
- batch trip of trip by a driver

## Rough
- driver partner sharded by the city 


## Resources
- Uber design- educative
- [Scaling Uber's Real-time Market Platform](https://www.infoq.com/presentations/uber-market-platform/?ref=highscalability.com)


