%% simulation of event based static consensus
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Yuchun Li
%
% Description: main function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% global data -----------
clear all
global G A H1 H2 K11 K12 K21 K22 gamma T1 T2 dropoutrate

% plant information 
A  = [0 1 0;-1 0 0;0 0 0]; 
H1 = [1 1 0]; 
H2 = [0 0 1];

%%% parameters 
T1 = 0.2; T2 = 0.4; 
K11 = [-0.5 -0.2 -0.1]';
K12 = [-0.2 -0.2 -0.5]';
K21 = [0.2 0.3 0.3]';
K22 = [-0.1 -0.5 0.2]';
gamma = -0.4;
dropoutrate = 0.1;

%%%% Graph (1) - 2 agents
G = ones(2,2);

%%% -----------------------
% IC for plant states
xp0 = [1 1 1]';

% IC for agent1;
xo10 = [1 0 6]';
eta10 = [1 1 1]';
timer10 = 0.2;

% IC for agent2;
xo20 = [-1 0 3.5]';
eta20 = [-1 -1 -1]';
timer20 = 0.2;

y0 = [xp0; xo10; xo20; eta10; eta20; timer10; timer20]; 

% simulation horizon
TSPAN = [0 60];
JSPAN = [0 20000];

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

options = odeset('RelTol',1e-1,'MaxStep',1e-2);

% simulate
[t y j] = hybridsolver(@f,@g,@C,@D,y0,TSPAN,JSPAN,rule,options,1);


%% - drop out rate simulation
hold on 
ee = (y(:,1) - y(:,4)).^2 + (y(:,1) - y(:,7)).^2 ...
     + (y(:,2) - y(:,5)).^2 + (y(:,2) - y(:,8)).^2 ...
     + (y(:,3) - y(:,6)).^2 + (y(:,3) - y(:,9)).^2;
plot(t, ee.^(1/2))
%%


%%
figure
rate = 1;
plot3(y(1:rate:end,1),y(1:rate:end,2),y(1:rate:end,3),'r','linewidth',2)
hold on 
plot3(y(1:rate:end,4),y(1:rate:end,5),y(1:rate:end,6),'k--','linewidth',1)
plot3(y(1:rate:end,7),y(1:rate:end,8),y(1:rate:end,9),'b-.','linewidth',1)
grid on 
set(gca,'FontSize',20)
legend('x0', 'x1', 'x2')
%%
figure
plot(t, y(:,3),'r','linewidth',2)
hold on
plot(t, y(:,6),'k--','linewidth',1.5)
plot(t, y(:,9),'b-.','linewidth',1.5)
grid on 
set(gca,'FontSize',20)
legend('x0', 'x1', 'x2')

%%
figure
subplot(3,1,1)
plot(t, y(:,3),'r','linewidth',2)
hold on
plot(t, y(:,6),'k--','linewidth',1.5)
plot(t, y(:,9),'b-.','linewidth',1.5)
grid on 
set(gca,'FontSize',20)
legend('x0', 'x1', 'x2')
axis([0 30 -3, 7])
xlabel('t')
subplot(3,1,2)
plotHarcT(t, j, y(:,12), 'k--')
hold on 
plotHarcT(t, j, y(:,15), 'b-.')
% plot(t, y(:,15),'b-.', 'linewidth', 1.5)
grid on 
set(gca,'FontSize',20)
legend('e1', 'e2')
axis([0 5 -3, 2])
subplot(3,1,3)
plotHarcT(t, j, y(:,17), 'b')
grid on 
set(gca,'FontSize',20)
legend('tau')
axis([0 5 0, 0.5])