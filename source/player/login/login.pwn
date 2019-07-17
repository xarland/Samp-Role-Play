#if defined _login_included
    #endinput
#endif

#define _login_included

/*
    Vars
*/

// Barry_Burton

/*
    External func
*/

Login_OnPlayerConnect(playerid)
{
    new string[58 + MAX_PLAYER_NAME];
    mysql_format(gMySQLConnectID, string, sizeof string, 
        "SELECT * FROM `accounts` WHERE BINARY `name` = '%e' LIMIT 1", gPlayerInfo[playerid][pName]);
    mysql_tquery(gMySQLConnectID, string, !"OnFindPlayerInDatabase", !"i", playerid);
    return 1;
}

/*
    Callbacks
*/

public OnFindPlayerInDatabase(playerid)
{
    new rowCount;
    cache_get_row_count(rowCount);
    Dialog_Show(playerid, rowCount ? Dialog:PlayerAuthorization : Dialog:PlayerRegistration);
    return 1;
}

/*
    Internal func
*/