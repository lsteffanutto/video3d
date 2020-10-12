clear all;close all;clc;

%% Image D�part
Idist = double(imread('image1.jpg'))/255;
figure,imshow(Idist);title('Image d�part');

%% Homographie et Image Finale (feuille = 21*29,7)
h_feuille = 297;
w_feuille = 210;

I_finale = zeros(h_feuille,w_feuille);

res = f_extraction2(Idist,I_finale);
figure,imshow(res);title('Image arriv�');

