function dy = react_MM_long(t,y,flag,par)

k_on = par(1);
k_off = par(2);
k2 = par(3);
e0 = par(4);
Length = par(5);
csum = 0;
fsum = 0;

m = y(1);
n = y(2);

for i=0:Length-1
    csum = y(2*i+3)+csum;
end

for i=1:Length-1
    fsum = y(2*i+2)+fsum;
end

dy(1) = -k_on.*m.*n+k_off.*csum-k_on.*m.*fsum;
dy(2) = -k_on.*m.*n+k_off.*y(3);

% Equation for Cs
for i=0:Length-1
    dy(2*i+3) = k_on.*m.*y(2*i+2)-k_off.*y(2*i+3)-k2.*y(2*i+3);
end

% Equations for Fs
for i=1:Length-1
    dy(2*i+2) = k2.*y(2*i+1)-k_on.*m.*y(2*i+2)+k_off.*y(2*i+3);
end

% Equation for F_n
dy(2*Length+2) = k2.*(e0-n-csum+y(2*Length+1)-fsum-y(2*Length+2));

dy=dy(:);

end

% m = y(1);
% n = y(2);
% c1 = y(3);
% f1 = y(4);
% c2 = y(5);
% f2 = y(6);
% c3 = y(7);
% f3 = y(8);
% c4 = y(9);
% f4 = y(10);
% c5 = y(11);
% f5 = y(12);
% c6 = y(13);
% f6 = y(14);
% c7 = y(15);
% f7 = y(16);
% c8 = y(17);
% f8 = y(18);
% c9 = y(19);
% f9 = y(20);
% c10 = y(21);
% f10 = y(22);
% 
% dy(1) = -k_on.*m.*n+k_off.*(c1+c2+c3+c4+c5+c6+c7+c8+c9+c10)-k_on.*m.*(f1+f2+f3+f4+f5+f6+f7+f8+f9);
% dy(2) = -k_on.*m.*n+k_off.*c1;
% dy(3) = k_on.*m.*n-k_off.*c1-k2.*c1;
% dy(4) = k2.*c1-k_on.*m.*f1+k_off.*c2;
% dy(5) = k_on.*m.*f1-k_off.*c2-k2.*c2;
% dy(6) = k2.*c2-k_on.*m.*f2+k_off.*c3;
% dy(7) = k_on.*m.*f2-k_off.*c3-k2.*c3;
% dy(8) = k2.*c3-k_on.*m.*f3+k_off.*c4;
% dy(9) = k_on.*m.*f3-k_off.*c4-k2.*c4;
% dy(10) = k2.*c4-k_on.*m.*f4+k_off.*c5;
% dy(11) = k_on.*m.*f4-k_off.*c5-k2.*c5;
% dy(12) = k2.*c5-k_on.*m.*f5+k_off.*c6;
% dy(13) = k_on.*m.*f5-k_off.*c6-k2.*c6;
% dy(14) = k2.*c6-k_on.*m.*f6+k_off.*c7;
% dy(15) = k_on.*m.*f6-k_off.*c7-k2.*c7;
% dy(16) = k2.*c7-k_on.*m.*f7+k_off.*c8;
% dy(17) = k_on.*m.*f7-k_off.*c8-k2.*c8;
% dy(18) = k2.*c8-k_on.*m.*f8+k_off.*c9;
% dy(19) = k_on.*m.*f8-k_off.*c9-k2.*c9;
% dy(20) = k2.*c9-k_on.*m.*f9+k_off.*c10;
% dy(21) = k_on.*m.*f9-k_off.*c10-k2.*c10;
% dy(22) = k2.*(e0-n-c1-c2-c3-c4-c5-c6-c7-c8-c9-f1-f2-f3-f4-f5-f6-f7-f8-f9-f10);
