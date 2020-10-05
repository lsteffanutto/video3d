clear all;close all;clc;

figure,imshow(im);

load('points_departs_photo_feuille');

hold on;
plot(x,y,'or');

h = 297;
w = 210; %grille parfaite, tu transforme chaque pixel de l'image pour aller chercher l'interpolation)

u = [ 1 h h 1;1 1 w w; 1 1 1 1];
p = [x' ; y'; 1 1 1 1];

A = zeros(8,8);

for i=1:4
    A(1+2*(i-1):2*i,:) = ['...';'...'];
end