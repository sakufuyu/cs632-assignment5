"Ride class"
Object subclass: Ride [
    | rideID pickupLocation dropoffLocation distance baseFare |
    
    <comment: 'Base class for all ride types'>

    initialize [
        baseFare := 1.0.
    ]

    initializeWithID: id pickup: pickup dropoff: dropoff distance: dist [
        rideID := id.
        pickupLocation := pickup.
        dropoffLocation := dropoff.
        distance := dist.
    ]

    fare [
        ^distance * baseFare
    ]

    rideDetails [
        Transcript 
            show: 'Ride ID: '; show: rideID printString; nl;
            show: 'Pickup: '; show: pickupLocation; nl;
            show: 'Dropoff: '; show: dropoffLocation; nl;
            show: 'Distance: '; show: distance printString; show: ' miles'; nl;
            show: 'Fare: $'; show: self fare printString; nl.
    ]
        
    rideID [
        ^rideID
    ]
]

"StandardRide class"
Ride subclass: StandardRide [
    <comment: 'Standard ride with regular pricing'>
    
    initialize [
        super initialize.
        baseFare := 2.0.
    ]
    
    rideDetails [
        Transcript show: '=== Standard Ride ==='; nl.
        super rideDetails.
    ]
]

"PremiumRide class"
Ride subclass: PremiumRide [
    | premiumFee |
    
    <comment: 'Premium ride with higher pricing'>
    
    initialize [
        super initialize.
        baseFare := 3.5. "Premium price"
        premiumFee := 10.0.
    ]
    
    fare [
        ^(distance * baseFare) + premiumFee
    ]
    
    rideDetails [
        Transcript show: '=== Premium Ride ==='; nl.
        super rideDetails.
        Transcript show: 'Premium fee: $'; show: premiumFee printString; nl.
    ]
]

"Driver class"
Object subclass: Driver [
    | driverID name rating assignedRides |
    
    <comment: 'Represents a driver in the ride-sharing system'>
    
    initialize [
        assignedRides := OrderedCollection new.
    ]
    
    initializeWithID: id name: driverName rating: r [
        driverID := id.
        name := driverName.
        rating := r.
    ]
    
    addRide: aRide [
        assignedRides add: aRide.
    ]
    
    getDriverInfo [
        | totalEarnings |
        totalEarnings := 0.
        assignedRides do: [:ride | totalEarnings := totalEarnings + ride fare].
        
        Transcript 
            nl; show: '=== Driver Info ==='; nl;
            show: 'Driver ID: '; show: driverID printString; nl;
            show: 'Name: '; show: name; nl;
            show: 'Rating: '; show: rating printString; nl;
            show: 'Assigned Rides: '; show: assignedRides size printString; nl;
            show: 'Total earnings: $'; show: totalEarnings printString; nl.
    ]
]

"Rider class"
Object subclass: Rider [
    | riderID name requestedRides |
    
    <comment: 'Represents a rider in the ride-sharing system'>
    
    initialize [
        requestedRides := OrderedCollection new.
    ]
    
    initializeWithID: id name: riderName [
        riderID := id.
        name := riderName.
    ]
    
    requestRide: aRide [
        requestedRides add: aRide.
        Transcript 
            show: 'Ride '; 
            show: aRide rideID printString; 
            show: ' requested by '; 
            show: name; nl.
    ]
    
    viewRides [
        Transcript 
            nl; show: '=== Ride History for '; show: name; show: ' ==='; nl;
            show: 'Rider ID: '; show: riderID printString; nl;
            show: 'Total rides: '; show: requestedRides size printString; nl.
            
        requestedRides do: [:ride |
            ride rideDetails.
            Transcript show: '------------------------'; nl.
        ].
    ]
]

"Main program"

"Make Ride object"
ride1 := StandardRide new.
ride1 initialize.
ride1 initializeWithID: 1 pickup: 'Downtown' dropoff: 'Airport' distance: 5.2.

ride2 := PremiumRide new.
ride2 initialize.
ride2 initializeWithID: 2 pickup: 'Mall' dropoff: 'Hotel' distance: 3.7.

"Make Driver object"
driver1 := Driver new.
driver1 initialize.
driver1 initializeWithID: 101 name: 'Alice Akiyama' rating: 4.8.
driver1 addRide: ride1.
driver1 addRide: ride2.

"Make Rider object"
rider1 := Rider new.
rider1 initialize.
rider1 initializeWithID: 201 name: 'Bob Brown'.
rider1 requestRide: ride1.
rider1 requestRide: ride2.

"Demonstration of Polymorphism"
Transcript nl; show: '=== All Rides (Polymorphism Demo) ==='; nl.
rides := OrderedCollection with: ride1 with: ride2.
rides do: [:ride |
    ride rideDetails.
    Transcript show: '------------------------'; nl.
].

"Output Driver info"
driver1 getDriverInfo.

"Output Rider's history"
rider1 viewRides.