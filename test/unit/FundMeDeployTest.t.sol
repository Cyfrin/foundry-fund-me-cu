// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {FundMe} from "../../src/FundMe.sol";
import {HelperConfig, CodeConstants} from "../../script/HelperConfig.s.sol";
import {Test} from "forge-std/Test.sol";

contract FundMeTest is Test {
    FundMe public fundMe;

    function setUp() public {
        fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    function testDeploy() public view {
        assertEq(address(fundMe.getPriceFeed()), 0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }
}
