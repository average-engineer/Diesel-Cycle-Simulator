%engine geometric paramters
bore = 0.1; %meters
stroke = 0.1; %meters
%connecting rod
con_rod = 0.15; %meters
%compression ratio
cr = 24; %cr of an average diesel engine
%state variables at state 1
p1 = 101325; %1 atm pressure
T1 = 800; %kelvins
gamma = 1.4; %for diatomic gases/air
%v1 is the addition of the volume swept by the piston and the clearance vol
v_swept = (pi/4)*bore^2*stroke;
v_clearance = v_swept/(cr-1);
v1 = v_swept + v_clearance;
%cr = (vswept + vclearance)/vclearance = v1/v2

%state variables at state 2
v2 = v_clearance;
p2 = p1*cr^gamma;
T2 = p2*v2*T1/(p1*v1); %using ideal gas equation

%expressions for volume and pressure traces for isentropic compression
const_k1 = p1*(v1^gamma); %constant k1 in the relation PV^gamma = k
V_compression = piston_kinematics(bore,stroke,con_rod,cr,180,0);%compression of chamber vol occurs in 180 deg to 0 deg
P_compression = const_k1./V_compression.^gamma;

%state variables at state 3
p3 = p2; %2-3 is isobaric

%cut-off ratio
r_c = 1.4;%cut off ratio = T3/T2= V3/V2

v3 = r_c*v2;
T3 = r_c*T2;

%state variables at state 4
v4 = v1;
p4 = p3*(v3/v4)^gamma;
T4 = p4*T1/p1; %4-1 is isochoric

%expression of volume and pressure trace for isentropic expansion

const_k2 = p4*(v4^gamma);
V_expansion =  third_state_vol(bore,stroke,con_rod,cr,v1,v3,0,180); %expansion of chamber vol occurs in 0 deg to 180 deg
P_expansion = const_k2./V_expansion.^gamma;

%thermal efficiency of otto engine
%Qin = mCv(T3 - T2), Qout = mCv(T4-T1)
a = (T4 - T1)/(T3 - T2); %Qout/Qin
eff_diesel = 1 - (a/gamma) %efficiency = 1-(Qin/Qout)

%thermal efficiency of carnot engine
eff_carnot = 1 - (T1/T3) %1-(Tlowest/Thighest)

%mean effective pressure

b = gamma*cr^(gamma-1)*(r_c-1);
c = r_c^gamma - 1;
mep = cr*p1*(b-c)/((cr-1)*(gamma-1))

%plotting the pressure and volume values of the state points (PV graph)
figure(1)
hold on
plot(v1,p1,'*','color','r')
plot(v2,p2,'*','color','r')
plot(V_compression,P_compression,'color','r')%plotting the isoentropic compression curve
plot([v2 v3],[p2 p3],'color','y') %plotting the isochoric heat addition line
plot(v3,p3,'*','color','r')
plot(v4,p4,'*','color','r')
plot(V_expansion,P_expansion,'color','b')%plotting the isoentropic expansion curve
plot([v4 v1],[p4 p1],'color','g') %plotting the isochoric heat removal line
axis([0 0.0010 0 10000000])
ylabel('PRESSURE')
xlabel('VOLUME')




