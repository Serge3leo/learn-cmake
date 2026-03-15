	.text
	.global	foo
foo:
	{
	  setwd	wsz = 0x4, nfx = 0x1, dbl = 0x0
	}
	{
	  addd,0,sm	0x0, _f16s,_lts0hi 0x782, %r0
	  return	%ctpr3
	}
	{
	  nop 5
	}
	{
	  ct	%ctpr3
	}
