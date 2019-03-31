%% Does function evaluation given state values
% s containts (x1, x2, x3, x4, u) of that particular instant
function [fval]=evaldyn(s)
fval(1) = s(3);
fval(2) = s(4);
fval(3) = -(s(5)-3*(s(4)^2-3.27*cos(s(2)))*sin(s(2)))/(-3 + cos(s(2))^2);
fval(4) = (-9.81*sin(s(2))+cos(s(2))*(-0.333333*s(5)+s(4)^2*sin(s(2))))/(-3 + cos(s(2))^2);
fval = transpose(fval);
end