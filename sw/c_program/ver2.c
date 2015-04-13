void main()
{
	int a, b, c, t, quotient;

	a = 32;
	b = -4;
	c = ~a;
	c = !a;
	c = a+b;
	c = a-b;
	c = a<<4;
	c = a>>4;
	c = 0;
	if(c<a)
		c++;
	if(c<=a)
		c++;
	if(c>b)
		c++;
	if(c>=b)
		c++;
	if(c==0)
		c++;
	if(c!=a)
		c++;
	c = a&b;
	c = a^b;
	c = a|b;
	c = 0;
	if(c&&a)
		c++;	//0
	if(c||a)
		c++;	//1
	if(c&&a)
		c++;	//2

	a = 16; //16
	t = 8; //8
	quotient = 2;	//a / t

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
}