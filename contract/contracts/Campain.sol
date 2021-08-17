// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Campain {
    
    struct Request {
        string description;
        uint value;
        address recipient; 
        bool complete;
    }
    
    address public manager;
    uint public minimumContribution;
    address[] public approvers;
    Request[] public requests;
    
    
    modifier onlyManager() {
        require(msg.sender == manager, "Only manager can run this function");
        _;
    }
    
    constructor(uint minimum) {
        manager = msg.sender;
        minimumContribution = minimum;
    }
    
    
    function contribute() public payable {
        require(msg.value > minimumContribution, "Value must be greater then minimum contribution amount");
        approvers.push(msg.sender);
    }
    
    function createRequest(string memory description, uint value, address recipient) public onlyManager {
        Request memory newRequest = Request({
            description: description,
            value: value,
            recipient: recipient,
            complete: false
        });
        
        requests.push(newRequest);
    }
    
    
    
}