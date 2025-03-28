// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Deed.sol";

contract DeedTest is Test {
    Deed public deed;
    address public alice = address(0x1);
    address public bob = address(0x2);
    address public charlie = address(0x3);

    function setUp() public {
        deed = new Deed();
    }

    function testMint() public {
        vm.prank(alice);
        deed.mint(1);
        assertEq(deed.owners(1), alice);
    }

    function testMintFailsIfAlreadyExists() public {
        vm.prank(alice);
        deed.mint(1);

        vm.prank(bob);
        vm.expectRevert("Deed already exists!");
        deed.mint(1);
    }

    function testTransfer() public {
        vm.prank(alice);
        deed.mint(1);

        vm.prank(alice);
        deed.transfer(bob, 1);
        assertEq(deed.owners(1), bob);
    }

    function testTransferFailsIfNotOwner() public {
        vm.prank(alice);
        deed.mint(1);

        vm.prank(bob);
        vm.expectRevert("You don't own this deed!");
        deed.transfer(alice, 1);
    }

    function testApproveAndTransferFrom() public {
        vm.prank(alice);
        deed.mint(1);

        vm.prank(alice);
        deed.approve(bob, 1);

        vm.prank(bob);
        deed.transferFrom(alice, charlie, 1);
        assertEq(deed.owners(1), charlie);
    }

    function testTransferFromFailsIfNotApproved() public {
        vm.prank(alice);
        deed.mint(1);

        vm.prank(charlie);
        vm.expectRevert("Transfer not allowed!");
        deed.transferFrom(alice, bob, 1);
    }

    function testMintEmitsEvent() public {
        vm.expectEmit(true, true, false, false);
        emit Deed.Minted(alice, 1);

        vm.prank(alice);
        deed.mint(1);
    }

    function testTransferEmitsEvent() public {
        vm.prank(alice);
        deed.mint(1);

        vm.expectEmit(true, true, true, false);
        emit Deed.Transferred(alice, bob, 1);

        vm.prank(alice);
        deed.transfer(bob, 1);
    }
}