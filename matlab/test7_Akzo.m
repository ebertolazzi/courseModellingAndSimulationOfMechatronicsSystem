%
% Matlab code for the Course:
%
%     Modelling and Simulation Mechatronics System
%
% by
% Enrico Bertolazzi
% Dipartimento di Ingegneria Industriale
% Universita` degli Studi di Trento
% email: enrico.bertolazzi@unitn.it
%
%
% Compare with results in:
%
% https://archimede.dm.uniba.it/~testset/report/chemakzo.pdf
%
addpath('explicit');
addpath('implicit');
addpath('odes');
addpath('daes');

close all;

solver     = Heun();
solver_DAE = Heun_DAE();
dae        = Akzo();

solver.setODE(dae);
solver_DAE.setODE(dae);

tt  = 0:0.05:200;
% setup initial condition
y1  = 0.444;
y4  = 0.007;
Ks  = 115.83;
ini = [ y1, 0.00123, 0, y4, 0, Ks*y1*y4 ];

fprintf('avance with ODE and possible drift\n');
sol= solver.advance( tt, ini );
fprintf('avance with ODE+PROJECTION\n');
sol_DAE = solver_DAE.advance_DAE( tt, ini );
fprintf('done\n');

for kk=1:6
  subplot(3,2,kk);
  plot( tt, sol(kk,:), tt, sol_DAE(kk,:), 'Linewidth', 2 );
end