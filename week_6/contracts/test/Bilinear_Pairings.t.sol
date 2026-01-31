pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {BilinearPairings, Point} from "../src/Bilinear_Pairings.sol";

contract PairingsTest is Test {
    BilinearPairings public pairing;

    function setup() public {
        pairing = new BilinearPairings();
    }

    function test_CheckPairings() public view {

        // A value 
        uint256 aG1_x = 0;
        uint256 aG1_y = 0;

        // B Value
        uint256 bG2_x1 = 0;
        uint256 bG2_x2 = 0;
        uint256 bG2_y1 = 0;
        uint256 bG2_y2 = 0;

        // C value
        uint256 cG1_x = 0;
        uint256 cG1_y = 0;

        // X_1 value
        uint256 xG1_x = 0;
        uint256 xG1_y = 0;

        // x values 
        uint256 x_1 = 1;
        uint256 x_2 = 2;
        uint256 x_3 = 3;

        (bool result, uint256 X1_x, uint256 X2_y) = pairing.runPairings(
            G1_ECPoint(aG1_x, aG1_y),
            G2_ECPoint(bG2_x1, bG2_x2, bG2_y1, bG2_y2),
            G1_ECPoint(cG1_x, cG1_y),
            x_1, 
            x_2, 
            x_3
        );

        assertEq(result, true);

    }
}