#if defined _player_system_included
    #endinput
#endif

#define _player_system_included

/*
    Vars
*/

new gPlayerInfo[MAX_PLAYERS][PlayerInfo];
new bool:gPlayerLogged[MAX_PLAYERS char];

/*
    External func
*/

Player_OnPlayerConnect(playerid)
{
    for(new i = 0, j = sizeof (gPlayerInfo[]); i < j; ++i) {
        gPlayerInfo[playerid][PlayerInfo:i] = 0;
    }

    GetPlayerName(playerid, gPlayerInfo[playerid][pName], MAX_PLAYER_NAME+1);
    //Login_OnPlayerConnect(playerid);
    return 1;
}

Player_OnPlayerDisconnect(playerid, reason)
{
    #pragma unused reason, playerid
    return 1;
}

// Player_OnPlayerSpawn(playerid)
// {
//     return 1;
// }

stock IsPlayerLogged(playerid) {
    return gPlayerLogged{playerid};
}

stock SetPlayerLogged(playerid, bool:dest) {
    gPlayerLogged{playerid} = dest;
}