#if defined _registration_included
    #endinput
#endif

#define _registration_included

/*
    Dialogues
*/

DialogCreate:PlayerRegistration(playerid)
{
    static const fmtstr[] = 
    "\
        {B4B5B7}______________________________________\n\
        \n ����� ���������� �� ������ "SERVER_NAME"{B4B5B7}\
        \n       ����������� ������ ���������\n\n\
        �����: {BFC0C2}%s{B4B5B7}\n\
        ������� ������:\n\
        ______________________________________\
    ";
    new string[sizeof fmtstr + MAX_PLAYER_NAME - 2];
    
    format(string, sizeof string, fmtstr, gPlayerInfo[playerid][pName]);
    Dialog_Open(playerid, Dialog:PlayerRegistration, DIALOG_STYLE_INPUT, 
        !"�����������", string, !"������", !"������");
}

DialogResponse:PlayerRegistration(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        SendClientMessage(playerid, COLOR_LIGHT_RED, !MESSAGE_LOGOUT);
        Kick(playerid);
        return 0;
    }

    if(isnull(inputtext)) 
        return Dialog_Show(playerid, Dialog:PlayerRegitration);

    if(!IsStringMatchesPattern(inputtext, "\\w{6,15}"))
    {
        Dialog_Open(playerid, Dialog:PlayerRegistrationReturn, DIALOG_STYLE_MSGBOX, 
            !"������!", !"{FF6347}����� ������ ������ ���� �� 6 �� 15 ��������", !"������", "");
        return 1;
    }

    if(!IsStringMatchesPattern(inputtext, "\\W"))
    {
        Dialog_Open(playerid, Dialog:PlayerRegistrationReturn, DIALOG_STYLE_MSGBOX,
            !"������!", 
            !"{00FF21}��������� ���� ������ �������� ������� �����.\n ������� ��������� ����������!", 
            !"������", "");
        return 1;
    }

    new salt[MAX_SALT_SIZE+1];
    new hash[MAX_SHA256HASH_SIZE+1];

    GenerateRandomString(salt, MAX_SALT_SIZE);
    SHA256_PassHash(inputtext, salt, hash, sizeof hash);
    SetGVarString(!"Password", hash, playerid);
    SetGVarString(!"Salt", salt, playerid);
    PlayerPlaySound(playerid, SOUND_AWARD_TRACK_START, 0.0, 0.0, 0.0);
    state server_rules_page:1;
    Dialog_Show(playerid, Dialog:ServerRules);
    return 1;
}

DialogResponse:PlayerRegistrationReturn(playerid, response, listitem, inputtext) {
    return (response) ? Dialog_Show(playerid, Dialog:PlayerRegistration) : 1;
}

// ServerRules
DialogCreate:ServerRules(playerid) <server_rules_page:1>
{
    Dialog_Open(playerid, Dialog:ServerRules, DIALOG_STYLE_MSGBOX, 
        !"������� �������",
        !"1. ������� �������\n\
        ���������:\n\
        - ������������� ����� �������� �������� ����� �.�.�. ������ ��������� ������������ � ����.\n\
        - ������������� ����� (������, �������������� ����).\n\
        - ������������ ESC � ����� ����� �� ������/������.\n\
        - ������� ������� �� ������ (����� �����������, ���� �����������).\n\
        - ������� ������� ��� ������ ���������� (������, �������� � ������������� �����).\n\
        - ��������/��������� ����������� ����� ������� ��� ������� (�� - Death Match).\n\
        - ��������������� �������� ������������� ��� �������� ��������� �������.\n\n\
        2. ��� � ����:\n\
        - (������� ��� ����� ����� /mm >> ������� ���)\n\
        - ��� ������ �������� �� �����_������� � ��������� ����.\n\
        ���������:\n\
        - ��������� ������������ ����� (��� ���-�� �������) ����.\n\
        - ��������� ������������ ����, ���������� ����������� ��� �������������� �����.\n\
        - ���������� ����� ����� ������ � ��� (����������: ������� �������������).\n\
        - ���� ��� �������� � ����� ����, ������ ������.\n",
        !"��������", !"�����");
}

DialogResponse:ServerRules(playerid, response, listitem, inputtext[]) <server_rules_page:1>
{
    if(!response)
    {
        SendClientMessage(playerid, COLOR_LIGHT_RED, !MESSAGE_LOGOUT);
        Kick(playerid);
        return 0;
    }

    state server_rules_page:2;
    Dialog_Show(playerid, Dialog:ServerRules);
    return 1;
}

