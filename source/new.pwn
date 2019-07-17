/*
    Project name:
        Samp Role Play

    Project version:
        0.1
    
    SA-MP version:
        0.3.7-R3
    
    Developer:
        https://github.com/xarland
    
    Website:
        -
*/

#if defined _samprp_included
    #endinput
#endif

#define _samprp_included

/*
    Libraries
*/

// dependencies
#include <a_samp>
#include <a_mysql> // R41-4
#include <sscanf2> // v2.8.3
#define FOREACH_I_Vehicle               0
#define FOREACH_I_Actor                 0
#define FOREACH_I_Character             0
#define FOREACH_I_Bot                   0
#define FOREACH_I_PlayerPlayersStream   0
#define FOREACH_I_VehiclePlayersStream  0
#include <foreach> // v2.2.3 (ziggi fork)
#include <Pawn.Regex> // 1.1.2
#include <formatnumber>
#include <gtolib>
#include <gvar> // v1.3.1 (with sampctl support)
#include <dc_kickfix> // v1.3.4

// configuration
#include "config.inc"

// utils
#include "utils/colors.inc"
#include "utils/useful-lib.inc"

// mysql
#include "mysql/mysql-settings.inc"
#include "mysql/mysql-settings.pwn"

// player
#include "player/player.inc"
#include "player/player.pwn"

/*
    Callbacks
*/

main()
{
    print(!"Samp Role Play (c) 2019");
}

public OnGameModeInit()
{
    MySQL_OnGameModeInit();
    return 1;
}

public OnGameModeExit()
{
    MySQL_OnGameModeExit();
    return 1;
}

public OnPlayerConnect(playerid)
{
    Player_OnPlayerConnect(playerid);
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    Player_OnPlayerDisconnect(playerid, reason);
    return 1;
}

public OnPlayerSpawn(playerid)
{
    // Player_OnPlayerSpawn(playerid);
    return 1;
}
