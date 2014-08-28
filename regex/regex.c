#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>

long match(char * string, char * pattern) {
	// if valid
	if(re_comp(pattern) != 0) {
		return -1;
	}

	// if matches
	if(re_exec(string) == 1) {
		return 1;
	} else {
		return 0;
	}

}

/*

	Creating the dll:
		gcc -c regex.c -L./ -lregex2 					:: -L specifiy library; ./ where the library is
		gcc -shared -o regex.dll regex.o -L./ -lregex2 	:: regex.dll - the name of the output; regex.o - the file where the function is; -L - specify location for library; -llibrary
*/