/// Contains who is who, cause i'm not gonna solve identity this weekend!


pragma solidity ^0.4.19;

contract Identity {
  address public owner;
  mapping(address => bytes4) public interfaces;
  mapping(bytes32 => bool) public access;

  constructor() {
    owner = msg.sender;
  }
  
  // @param type Interface hash of record type
  // @param address address of member looking for access;
  function setAccess(address _contract, address _member, bool _hasAccess, uint _type) {
    bytes4 senderInterface = interfaces[_contract];
    access[keccak256(senderInterface, _member, _type)] = _hasAccess;
  }

  function setAddressInterface(address _addr, bytes4 _interface) public onlyOwner {
    interfaces[_addr] = _interface;
  }

  function getAccess(address _contract, address _member, uint _type) public view returns (bool) {
    bytes4 senderInterface = interfaces[_contract];
    return access[keccak256(senderInterface, _member, _type)];
  }

  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

}

