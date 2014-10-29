define variable LIB_LNX as character no-undo initial "/lib64/libc.so.6".
define variable LIB_WIN as character no-undo initial "C:\Windows\System32\msvcrt.dll".
define variable FUN_LNX_PUTENV as character no-undo initial "putenv".
define variable FUN_WIN_PUTENV as character no-undo initial "_putenv".

define variable FUN_GETENV as character no-undo initial "getenv".

function os-putenv returns integer ( input env as character ):

   define variable hCall as handle     no-undo.
   define variable rVal  as integer    no-undo.
   define variable os    as character  no-undo.

   os = OPSYS.
   create call hCall.

   /* If we are on a windows platform */
   if index(os, "win") <> 0 then
      assign
         hCall:call-name = FUN_WIN_PUTENV
         hCall:library = LIB_WIN
         .
   /* If we are on a unix platform */
   else if index(os, "unix") <> 0 then
      assign
         hCall:call-name = FUN_LNX_PUTENV
         hCall:library = LIB_LNX
         .
   /* Platform unknown */
   else do:
      message "The os is not recognised.".
      return -1.
   end.

   assign
      hCall:call-type = DLL-CALL-TYPE
      hCall:num-parameters = 1
      hCall:return-value-dll-type = "LONG"
      hCall:library-calling-convention = "CDECL"
      .

   hCall:set-parameter( 1, "CHARACTER", "INPUT", env ).
   hCall:invoke().
   rVal = hCall:return-value.
   delete object hCall.

   return rVal.
end.

function os-getenv returns character (input var as character ):
   define variable hCall as handle     no-undo.
   define variable rVal  as integer    no-undo.
   define variable os    as character  no-undo.
   define variable res   as character  no-undo.

   os = OPSYS.
   create call hCall.

    /* If we are on a windows platform */
   if index(os, "win") <> 0 then
      assign
         hCall:library = LIB_WIN
         .
   /* If we are on a unix platform */
   else if index(os, "unix") <> 0 then
      assign
         hCall:library = LIB_LNX
         .
   /* Platform unknown */
   else do:
      message "The os is not recognised.".
      return "The os is not recognised".
   end.

   assign
      hCall:call-name = FUN_GETENV
      hCall:call-type = DLL-CALL-TYPE
      hCall:num-parameters = 1
      hCall:return-value-dll-type = "LONG"
      hCall:library-calling-convention = "CDECL"
      hCall:RETURN-VALUE-DATA-TYPE = "CHARACTER"
      .

   hCall:set-parameter( 1, "CHARACTER", "INPUT", var ).
   /*hCall:set-parameter( 2, "CHARACTER", "OUTPUT", res).*/
   hCall:invoke().
   res = hCall:return-value.
   delete object hCall.

   return res.

end.

message os-getenv(INPUT "PATH") view-as alert-box info.
message os-putenv(INPUT "hom=adf") view-as alert-box info.
message os-getenv(INPUT "hom") view-as alert-box info.
