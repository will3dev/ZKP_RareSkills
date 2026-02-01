pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {BilinearPairings} from "../src/Bilinear_Pairings.sol";

contract PairingsTest is Test {
    BilinearPairings public pairing;

    function setUp() public {
        pairing = new BilinearPairings();
    }

    function test_ValidPairings() public {
        // Test values from Python script output
        // Based on: a=2, b=13, c=4, x_1=1, x_2=2, x_3=3
        // alpha=2, beta=3, gamma=2, delta=2

        // neg(G1 * a) where a = 2
        BilinearPairings.G1_ECPoint memory NEG_A = BilinearPairings.G1_ECPoint({
            x: 1368015179489954701390400359078579693043519447331113978918064868415326638035,
            y: 11970132820537103637166003141937572314130795164147247315533067598634108082819
        });

        // G2 * b where b = 13
        BilinearPairings.G2_ECPoint memory B = BilinearPairings.G2_ECPoint({
            x0: 16137324789686743234629608741537369181251990815455155257427276976918350071287,
            x1: 280672898440571232725436467950720547829638241593507531241322547969961007057,
            y0: 12136420650226457477690750437223209427924916790606163705631661913973995426040,
            y1: 17641806683785498955878869918183868440783188556637975525088932771694068429840
        });

        // G1 * c where c = 4
        BilinearPairings.G1_ECPoint memory C = BilinearPairings.G1_ECPoint({
            x: 3010198690406615200373504922352659861758983907867017329644089018310584441462,
            y: 4027184618003122424972590350825261965929648733675738730716654005365300998076
        });

        // x values (will be used to compute X_1 = x_1*G1 + x_2*G1 + x_3*G1)
        uint256 x_1 = 1;
        uint256 x_2 = 2;
        uint256 x_3 = 3;

        bool result = pairing.runPairings(NEG_A, B, C, x_1, x_2, x_3);

        assertEq(result, true, "Valid pairing should return true");
    }

    function test_InvalidPairings_WrongA() public {
        // Use wrong A value - should fail
        BilinearPairings.G1_ECPoint memory WRONG_NEG_A = BilinearPairings.G1_ECPoint({
            x: 1,
            y: 2
        });

        // Correct B value
        BilinearPairings.G2_ECPoint memory B = BilinearPairings.G2_ECPoint({
            x0: 16137324789686743234629608741537369181251990815455155257427276976918350071287,
            x1: 280672898440571232725436467950720547829638241593507531241322547969961007057,
            y0: 12136420650226457477690750437223209427924916790606163705631661913973995426040,
            y1: 17641806683785498955878869918183868440783188556637975525088932771694068429840
        });

        // Correct C value
        BilinearPairings.G1_ECPoint memory C = BilinearPairings.G1_ECPoint({
            x: 3010198690406615200373504922352659861758983907867017329644089018310584441462,
            y: 4027184618003122424972590350825261965929648733675738730716654005365300998076
        });

        uint256 x_1 = 1;
        uint256 x_2 = 2;
        uint256 x_3 = 3;

        bool result = pairing.runPairings(WRONG_NEG_A, B, C, x_1, x_2, x_3);

        assertEq(result, false, "Invalid pairing should return false");
    }

    function test_InvalidPairings_WrongXValues() public {
        // Use correct A, B, C but wrong x values
        BilinearPairings.G1_ECPoint memory NEG_A = BilinearPairings.G1_ECPoint({
            x: 1368015179489954701390400359078579693043519447331113978918064868415326638035,
            y: 11970132820537103637166003141937572314130795164147247315533067598634108082819
        });

        BilinearPairings.G2_ECPoint memory B = BilinearPairings.G2_ECPoint({
            x0: 16137324789686743234629608741537369181251990815455155257427276976918350071287,
            x1: 280672898440571232725436467950720547829638241593507531241322547969961007057,
            y0: 12136420650226457477690750437223209427924916790606163705631661913973995426040,
            y1: 17641806683785498955878869918183868440783188556637975525088932771694068429840
        });

        BilinearPairings.G1_ECPoint memory C = BilinearPairings.G1_ECPoint({
            x: 3010198690406615200373504922352659861758983907867017329644089018310584441462,
            y: 4027184618003122424972590350825261965929648733675738730716654005365300998076
        });

        // Wrong x values
        uint256 x_1 = 5;
        uint256 x_2 = 6;
        uint256 x_3 = 7;

        bool result = pairing.runPairings(NEG_A, B, C, x_1, x_2, x_3);

        assertEq(result, false, "Invalid x values should return false");
    }
}
