DEF VAR res AS DECIMAL.

DEF VAR i AS INTEGER.
DEF VAR k AS DECIMAL INIT 123456789.
ETIME(YES).
DO i = 0 TO 500:
    RUN newton_sqrt(k, OUTPUT res).
    k = k + 1.
END.
MESSAGE ETIME
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

PROCEDURE newton_sqrt EXTERNAL "E:\MyWorkspace\progress_with_c\math\sqrt.dll" CDECL:
    DEFINE INPUT PARAMETER n AS DOUBLE .
    DEFINE RETURN PARAMETER res AS DOUBLE.
END.       

C:\Windows\System32\msvcrt.dll