h = 0.001; 
t = 0:h:0.1;
vs = ones(length(t),1); % step excitation
R = 0.1; L = 0.5/377; C = 1/0.2/377;
s = tf('s');
sys = 1/(R*C*s+L*C*s^2+ 1); % from vs to capacitor voltage. 
vc = lsim(sys, vs, t);
[n_vc, m_vc] = size(vc);
vc1 = vc + (rand(n_vc, m_vc) -0.5)*0.1/max(vc);

%% create data for identificatoin
y = vc1; u = vs; 
data = iddata(y, u, h);
data.Tstart = 0;
data.TimeUnit = 's';

%% creat a gray-box model structure
file_name = 'RLC';
Ny = 1; Nu = 1; Nx = 2; 
order = [Ny, Nu, Nx];
parameters = [R*0.9; L*0.8; 1.5*C];
initial_states = [0;0];
Ts = 0;
init_sys = idnlgrey(file_name,order,parameters,initial_states,Ts);
init_sys.TimeUnit = 's';

%% call PEM for optimizatoin
sys = pem(data,init_sys);
compare(data,sys,init_sys);
[sys.Parameters(1).Value, sys.Parameters(2).Value, sys.Parameters(3).Value]

