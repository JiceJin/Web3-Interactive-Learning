// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Web3ClubSBT1155.sol";

contract Web3ClubScore{
    mapping(address => mapping(uint256 => bool)) public passList;
    mapping(uint256 => uint256) public goalScore;
    mapping(address => mapping(uint256 => uint256)) public getScore;
    address private owner;
    Web3ClubSBT1155 private sbt;

    constructor(address sbt_address){
        sbt = Web3ClubSBT1155(sbt_address);
        owner = msg.sender;
    }

    function passCheck(address to,uint256 id) public view returns(bool){
        return passList[to][id];
    }

    function setGoalScore(uint256 id, uint256 score) public {
        require(msg.sender == owner,"you are not owner");
        goalScore[id] = score;
        emit evt_setGoalScore(id, score);
    }

    function mint(address to,uint256 id) public {
        require(_getScore(to,id) == goalScore[id], "Please get the goal!");
        require(!passCheck(to,id),"you have got this sbt");
        sbt.mint(to,id);
        passList[to][id] = true;
        emit evt_mint(to,id);
    }
    //加分部分未完成
    function add(address to, uint256 id) public {
        
    }

    function _getScore(address man,uint256 id) internal view returns(uint256){
        return getScore[man][id];
    }

    //事件
    event evt_setGoalScore(uint256 id,uint256 score);
    event evt_mint(address to,uint256 id);
}
