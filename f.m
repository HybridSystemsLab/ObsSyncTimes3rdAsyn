function xdot = f(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Yuchun Li
%
% 
%
% Description: Flow map
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% global data -----------
global A G

% states
N = length(A);
M = length(G);
xp      = x(1:N);               % state of the consensus variable
xo1     = x(N+1:2*N);
xo2     = x(2*N+1:3*N);
eta1    = x(3*N+1:4*N);
eta2    = x(4*N+1:5*N);
% timer  = x(end-1:end);

xpdot  = A*xp;
xo1dot = A*xo1 + eta1;
xo2dot = A*xo2 + eta2;
eta1dot = zeros(N,1);
eta2dot = zeros(N,1);
timerdot = -ones(M, 1);

xdot = [xpdot;...
        xo1dot;...
        xo2dot;...
        eta1dot;...
        eta2dot;...
        timerdot]; 
    
end