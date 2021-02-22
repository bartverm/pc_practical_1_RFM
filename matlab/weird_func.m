a = (0:400)';
is_odd = mod(a,2)==1;
a(is_odd) = a(is_odd) * 2;
b = sin(log(a)^2);
