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

    // neg(G1 * a) where a = 2                                                                                                                                                                                                                     
    uint256 constant NEG_G1_A_X = 1368015179489954701390400359078579693043519447331113978918064868415326638035;                                                                                                                                    
    uint256 constant NEG_G1_A_Y = 11970132820537103637166003141937572314130795164147247315533067598634108082819;                                                                                                                                   
                                                                                                                                                                                                                                                    
    // G2 * b where b = 13                                                                                                                                                                                                                         
    uint256 constant G2_B_X0 = 16137324789686743234629608741537369181251990815455155257427276976918350071287;                                                                                                                                      
    uint256 constant G2_B_X1 = 280672898440571232725436467950720547829638241593507531241322547969961007057;                                                                                                                                        
    uint256 constant G2_B_Y0 = 12136420650226457477690750437223209427924916790606163705631661913973995426040;                                                                                                                                      
    uint256 constant G2_B_Y1 = 17641806683785498955878869918183868440783188556637975525088932771694068429840;                                                                                                                                      
                                                                                                                                                                                                                                                    
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
                                                                                                                                                                                                                                                    
    // G1 * c where c = 4                                                                                                                                                                                                                          
    uint256 constant G1_C_X = 3010198690406615200373504922352659861758983907867017329644089018310584441462;                                                                                                                                        
    uint256 constant G1_C_Y = 4027184618003122424972590350825261965929648733675738730716654005365300998076;                                                                                                                                        
                                                                                                                                                                                                                                                    
    // G2 * delta where delta = 2                                                                                                                                                                                                                  
    uint256 constant G2_DELTA_X0 = 18029695676650738226693292988307914797657423701064905010927197838374790804409;                                                                                                                                  
    uint256 constant G2_DELTA_X1 = 14583779054894525174450323658765874724019480979794335525732096752006891875705;                                                                                                                                  
    uint256 constant G2_DELTA_Y0 = 2140229616977736810657479771656733941598412651537078903776637920509952744750;                                                                                                                                   
    uint256 constant G2_DELTA_Y1 = 11474861747383700316476719153975578001603231366361248090558603872215261634898; 


    function runPairings(
        G1_ECPoint memory A, 
        G2_ECPoint memory B, 
        G1_ECPoint memory C, 
        uint256 x_1, 
        uint256 x_2, 
        uint256 x_3) public returns(bool, uint256, uint256) {

            // need to generate X_1
                // first generate points for X

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
    function pairings(uint256[12] memory input) internal view returns(bool) {
        assembly{
            let success := staticcall(gas(), 0x08, input, 0x0180, output, 0x020)
            if success {
                return(input, 0x20)
            }
        }

        revert("Wrong pariing");
    }

    /**
    */


}