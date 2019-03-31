%% Objective Function
% Using Trapezoidal quadrature to approximate the integration of the
% control inputs
function [J] = obj(w)
%Change h if time or discretisation is changed and also the number N
N = 80;
h = 5/80;
J = h/2*(2*transpose(w(1:N))*w(1:N)-w(1)^2-w(end)^2);
end