%%%%%%%%% ALL CALCULATOR %%%%%%%%%%%%
clc
clear all

J=[7.805 ,8.389 ,8.180 ,8.874 ,9.931 ,11.000 ,10.722 ,11.327] %in milliwatt/(cm^2*/sr/micrometer)
J=J*(10^7); % W/(m^2/sr/meter)
Band=[831, 791 , 752, 713, 672, 632, 593, 557]; % in nm. have used the filter value. Wont make much difference in our calculation.
Band=Band*10^-9 % in m
FWHM=[26, 24, 24, 25, 26, 28, 39, 33]; % in nm
FWHM=FWHM*10^-9; %in metre
T_Filter=[0.46, 0.47, 0.48, 0.5, 0.51, 0.52, 0.53, 0.56]; %Maximum transmission
QE_sensor=[0.25, 0.27, 0.34, 0.43, 0.48, 0.54, 0.58, 0.59]; %Quantum Efficiency
t=size(Band);

h = 6.624e-34;
c = 3e8;
photon_energy = ones(t);

for i =1:t(2)
    photon_energy(i) = h*c/Band(i);
end


height=600000; %meter
projection=40; %meter
pitch= 5.5*(10^-6); %meter
f=height*pitch/projection; %meter
Ad = pitch^2;

app=0.06; %Choosen value y ourselves, in meters

f_num=(f/app);
OE= 0.96; % Taken as 4% Optical degradation
phi= ones(t); %%%%% TOTAL FLUX
photon_flux = ones(t); %%%%%%% PHOTON FLUX
radiances = ones(t);

FOV=projection*1024/height;

%%%%%%%%%%% PHOTON FLUX CALCULATION %%%%%%%%%

for i=1:t(2)
       
       phi(i)=cos(5*pi/18)*pi*J(i)*OE*QE_sensor(i)* T_Filter(i)*FWHM(i)*Ad/(4*(f_num)^2); %gives the energy per unit area per unit time at the detector
       radiances(i) = J(i)*OE*QE_sensor(i)* T_Filter(i)*cos(5*pi/18);
       photon_flux = phi(i) / photon_energy(i); %number pf photons per unit time entering our detector
end

radiances = radiances / 10^7;

%%%%%%%%%%%%%% NOISE CALCULATOR %%%%%%%%%%%

S = sum(photon_flux);
target_SNR = 92.95;

dark_current = 125 % e-/s;
shot_noise = sqrt(S);
quantization_noise = 4;
non_uniformity_noise = 0.01 * S;
fixed_pattern_noise = 35;
temporal_noise = 13;

constant_noise_sq = shot_noise^2 + quantization_noise^2 + non_uniformity_noise^2 + fixed_pattern_noise^2 + temporal_noise^2

A = (S/target_SNR)^2;
B = (-1)*dark_current;    % solved quadratic
C = (-1)*constant_noise_sq;

integration_time = (sqrt(B^2 - 4*A*C) - B)/(2*A) 


