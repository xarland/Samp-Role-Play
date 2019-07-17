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
        \n Добро пожаловать на сервер "SERVER_NAME"{B4B5B7}\
        \n       Регистрация нового персонажа\n\n\
        Логин: {BFC0C2}%s{B4B5B7}\n\
        Введите пароль:\n\
        ______________________________________\
    ";
    new string[sizeof fmtstr + MAX_PLAYER_NAME - 2];
    
    format(string, sizeof string, fmtstr, gPlayerInfo[playerid][pName]);
    Dialog_Open(playerid, Dialog:PlayerRegistration, DIALOG_STYLE_INPUT, 
        !"Регистрация", string, !"Готово", !"Отмена");
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
            !"Ошибка!", !"{FF6347}Длина пароля должна быть от 6 до 15 символов", !"Повтор", "");
        return 1;
    }

    if(!IsStringMatchesPattern(inputtext, "\\W"))
    {
        Dialog_Open(playerid, Dialog:PlayerRegistrationReturn, DIALOG_STYLE_MSGBOX,
            !"Ошибка!", 
            !"{00FF21}Введенный вами пароль содержит русские буквы.\n Смените раскладку клавиатуры!", 
            !"Повтор", "");
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
        !"Правила сервера",
        !"1. Игровой процесс\n\
        Запрещено:\n\
        - Использование любых программ скриптов читов и.т.п. дающие нечестное преймущество в игре.\n\
        - Использование багов (Ошибок, Неисправностей мода).\n\
        - Использовать ESC в целях ухода от погони/смерти.\n\
        - Убивать игроков на спавне (Место возрождения, базы организаций).\n\
        - Убивать игроков при помощи транспорта (Давить, Стрелять с водительского места).\n\
        - Убийство/нанесение физического вреда игрокам без причины (ДМ - Death Match).\n\
        - Злоупотребление игровыми возможностями для создания неудобств игрокам.\n\n\
        2. Ник в игре:\n\
        - (сменить ник можно через /mm >> Сменить ник)\n\
        - Ник должен состоять из Имени_Фамилии с заглавных букв.\n\
        Запрещено:\n\
        - Запрещено использовать чужие (уже кем-то занятые) ники.\n\
        - Запрещено использовать ники, содержащие нецензурные или оскорбительные слова.\n\
        - Отправлять более одной заявки в час (Исключение: Просьба Администрации).\n\
        - Если вам отказали в смене ника, Значит нельзя.\n",
        !"Согласен", !"Выйти");
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
        !"Правила сервера",
        !"3. Чат:\n\
        - OOC (Out Of Charter) - это всё, что касается реального мира.\n\
        - IC (In Charter) - это всё, что касается виртульного мира, то есть игры.\n\
        Запрещено:\n\
        - Ругательство, оскорбления или нецензурная речь.\n\
        - Угрозы игрокам (Не относящиеся к игровому процессу).\n\
        - Писать сообщения в верхнем регистре (Caps Lock).\n\
        - Писать в чат объявлений сообщения не относящихся к Role Play.\n\
        - Писать одно и тоже сообщение слишком часто.\n\
        - Обсуждать, критиковать действия администрации.\n\
        - Реклама сторонних ресурсов.\n\n\
        4. Администрация сервера:\n\
        - Необходимо сообщать администрации о каких либо нарушениях из данных правил (/mm > Репорт).\n\
        - Администрация самостоятельно выбирает штрафные санкции для каждого из случаев.\n\
        - Запрещено препятствовать администрации в работе.\n\
        - Решение администрации является окончательным и не подлежит обсуждению.\n\n\
        5. Торговля:\n\
        - Запрещены любые денежные махинации.\n\
        - Запрещена продажа / покупка чего либо, за реальные деньги.\n\
        - Запрещен обмен внеигровых предметов в любой форме, на игровые.\n\
        - Запрещен обмен чего либо между игровыми серверами.\n\
        - Запрещена продажа / передача аккаунтов.\n"
        !"Согласен", !"Выйти");
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
        !"Электронная почта",
        !"Пожалуйста введите действующий адрес электронной почты,\n\
        если вы забудите пароль на него будет выслан новый",
        !"Далее", !"Пропуск");
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
        !"По приглашению от:",
        !"Введите ник игрока, пригласившиго вас на сервер",
        !"Далее", !"Пропуск");
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
        !"Какого пола будет ваш персонаж:\n",
        !"Мужчина", !"Женщина");
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