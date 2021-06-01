function [dx, y] = RLC(t, x, u, R, L, C, varargin)
%RLC ODE file representing the dynamics of an RLC circuit
%   Copyright Lingling Fan.
vs = u; vc = x(2);
curr = x(1); 
%R = 0.1;

% Output equations.
y = vc; 
% State equations.
dx = [1/L*(u- vc - R*curr);                       
      1/C*curr];
  