DialogCreate:ServerRules(playerid) <server_rules_page:2>
{
    Dialog_Open(playerid, Dialog:ServerRules, DIALOG_STYLE_MSGBOX,
        !"������� �������",
        !"3. ���:\n\
        - OOC (Out Of Charter) - ��� ��, ��� �������� ��������� ����.\n\
        - IC (In Charter) - ��� ��, ��� �������� ����������� ����, �� ���� ����.\n\
        ���������:\n\
        - ������������, ����������� ��� ����������� ����.\n\
        - ������ ������� (�� ����������� � �������� ��������).\n\
        - ������ ��������� � ������� �������� (Caps Lock).\n\
        - ������ � ��� ���������� ��������� �� ����������� � Role Play.\n\
        - ������ ���� � ���� ��������� ������� �����.\n\
        - ���������, ����������� �������� �������������.\n\
        - ������� ��������� ��������.\n\n\
        4. ������������� �������:\n\
        - ���������� �������� ������������� � ����� ���� ���������� �� ������ ������ (/mm > ������).\n\
        - ������������� �������������� �������� �������� ������� ��� ������� �� �������.\n\
        - ��������� �������������� ������������� � ������.\n\
        - ������� ������������� �������� ������������� � �� �������� ����������.\n\n\
        5. ��������:\n\
        - ��������� ����� �������� ���������.\n\
        - ��������� ������� / ������� ���� ����, �� �������� ������.\n\
        - �������� ����� ���������� ��������� � ����� �����, �� �������.\n\
        - �������� ����� ���� ���� ����� �������� ���������.\n\
        - ��������� ������� / �������� ���������.\n"
        !"��������", !"�����");
}

DialogResponse:ServerRules(playerid, response, listitem, inputtext[]) <server_rules_page:2>
{
    if(!response)
    {
        SendClientMessage(playerid, COLOR_LIGHT_RED, !MESSAGE_LOGOUT);
        Kick(playerid);
        return 0;
    }

    Dialog_Show(playerid, Dialog:EnterRegistrationEmail);
    return 1;
}

// EnterRegistrationEmail
DialogCreate:EnterRegistrationEmail(playerid)
{
    Dialog_Open(playerid, Dialog:EnterRegistrationEmail, DIALOG_STYLE_INPUT,
        !"����������� �����",
        !"���������� ������� ����������� ����� ����������� �����,\n\
        ���� �� �������� ������ �� ���� ����� ������ �����",
        !"�����", !"�������");
}

// EnterRegistrationEmail
DialogRepsponse:EnterRegistrationEmail(playerid, response, listitem, inputtext[])
{
    if(response) {
        if(isnull(inputtext))
            return Dialog_Show(playerid, Dialog:EnterRegistrationEmail);

        strmid(gPlayerInfo[playerid][pEmail], inputtext, 0, strlen(inputtext), MAX_EMAIL_SIZE+1);
    }

    Dialog_Show(playerid, Dialog:EnterReferral);
    return 1;
}

// EnterReferral
DialogCreate:EnterReferral(playerid)
{
    Dialog_Open(playerid, Dialog:EnterReferral, DIALOG_STYLE_INPUT,
        !"�� ����������� ��:",
        !"������� ��� ������, ������������� ��� �� ������",
        !"�����", !"�������");
}

DialogResponse:EnterReferral(playerid, response, listitem, inputtext[])
{
    if(response) {
        if(isnull(inputtext))
            return Dialog_Show(playerid, Dialog:EnterReferral);

        strmid(gPlayerInfo[playerid][pReferral], inputtext, 0, strlen(inputtext), MAX_PLAYER_NAME+1);
    }

    Dialog_Open(playerid, Dialog:GenderSelection, DIALOG_STYLE_MSGBOX, 
        !" ",
        !"������ ���� ����� ��� ��������:\n",
        !"�������", !"�������");
    return 1;
}

// GenderSelection
DialogResponse:GenderSelection(playerid, response, listitem, inputtext[])
{
    gPlayerInfo[playerid][pGender] = response ? 1 : 2;
    gPlayerInfo[playerid][pSkin] = response ? 239 : 90;
    SetSpawnInfo(
        playerid, NO_TEAM, gPlayerInfo[playerid][pSkin], 222.3489, -8.5845, 1002.2109, 266.7302, 0, 0, 0, 0, 0, 0);
    SpawnPlayer(playerid);
    return 1;
}