// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Structs{

struct Car{ 
   string model;
   uint year;
   address owner;
}

Car public car;
Car[] public cars;
mapping(address => Car[]) public carsByOwner;

function examples() external{
    Car memory fiat = Car("Fiat",2012,msg.sender);
    Car memory lambo = Car({year : 2005,model : "lambo",owner : msg.sender});
    Car memory tesla;
    tesla.model="tesla";
    tesla.year = 2022;
    tesla.owner=msg.sender;

    cars.push(fiat);
    cars.push(lambo);
    cars.push(tesla);

    Car storage _car = cars[0];
    _car.year = 2001;
    delete _car.owner;
    delete cars[1];
}
}
