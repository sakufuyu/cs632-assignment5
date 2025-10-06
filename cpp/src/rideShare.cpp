#include <iostream>
#include <string>
#include <vector>
#include <memory>

// Ride class
class Ride {
    protected:
        int rideID;
        std::string pickupLocation;
        std::string dropoffLocation;
        double distance;
        double baseFare;

    public:
        Ride(int id, std::string pickup, std::string dropoff, double dist) {
            this->rideID = id;
            this->pickupLocation = pickup;
            this->dropoffLocation = dropoff;
            this->distance = dist;
            this->baseFare = 1.0;
        }

        virtual double fare() const {
            return distance * baseFare;
        }

        virtual void rideDetails() const {
            std::cout << "Ride ID: " << rideID << std::endl;
            std::cout << "Pickup: " << pickupLocation << std::endl;
            std::cout << "Dropoff: " << dropoffLocation << std::endl;
            std::cout << "Distance: " << distance << " miles" << std::endl;
            std::cout << "Fare: $" << fare() << std::endl;
        }

        int getRideID() const { return rideID; }
};

// StandardRide class
class StandardRide : public Ride {
    public:
        StandardRide(int id, std::string pickup, std::string dropoff, double dist) 
            : Ride(id, pickup, dropoff, dist) {
            this->baseFare = 2.0;
        }

        void rideDetails() const override {
            std::cout << "=== Standard Ride ===" << std::endl;
            Ride::rideDetails();
        }
};

// PremiumRide class
class PremiumRide : public Ride {
    private:
        double premiumFee;

    public:
        PremiumRide(int id, std::string pickup, std::string dropoff, double dist) 
            : Ride(id, pickup, dropoff, dist) {
            this->premiumFee = 10.0;
            this->baseFare = 3.5;
        }

        double fare() const override {
            return (distance * baseFare) + premiumFee;
        }

        void rideDetails() const override {
            std::cout << "=== Premium Ride ===" << std::endl;
            Ride::rideDetails();
            std::cout << "Premium fee: $" << premiumFee << std::endl;
        }
};

// Driver class 
class Driver {
    private:
        int driverID;
        std::string name;
        double rating;
        std::vector<std::shared_ptr<Ride>> assignedRides; // Capsulation

    public:
        Driver(int id, std::string n, double r) {
            this->driverID = id;
            this->name = n;
            this->rating = r;
        }

        void addRide(std::shared_ptr<Ride> ride) {
            assignedRides.push_back(ride);
        }

        void getDriverInfo() const {
            std::cout << "\n=== Driver Info ===" << std::endl;
            std::cout << "Driver ID: " << driverID << std::endl;
            std::cout << "Name: " << name << std::endl;
            std::cout << "Rating: " << rating << std::endl;
            std::cout << "Assigned Rides: " << assignedRides.size() << std::endl;

            double totalEarnings = 0.0;
            for (const auto& ride : assignedRides) {
                totalEarnings += ride->fare();
            }
            std::cout << "Total earnings: $" << totalEarnings << std::endl;
    }
};

// Rider class
class Rider {
    private:
        int riderID;
        std::string name;
        std::vector<std::shared_ptr<Ride>> requestedRides;

    public:
        Rider(int id, std::string n) {
            this->riderID = id;
            this->name = n;
        }

        void requestRide(std::shared_ptr<Ride> ride) {
            requestedRides.push_back(ride);
            std::cout << "Ride " << ride->getRideID() << " requested by " << name << std::endl;
        }

        void viewRides() const {
            std::cout << "\n=== Ride History for " << name << " ===" << std::endl;
            std::cout << "Rider ID: " << riderID << std::endl;
            std::cout << "Total rides: " << requestedRides.size() << std::endl;

            for (const auto& ride : requestedRides) {
                ride->rideDetails();
                std::cout << "------------------------" << std::endl;
            }
        }
};

int main() {
    // Make Ride object
    auto ride1 = std::make_shared<StandardRide>(1, "Downtown", "Airport", 5.2);
    auto ride2 = std::make_shared<PremiumRide>(2, "Mall", "Hotel", 3.7);

    // Make Driver object
    Driver driver1(101, "Alice Akiyama", 4.8);
    driver1.addRide(ride1);
    driver1.addRide(ride2);
    
    // Maker Rider object
    Rider rider1(201, "Bob Brown");
    rider1.requestRide(ride1);
    rider1.requestRide(ride2);

    // Demonstration of Polymorphism
    std::vector<std::shared_ptr<Ride>> rides = {ride1, ride2};
    std::cout << "\n=== All Rides (Polymorphism Demo) ===" << std::endl;
    for (const auto& ride : rides) {
        ride->rideDetails();
        std::cout << "-------------------------------------" << std::endl;
    }

    // Output Driver info
    driver1.getDriverInfo();

    // Output Rider's history
    rider1.viewRides();

    return 0;
}