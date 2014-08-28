#include <stdio.h>
#include <time.h>

double newton_sqrt(double n)
{
  double x = 0.0;
  double xn = 0.0;
  int iters = 0;
  int i;
  for (i = 0; i <= (int)n; ++i)
  {
    double val = i*i-n;
    if (val == 0.0)
      return i;
    if (val > 0.0)
    {
      xn = (i+(i-1))/2.0;
      break;
    }
  }
  while (!(iters++ >= 1000000 || x == xn))
  {
    x = xn;
    xn = x - (x * x - n) / (2 * x);
  }

  return xn;
}

/*
int main() {
	clock_t tic = clock();
	int i, k = 123456789;
    for(i = 0; i < 500; i ++) {
    	newton_sqrt(k);
    	k = k + 1;
    }

    clock_t toc = clock();

    printf("Elapsed: %f seconds\n", (double)(toc - tic) / CLOCKS_PER_SEC);
}*/