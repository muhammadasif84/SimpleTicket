// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract SimpleTicket {
    address owner;
    uint256 ticketPrice = 0.01 ether;
    mapping(address => uint256) ticketHolders;

    constructor() {
        owner = msg.sender;
    }

    function buyTickets(address _user, uint256 _amount) public payable {
        require(
            msg.value >= ticketPrice * _amount,
            "You dont have sufficient amount"
        );
        addTicket(_user, _amount);
    }

    function useTickets(address _user, uint256 _amount) public {
        subTicket(_user, _amount);
    }

    function addTicket(address _user, uint256 _amount) internal {
        ticketHolders[_user] = ticketHolders[_user] + _amount;
    }

    function subTicket(address _user, uint256 _amount) internal {
        require(ticketHolders[_user] >= _amount, "You dont have tickets");
        ticketHolders[_user] = ticketHolders[_user] - _amount;
    }

    function withdraw() public {
        require(msg.sender == owner, "you are Not the owner");
        (bool success, ) = payable(owner).call{value: address(this).balance}(
            ""
        );
        require(success);
    }
}
