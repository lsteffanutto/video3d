clear all;close all;clc;

%% Image Départ
Idist = double(imread('image1.jpg'))/255;
figure,imshow(Idist);title('Image départ');

%On prend 4 points de départ
% [depart]=ginput(4); %prend un point avec un click de souris
% depart=fix(depart);
depart = load('points_departs_photo_feuille.mat');%On les save pour pas refaire le bail à chaque fois

DP1 = [depart.depart(1,1) depart.depart(1,2)] %(x,y) les %p_c_i = points de l'image de la caméra
DP2 = [depart.depart(2,1) depart.depart(2,2)]
DP3 = [depart.depart(3,1) depart.depart(3,2)]
DP4 = [depart.depart(4,1) depart.depart(4,2)]

hold on;
plot(DP1(1,1),DP1(1,2),'r+','MarkerSize', 12, 'LineWidth', 3);
hold on;
plot(DP2(1,1),DP2(1,2),'b+','MarkerSize', 12, 'LineWidth', 3);
hold on;
plot(DP3(1,1),DP3(1,2),'g+','MarkerSize', 12, 'LineWidth', 3);
hold on;
plot(DP4(1,1),DP4(1,2),'y+','MarkerSize', 12, 'LineWidth', 3);

legend('DP1','DP2','DP3','DP4');


%% Homographie



%% Image Finale ( feuille = 21*29,7 )

h_final = 297; % u_i = points plan 3D
w_final = 210; 
d=3;

I_final = zeros(h_final,w_I_corrige,d);

