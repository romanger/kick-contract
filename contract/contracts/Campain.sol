// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Campain {
    
    struct Request {
        string description;
        uint value;
        address recipient; 
        bool complete;
        uint approvalCount;
        mapping(address => bool) approvals;
    }
    
    address public manager;
    uint public minimumContribution;
    mapping(address => bool) public approvers;
    
    uint public numRequests;
    mapping(uint => Request) public requests;
    
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
        approvers[msg.sender] = true;
    }
    
    function createRequest(string memory description, uint value, address recipient) public onlyManager {
        Request storage newRequest = requests[numRequests++];
        
        newRequest.description = description;
        newRequest.value = value;
        newRequest.recipient = recipient;
        newRequest.complete = false;
        newRequest.approvalCount = 0;
    }

    function approveRequest(uint index) public {
        Request storage request = requests[index];
        
        require(approvers[msg.sender], "Must be a sponsor to approve the requests");
        require(!request.approvals[msg.sender], "Can vote only once");
        
        request.approvals[msg.sender] = true;
        request.approvalCount++;
    }
    
    
    
}