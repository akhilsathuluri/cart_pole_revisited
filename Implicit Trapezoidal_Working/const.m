%% Constraints on the states
% Current approximation of dynamics is by Trapezoid Quadrature
function  [cineq, ceq] = const(t,w,N,n)
x0 = [3;pi;0;0]; % Initial state
cineq = [];
h = t(2) - t(1);
% Equality constraints
%Constraining intial conditions
ceq(1:4) = w(N+1:N+4)-x0;
%ceq(1:4) = w(N+5:N+8)-x0-h/2*(evaldyn([x0;w(1)])+evaldyn([w(N+5:N+8);w(2)]));
%Collocation constraints
for i=1:N-1
    ceq(end+1:end+4)=w(N+1+n*i:N+4+n*i)-w(N+1+n*(i-1):N+4+n*(i-1))-h/2*(evaldyn([w(N+1+n*i:N+4+n*i);w(1+i)])+evaldyn([w(N+1+n*(i-1):N+4+n*(i-1));w(i)]));
end
%Constraining the end state
%ceq(end+1:end+4) = w(end-3:end)-w(end-7:end-4)-h/2*(evaldyn([w(end-3:end);w(N)])+evaldyn([w(end-7:end-4);w(N-1)]));
%ceq(end+1:end+4) = w(end-3:end)-h*evaldyn([w(end-3:end);w(N-1)]);
ceq(end+1:end+4) = w(end-3:end);
%ceq(end+1) = w(end-3);
%ceq(end+1) = w(end-2);

x = [x0,reshape(w(N+1:end),n,N)];
assignin('base', 'x', x)