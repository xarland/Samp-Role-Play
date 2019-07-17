#if defined _mysql_settings_included
    #endinput
#endif

#define _mysql_settings_included

/*
    Var
*/

// external var
public MySQL:gMySQLConnectID = MYSQL_INVALID_HANDLE;

/*
    External func
*/

MySQL_OnGameModeInit()
{
    gMySQLConnectID = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB);

    if(0 == mysql_errno(gMySQLConnectID)) {
        SetMySQLEncoding(gMySQLConnectID);
    } else {
        // foreach(new playerid: Player)
        // {
        //     SendClientMessage(playerid, COLOR_LIGHT_RED, 
        //         !"Ошибка подключения к базе данных. Обратитесь в тех. поддержку");
        //     SendClientMessage(playerid, COLOR_LIGHT_RED, !MESSAGE_LOGOUT);
        //     Kick(playerid);
        // }
        SendRconCommand("password srppass");
    }
    return 1;
}

MySQL_OnGameModeExit()
{
    mysql_close(gMySQLConnectID);
    return 1;
}

/*
    Internal func
*/

static stock SetMySQLEncoding(MySQL:handle)
{
    mysql_tquery(handle, !"SET CHARACTER SET 'utf8'");
    mysql_tquery(handle, !"SET NAMES 'utf8'");
    mysql_tquery(handle, !"SET character_set_client = 'cp1251'");
    mysql_tquery(handle, !"SET character_set_connection = 'cp1251'");
    mysql_tquery(handle, !"SET character_set_results = 'cp1251'");
    mysql_tquery(handle, !"SET SESSION collation_connection = 'utf8_general_ci'");
}