
clear; close all; clc; dbstop if error;

%% Load ideal parameters

K_ideal = [480 0 826; 0 480 461; 0 0 1]; % K = matrice calibration linéaire 
h_ideal = 900; %hauteur
w_ideal = 1600; %largeur

%% Load camera calibration parameters
calibParam = load('model_parameters.mat');

K_reel = [calibParam.gammac(1) calibParam.alpha_c calibParam.cc(1); 0 calibParam.gammac(2) calibParam.cc(2); 0 0 1]; %K_d
k{1} = calibParam.kc;
k{2} = calibParam.xi;

%% get interpolation grids

[XI ,YI] = getInterpolationGrids(K_reel, k, K_ideal, h_ideal, w_ideal);

%% load image to undistort
Idist = double(imread('videoframe-3.bmp'))/255;
figure,imshow(Idist);

%% undistort image
[~,~,d] = size(Idist);
h=h_ideal
w=w_ideal
d=3;
I = zeros(h,w,d);
% x=1:w;
% y=1:h;

% [X,Y] = meshgrid(1:w,1:h);

I(:,:,1) = interp2(Idist(:,:,1),YI,XI);
I(:,:,2) = interp2(Idist(:,:,2),YI,XI);
I(:,:,3) = interp2(Idist(:,:,3),YI,XI);



figure,imshow(I);



