DEFINE VARIABLE res AS INTEGER.
DEFINE VARIABLE pat AS MEMPTR .
DEFINE VARIABLE str AS MEMPTR .

SET-SIZE(pat) = 50.
SET-SIZE(str) = 50.

PUT-STRING(pat, 1) = ".*are.*".
PUT-STRING(str, 1) = "Ana are mere".

res = 4.
RUN match(INPUT str, INPUT pat, OUTPUT res).
MESSAGE res
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

PROCEDURE match EXTERNAL "E:\MyWorkspace\progress_with_c\regex\regex.dll" CDECL:
    DEFINE INPUT  PARAMETER str     AS MEMPTR.
    DEFINE INPUT  PARAMETER pattern AS MEMPTR.
    DEFINE RETURN PARAMETER res   AS LONG.
END.