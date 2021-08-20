function dYdt = chicken(t, Y)
% TODO - Extract the height h from input vector Y
h = Y(1);

% TODO - Extract the velocity u from input vector Y
u = Y(2);
    
% TODO - Complete expression for dhdt
dhdt = u;
    
% TODO - Complete expression for dudt
dudt = -9.8;

% TODO - Define output column vector dYdt
dYdt = [dhdt;dudt];

end