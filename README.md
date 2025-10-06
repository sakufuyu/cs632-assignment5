# cs632-assignment5

## Ride-Sharing Application

This project implements a simple ride-sharing system demonstrating object-oriented programming concepts including inheritance, polymorphism, and encapsulation. The application manages rides, drivers, and riders with two types of rides: Standard and Premium.

### Features
- **Ride Management**: Standard rides ($2.0/mile) and Premium rides ($3.5/mile + $10 fee)
- **Driver System**: Track driver information, ratings, and earnings
- **Rider System**: Manage ride requests and history
- **Polymorphism**: Unified handling of different ride types

## Execution Instructions

### C++ Version
Navigate to the `cpp/` directory and compile:
```bash
g++ -std=c++17 src/rideShare.cpp -o bin/rideShare
./bin/rideShare
```

### Smalltalk Version
1. Copy the contents of `smalltalk/ride-sharing.st`
2. Go to https://www.jdoodle.com/execute-smalltalk-online
3. Paste the code and click "Execute"