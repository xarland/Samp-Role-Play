#if defined _useful_library_included
    #endinput
#endif

#define _useful_library_included

/*
    IsStringMatchesPattern
*/

stock IsStringMatchesPattern(const string[], const pattern[])
{
    new Regex:r = Regex_New(pattern);
    new check = Regex_Check(password, r);
    Regex_Delete(r);
    return check;
}