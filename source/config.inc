#if defined _configuration_included
    #endinput
#endif

#define _configuration_included

// string defines
#define MESSAGE_LOGOUT  "Для выхода из игры используйте /q(uit)"

// server settings
#define SERVER_NAME "Samp Role Play"

// soundid
#if !defined SOUND_AWARD_TRACK_START
    #define SOUND_AWARD_TRACK_START 1097
#endif

// const
#define MAX_EMAIL_SIZE      128
#define MAX_IP_SIZE         15
#define MAX_SALT_SIZE       10
#define MAX_SHA256HASH_SIZE 64