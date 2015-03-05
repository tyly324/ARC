int main()
{
  int a, b, c;
  long r, s, t;
  char x,y;
  char z[2];

  b = (-3)*(-4); //12 -multiply-minus
  c = 10/(-2); //-5 -immediate-divider
  a = b - c; //17 -r_type-substract
  c = a + (-10); //7 -immediate-hazard

  r = 3*4; //12
  s = 10/2; //5
  t = r-s; //7

  a = t; //7 -move
  t = b; //12

  x = "H";
  y = "i";
  z[0] = x;
  z[1] = y;
}

