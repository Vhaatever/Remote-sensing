%%%%%%%%% ALL CALCULATOR %%%%%%%%%%%%
clc
clear all;

J=0.01 % W/(m^2/sr/meter)
Band=[550]; % in nm. have used the filter value. Wont make much difference in our calculation.

FWHM=[10]; % in nm
T_Filter=[0.6]; %Maximum transmission
QE_sensor=[0.9]; %Quantum Efficiency
t=size(J);

h = 6.624e-34;
c = 3e8;
photon_energy = ones(t);

photon_energy = h*c/(Band*10^-9);

height=750000; %meter
projection=1000; %meter

app=0.09*2; %Choosen value y ourselves, in meters

phi= ones(t); %%%%% TOTAL FLUX
photon_flux = ones(t); %%%%%%% PHOTON FLUX
psi =ones(t);

T=1.37e-4;
psi(:)=pi*((app/2)^2)*(projection^2).*J(:)*T_Filter(:).*FWHM(:)/height^2; %gives the energy per unit time at the detector
photons(:) =psi(:).*QE_sensor(:)*T./ photon_energy(:);



SNR=sqrt(photons); % for 1 sec intergration time-SNR

