%% Constraints on the states
% Current approximation of dynamics is by Explicit Euler
function  [cineq, ceq] = const(t,w,N,n)
x0 = [3;pi;0;0]; % Initial state
xf = [0;0;0;0]; %Desired final state
cineq = [];
h = t(2) - t(1);
% Equality constraints
%Constraining intial conditions
ceq(1:4) = w(N+1:N+4)-x0;
%Collocation constraints
for i=1:N-1
    ceq(end+1:end+4)=w(N+n*i+1:N+n*i+4)-w(N+n*(i-1)+1:N+n*(i-1)+4)-h*evaldyn([w(N+1+n*(i-1):N+4+n*(i-1));w(i)]);
end
%Constraining the end state
ceq(end+1:end+4) = w(end-3:end);
%ceq(end+1:end+4) = w(end-3:end);
x = [x0,reshape(w(N+1:end),n,N)];
assignin('base', 'x', x)