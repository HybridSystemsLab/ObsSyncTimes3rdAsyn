function xplus = g(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file               Author: Yuchun Li
%
% 
%
% Description: Jump map
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global A H1 H2 K11 K12 K21 K22 gamma T1 T2 dropoutrate

% states
N = length(A);
xp      = x(1:N);               % state of the consensus variable
xo1     = x(N+1:2*N);
xo2     = x(2*N+1:3*N);
eta1    = x(3*N+1:4*N);
eta2    = x(4*N+1:5*N);
timer  = x(end-1:end);


xpplus  = xp; 
xo1plus = xo1;
xo2plus = xo2;
eta1plus = eta1;
eta2plus = eta2;
timerplus = timer;

% noise
% m1 = rand + sin(rand);
% m2 = rand + cos(rand);
m1 = 0; m2 = 0;

if rand <= dropoutrate
    drop = 0;
else
    drop = 1;
end

% measurement
yy1 = H1*xp + m1;
yy2 = H2*xp + m2;

timerplus = ones(2,1)*(T1 + (T2 - T1)*rand);

eta1plus = K11*(H1*xo1 - yy1) + drop*K12*(H2*xo2 - yy2) + drop*gamma*(xo1 - xo2);
eta2plus = drop*K21*(H1*xo1 - yy1) + K22*(H2*xo2 - yy2)+ drop*gamma*(xo2 - xo1);

xplus = [xpplus;...
         xo1plus;...
         xo2plus;...
         eta1plus;...
         eta2plus;...
         timerplus];
             
end