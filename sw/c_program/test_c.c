int main()
{
  int a, b, c;
  long r, s, t;
  // char x,y;
  // char z[2];
  int quotient;

  a = 32;
  b = -4;
  c = a+b; //28
  c = a+16; //48
  c = a-b; //36
  c = a-16; //16
  c = a*b; //-128
  c = a*2; //64
  c = a/b; //-8
  c = a/2; //16

  r = 32;
  s = 4;
  t = r+s; //36
  t = r+16; //48
  t = r-s; //28
  t = r-16; //16
  t = r*s; //128
  t = r*2; //64
  t = r/s; //8
  t = r/2; //16

  a = t; //16
  t = a/2; //8
  quotient = a / t; //2
  // x = 'H';
  // y = 'i';
  // z[1] = x;
  // z[2] = y;

  while (a > t)
  {
    for (; quotient > 0; quotient--)
    {
      a -= t;
    }
  }
  if (a == 0)
  {
    a = -1;
  }
  return 0;
}
