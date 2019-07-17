#if defined _player_system_h_included
    #endinput
#endif

#define _player_system_h_included

/*
    Enum
*/

enum PlayerInfo
{
    pAccountID,
    pName[MAX_PLAYER_NAME+1],
    pEmail[MAX_EMAIL_SIZE+1],
    pReferral[MAX_PLAYER_NAME+1],
    pGender,
    pSkin,
};

/*
    Forwarded
*/