pragma solidity ^0.6.0;

contract HotelRoom {

//Hotel room is vacant or occupied
enum Statuses {Vacant, Occupied}
Statuses currentStatus;

event Occupy(address _occupant, uint _value);
address payable public owner;

constructor() public {
owner = msg.sender;
currentStatus = Statuses.Vacant;

}

modifier onlyWhileVacant {
require(currentStatus == Statuses.Vacant, "Currently Occupied");
_;
}

modifier costs (uint _amount) {

require(msg.value >= _amount, "Not Enough Ether Provided");
_;

}


receive() external payable onlyWhileVacant costs(2 ether) {


currentStatus = Statuses.Occupied;
owner.transfer(msg.value);
emit Occupy(msg.sender, msg.value);
}
}

