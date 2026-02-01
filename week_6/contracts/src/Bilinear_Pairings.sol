pragma solidity ^0.8.13;







contract BilinearPairings {

    struct G1_ECPoint {
        uint256 x;
        uint256 y;
    }

    struct G2_ECPoint {
        uint256 x0;
        uint256 x1;
        uint256 y0;
        uint256 y1;
    }

    // G1 generator point
    uint256 constant G1_x = 1;
    uint256 constant G1_y = 2;

    // G2 generator point                                                                                                                                                                                                                                                                                                                                                                                                                                
    uint256 constant G2_x0 = 10857046999023057135944570762232829481370756359578518086990519993285655852781;                                                                                                                                                       
    uint256 constant G2_x1 = 11559732032986387107991004021392285783925812861821192530917403151452391805634;                                                                                                                                                         
    uint256 constant G2_y0 = 8495653923123431417604973247489272438418190587263600148770280649306958101930;                                                                                                                                                          
    uint256 constant G2_y1 = 4082367875863433681332203403145435568316851327593401208105741076214120093531;                                                                                                                                  
                                                                                                                                                                                                                                                    
    // G1 * alpha where alpha = 2                                                                                                                                                                                                                  
    uint256 constant G1_ALPHA_X = 1368015179489954701390400359078579693043519447331113978918064868415326638035;                                                                                                                                    
    uint256 constant G1_ALPHA_Y = 9918110051302171585080402603319702774565515993150576347155970296011118125764;                                                                                                                                    
                                                                                                                                                                                                                                                    
    // G2 * beta where beta = 3                                                                                                                                                                                                                    
    uint256 constant G2_BETA_X0 = 2725019753478801796453339367788033689375851816420509565303521482350756874229;                                                                                                                                    
    uint256 constant G2_BETA_X1 = 7273165102799931111715871471550377909735733521218303035754523677688038059653;                                                                                                                                    
    uint256 constant G2_BETA_Y0 = 2512659008974376214222774206987427162027254181373325676825515531566330959255;                                                                                                                                    
    uint256 constant G2_BETA_Y1 = 957874124722006818841961785324909313781880061366718538693995380805373202866;                                                                                                                                     
                                                                                                                                                                                                                                                    
    // X_1 = G1 * x_1 + G1 * x_2 + G1 * x_3 where x_1=1, x_2=2, x_3=3                                                                                                                                                                              
    uint256 constant X1_X = 4503322228978077916651710446042370109107355802721800704639343137502100212473;                                                                                                                                          
    uint256 constant X1_Y = 6132642251294427119375180147349983541569387941788025780665104001559216576968;                                                                                                                                          
                                                                                                                                                                                                                                                    
    // G2 * gamma where gamma = 2                                                                                                                                                                                                                  
    uint256 constant G2_GAMMA_X0 = 18029695676650738226693292988307914797657423701064905010927197838374790804409;                                                                                                                                  
    uint256 constant G2_GAMMA_X1 = 14583779054894525174450323658765874724019480979794335525732096752006891875705;                                                                                                                                  
    uint256 constant G2_GAMMA_Y0 = 2140229616977736810657479771656733941598412651537078903776637920509952744750;                                                                                                                                   
    uint256 constant G2_GAMMA_Y1 = 11474861747383700316476719153975578001603231366361248090558603872215261634898;                                                                                                                                                                                                                                                                     
                                                                                                                                                                                                                                                    
    // G2 * delta where delta = 2                                                                                                                                                                                                                  
    uint256 constant G2_DELTA_X0 = 18029695676650738226693292988307914797657423701064905010927197838374790804409;                                                                                                                                  
    uint256 constant G2_DELTA_X1 = 14583779054894525174450323658765874724019480979794335525732096752006891875705;                                                                                                                                  
    uint256 constant G2_DELTA_Y0 = 2140229616977736810657479771656733941598412651537078903776637920509952744750;                                                                                                                                   
    uint256 constant G2_DELTA_Y1 = 11474861747383700316476719153975578001603231366361248090558603872215261634898; 


    function runPairings(
        G1_ECPoint memory NEG_A,
        G2_ECPoint memory B,
        G1_ECPoint memory C,
        uint256 x_1,
        uint256 x_2,
        uint256 x_3) public view returns(bool) {

            // need to generate X_1
                // complete scalar multiplication for each x value
                (uint256 x1G_x, uint256 x1G_y) = scalarMul(G1_x, G1_y, x_1);
                (uint256 x2G_x, uint256 x2G_y) = scalarMul(G1_x, G1_y, x_2);
                (uint256 x3G_x, uint256 x3G_y) = scalarMul(G1_x, G1_y, x_3);

                // add all three points together to derive X_1; this will require adding first two then adding third to the result of the first operation
                (uint256 sum_x1x2_x, uint256 sum_x1x2_y) = ecAddition(x1G_x, x1G_y, x2G_x, x2G_y);
                (uint256 X1_x, uint256 X1_y) = ecAddition(sum_x1x2_x, sum_x1x2_y, x3G_x, x3G_y);
            
            // Then perform the bilinear pairing
            // G2 points must be in order: (x1, x0, y1, y0)
            uint256[24] memory input = [
                NEG_A.x,
                NEG_A.y,
                B.x1,
                B.x0,
                B.y1,
                B.y0,
                G1_ALPHA_X,
                G1_ALPHA_Y,
                G2_BETA_X1,
                G2_BETA_X0,
                G2_BETA_Y1,
                G2_BETA_Y0,
                X1_x,
                X1_y,
                G2_GAMMA_X1,
                G2_GAMMA_X0,
                G2_GAMMA_Y1,
                G2_GAMMA_Y0,
                C.x,
                C.y,
                G2_DELTA_X1,
                G2_DELTA_X0,
                G2_DELTA_Y1,
                G2_DELTA_Y0
            ];

            return pairings(input);
    }

    // used to perform the ecAddition
    function ecAddition(
        uint256 x_1,
        uint256 y_1,
        uint256 x_2,
        uint256 y_2
    ) internal view returns(uint256 x3, uint256 y3) {
        bytes memory input = abi.encodePacked(x_1, y_1, x_2, y_2);
        
        (bool success, bytes memory out) = address(0x06).staticcall(input);
        require(success && out.length == 64, "ecAdd failed");
        
        assembly {
            x3 := mload(add(out, 0x20))
            y3 := mload(add(out, 0x40))

        }
    }

    // will take a scalar and multiply by a point
    function scalarMul (
        uint256 x,
        uint256 y,
        uint256 scalar
    ) internal view returns(uint256 x3, uint256 y3) {
        bytes memory input = abi.encodePacked(x, y, scalar);
        (bool success, bytes memory out) = address(0x07).staticcall(input);
        require(success && out.length == 64, "scalarMul failed");

        assembly {
            x3 := mload(add(out, 0x20))
            y3 := mload(add(out, 0x40))
        }

    }

    // function checks is a set of pairings is valid
    function pairings(uint256[24] memory input) internal view returns(bool) {
        (bool success, bytes memory out) = address(0x08).staticcall(abi.encodePacked(input));
        require(success && out.length == 32, "pairing failed");
        return abi.decode(out, (uint256)) == 1;
        
    }

    /**
    */


}