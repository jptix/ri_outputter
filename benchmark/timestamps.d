ruby$target:::function-entry
{
  self->start = timestamp;
}

ruby$target:::function-return
/self->start/
{
  @[copyinstr(arg0), copyinstr(arg1)] = avg(timestamp - self->start);
  self->start = 0;
}