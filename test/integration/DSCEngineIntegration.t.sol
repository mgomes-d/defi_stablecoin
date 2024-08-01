// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployDSC} from "script/DeployDSC.s.sol";
import {DecentralizedStableCoin} from "src/DecentralizedStableCoin.sol";
import {DSCEngine} from "src/DSCEngine.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/ERC20Mock.sol";
import {console} from "forge-std/console.sol";

contract DSCEngineIntegration is Test {
    DeployDSC deployer;
    DecentralizedStableCoin dsc;
    DSCEngine dsce;
    HelperConfig config;
    address ethUsdPriceFeed;
    address btcUsdPriceFeed;
    address wbtc;
    address weth;

    address public USER = makeAddr("user");
    uint256 public constant STARTING_ERC20_BALANCE = 10 ether;
    uint256 public constant AMOUNT_COLLATERAL = 10 ether;
    uint256 public constant AMOUNT_MINTED = 10e8;

    function setUp() public {
        deployer = new DeployDSC();
        (dsc, dsce, config) = deployer.run();
        (ethUsdPriceFeed, btcUsdPriceFeed, weth, wbtc,) = config.activeNetworkConfig();

        ERC20Mock(weth).mint(USER, STARTING_ERC20_BALANCE);
    }
    ///////////////
    //  Modifier //
    ///////////////

    modifier depositedCollateral() {
        vm.startPrank(USER);
        ERC20Mock(weth).approve(address(dsce), AMOUNT_COLLATERAL);
        dsce.depositCollateral(weth, AMOUNT_COLLATERAL);
        vm.stopPrank();
        _;
    }

    modifier mintedDsc() {
        vm.startPrank(USER);
        dsce.mintDsc(AMOUNT_MINTED);
        vm.stopPrank();
        _;
    }


    /////////////////
    // Constructor //
    /////////////////

    function testCheckIfAllTokenIsAdded() public view {
        assertEq(dsce.getPriceFeed(weth), ethUsdPriceFeed);
        assertEq(dsce.getPriceFeed(wbtc), btcUsdPriceFeed);
    }

    /////////////////
    // funtions   //
    ////////////////

    function testDepositCollateral() public {
        vm.startPrank(USER);
        ERC20Mock(weth).approve(address(dsce), AMOUNT_COLLATERAL);
        dsce.depositCollateral(weth, AMOUNT_COLLATERAL);
        (, uint256 collateralValueInUsd) = dsce.getAccountInformation(USER);
        assertEq(dsce.getUsdValue(weth, AMOUNT_COLLATERAL), collateralValueInUsd);
        vm.stopPrank();
    }

    function testMintDsc() public depositedCollateral mintedDsc{
        vm.startPrank(USER);
        (uint256 totalDscMinted,) = dsce.getAccountInformation(USER);
        assertEq(totalDscMinted, AMOUNT_MINTED);
        vm.stopPrank();
    }

    function testDepositCollateralAndMintDsc() public {
        vm.startPrank(USER);
        ERC20Mock(weth).approve(address(dsce), AMOUNT_COLLATERAL);
        dsce.depositCollateralAndMintDsc(weth, AMOUNT_COLLATERAL, AMOUNT_MINTED);
        (uint256 dscMinted, uint256 collateralValueInUsd) = dsce.getAccountInformation(USER);
        assertEq(dscMinted, AMOUNT_MINTED);
        assertEq(dsce.getUsdValue(weth, AMOUNT_COLLATERAL), collateralValueInUsd);
        vm.stopPrank();
    }

    function testRedeemCollateralForDsc public depositedCollateral mintedDsc{
        vm.startPrank(USER);
        
    }
}