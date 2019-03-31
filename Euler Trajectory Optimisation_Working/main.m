%% Numerical Optimization
% Direct simulateneous approach using Trapezoidal Quadrature approximation
% of control and dynamics
% This code is only the transcription part of the problem

clc
clear all

t0 = 0;         % Inital time
tf = 5;         % Final time
x0 = [3;pi;0;0]; % Initial state
xf = [0;0;0;0]; %Desired final state
N = 80;         % Number of discrete times
t = t0:(tf-t0)/N:tf; % Discrete times
n = 4;          % Number of states
h = t(2) - t(1);

%Parameterizing the control
w0 = zeros(N,1);    % Initial guess
wl = -100*ones(N,1); % Lower bound
wu = 100*ones(N,1);  % Upper bound

%Parameterizing the states
%Linear interpolation between initial and final is used as the initial
%guess
z0 = (x0*(1-(t/tf))+xf*(t/tf));
z0 = transpose(z0(5:end));
%z0 = zeros(n*N, 1);
zl = -4*ones(n*N,1); % Lower bound
zu = 4*ones(n*N,1);  % Upper bound

%Optimization problem
optNLP = optimset('Display','iter','TolX',1e-5,'TolFun', 1e-5, 'TolCon', 1e-5,...
        'MaxFunEval', 100000,'MaxIter', 1000);
[opt,fval] = fmincon(@(w)obj(w),[w0;z0],[],[],[],[],[wl;zl],[wu;zu],...
@(w)const(t,w,N,n), optNLP);
fval
u = opt(1:N);
u(end+1) = u(end);

%stairs(t,u')
xlabel('Time steps','FontSize', 12);
ylabel('Control input u','FontSize', 12);
figure();
%plot(t,x(1,1:end),'b');
hold on
%plot(t,x(2,1:end),'r');
%plot(t,x(3,:),'g');
%plot(t,x(4,:),'g');
xlabel('Time steps','FontSize', 12);
ylabel('State x','FontSize', 12);
legend('x1','x2');
% To be imported to Mathematica
xt = transpose(x);
csvwrite('trajoptdatx.csv', xt);
csvwrite('trajoptdatu.csv', u);