

function newton_sqrt return decimal (input n as decimal):
	define variable x as decimal.
	define variable xn as decimal.
	define variable iters as integer.
	define variable i as integer.

	do i = 0 to n:
		define variable val as decimal.
		val = i * i - n.
		if val = 0.0 then
			return i.
		if val > 0.0 then do:
			xn = (i + (i - 1)) / 2.0.
			leave.
		end.
	end.

	do while true:
		if iters >= 1000000 or x = xn then
			leave.
		x = xn.
		xn = x - (x * x - n) / (2 * x).
	end.

	return xn.
end function.

DEF VAR i AS INTEGER.
DEF VAR k AS INTEGER INIT 123456789.
ETIME(YES).
DO i = 0 TO 500:
    newton_sqrt(k).
    k = k + 1.
END.
MESSAGE ETIME
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
