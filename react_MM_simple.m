function dy = react_MM_simple(t,y,flag,par)

k_on = 1; %fit
k_off = 600; %fit
k2 = 600; %fit
e0 = 80;

m = y(1);
f4 = y(2);

dy(1) = (e0-f4).*(-k_on*m.*(1-k_on*m./((k_off+k2)+k_on*m))+k_off*k_on*m./((k_off+k2)+k_on*m));
dy(2) = k2*k_on*(e0-f4).*m./(4*((k_off+k2)+k_on*m));

dy=dy(:);

end



