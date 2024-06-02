// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.18;

import {console} from "forge-std/console.sol";

contract Base_Test {
    function isZkSyncChain() public returns (bool isZkSync) {
        // https://docs.zksync.io/build/developer-reference/differences-with-ethereum.html#precompiles
        // As of writing, at least 0x03, 0x04, 0x05, and 0x08 precompiles are not supported on zkSync
        // So, we can call them to check if we are on zkSync or not
        // This test may fail in the future if these precompiles become supported on zkSync
        uint256 value = 1;
        address ripemd = address(uint160(3));
        address identity = address(uint160(4));
        address modexp = address(uint160(5));
        address ecPairing = address(uint160(8));

        address[4] memory targets = [ripemd, identity, modexp, ecPairing];

        for (uint256 i = 0; i < targets.length; i++) {
            bool success;
            address target = targets[i];
            assembly {
                success := call(gas(), target, value, 0, 0, 0, 0)
            }
            if (!success) {
                isZkSync = true;
                return isZkSync;
            }
        }
        return isZkSync;
    }

    modifier skipZkSync() {
        if (isZkSyncChain()) {
            console.log("Skipping test because we are on zkSync");
            return;
        } else {
            _;
        }
    }
}
