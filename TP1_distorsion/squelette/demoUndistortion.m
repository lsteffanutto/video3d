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

% [XI ,YI] = getInterpolationGrids(K_reel, k, K_ideal, h_ideal, w_ideal);

%% load image to undistort
Idist = double(imread('videoframe-3.bmp'))/255;
figure,imshow(Idist);
% hold on;
% l1 = [100,100];
% l2 = [100,200];
% plot([l1(2),l2(2)],[l1(1),l2(1)],'r','MarkerSize', 10,'LineWidth',2)

%% undistort image

h_I_corrige = h_ideal;
w_I_corrige = w_ideal;
d=3;

[~,~,d] = size(Idist);

I = zeros(h_I_corrige,w_I_corrige,d);

x=1:w_I_corrige;
y=1:h_I_corrige;
[X,Y] = meshgrid(x,y);

%XI ET YI
figure,
subplot(2,1,1);imagesc(XI);title('XI');
subplot(2,1,2);imagesc(YI);title('YI');

figure,
suptitle('XI, YI, et leurs trans')

subplot(2,2,1); plot(XI); title('XI');        %XI et YI
subplot(2,2,2); plot(YI); title('YI');
 
subplot(2,2,3); plot(XI'); title('XI^T');      %XI' et YI'
subplot(2,2,4); plot(YI'); title('YI^T');

I(:,:,1) = interp2(Idist(:,:,1),YI,XI); % 1er test correction bizarrre
I(:,:,2) = interp2(Idist(:,:,2),YI,XI);
I(:,:,3) = interp2(Idist(:,:,3),YI,XI);

% I(:,:,1) = interp2(Idist(:,:,1),XI,YI); % correction bien mais tourne
% I(:,:,2) = interp2(Idist(:,:,2),XI,YI);
% I(:,:,3) = interp2(Idist(:,:,3),XI,YI);

% I(:,:,1) = interp2(X,Y,Idist(:,:,1),XI,YI); %meshgrid
% I(:,:,2) = interp2(X,Y,Idist(:,:,2),XI,YI);
% I(:,:,3) = interp2(X,Y,Idist(:,:,3),XI,YI);

% I(:,:,1) = interp2(Y,X,Idist(:,:,1),YI,XI);
% I(:,:,2) = interp2(Y,X,Idist(:,:,2),YI,XI);
% I(:,:,3) = interp2(Y,X,Idist(:,:,3),YI,XI);

figure,imshow(I);



