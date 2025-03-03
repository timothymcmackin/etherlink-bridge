// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {ERC20Proxy, hashTicket} from "../src/ERC20Proxy.sol";
import {KernelMock} from "../src/KernelMock.sol";

contract BaseTest is Test {
    ERC20Proxy public token;
    KernelMock public kernel;
    address public alice = vm.addr(0x1);
    address public bob = vm.addr(0x2);
    uint256 public ticketHash;
    bytes22 public ticketer = bytes22("some ticketer");
    bytes22 public wrongTicketer = bytes22("some other ticketer");
    bytes public content = abi.encodePacked("forged content");
    bytes public wrongContent = abi.encodePacked("another forged content");
    bytes public receiver = bytes("some receiver % entrypoint");
    bytes22 public receiver22 = bytes22("some receiver % entryp");

    function setUp() public {
        vm.label(alice, "Alice");
        vm.label(bob, "Bob");
        kernel = new KernelMock();
        token = new ERC20Proxy(
            ticketer,
            content,
            address(kernel),
            "Token",
            "TKN",
            18
        );
        ticketHash = hashTicket(ticketer, content);
    }
}
