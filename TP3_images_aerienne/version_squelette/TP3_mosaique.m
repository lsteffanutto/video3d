clear all;close all;clc;
addpath(genpath('.')); %ajoute tous les chemins vers les fonctions et tout

%% SE METTRE DANS LE DOSSIER "version_squelette" POUR EXECUTER CE CODE

%% Résultats à avoir %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I_all = double(imread('mosaique_all_images.png'))/255;
% figure,imshow(I_all);title('All Images');
% 
% I_2 = double(imread('mosaique_two_images.png'))/255;
% figure,imshow(I_2);title('2 Images');

%% SIFT => https://www.vlfeat.org/overview/sift.html %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% INPUT %%%%%%%%%%%%%%%%

I_test = double(imread('./data/*-0.jpg'))/255 ;
% figure,imsset(h1,'color','k','linewidth',3) ;

I_input_1 = single(rgb2gray(I_test)) ;    %INPUT DE VL_SIFT DOIT ETRE GRAYSCALE + [0;255]
% figure,imshow(I_input_1);title('I Input 1'),drawnow;

I_test = double(imread('./data/*-2.jpg'))/255 ;
% figure,imshow(I_test);title('I Test');
I_input_2 = single(rgb2gray(I_test)) ;    %INPUT DE VL_SIFT DOIT ETRE GRAYSCALE + [0;255]
% figure,imshow(I_input_2);title('I Input 2'),drawnow;
%%%%%%%%%%%%%%%%%%%%%%%%
%% KEYPOINTS AND DESCRIPTORS %%%%%%%%%%%%

% % We compute the SIFT frames (keypoints) and descriptors by
[f,d] = vl_sift(I_input_1) ; 

% We visualize a random selection of 50 features
% figure,imshow(I_input_1);title('I Input 1 avec keypoint and descriptors'),drawnow;
% perm = randperm(size(f,2)) ;
% sel = perm(1:50) ; 
% % sel=13; % Onchope le descripteur 13 qui va avec le 14 = 2eme correspondance
% h1 = vl_plotframe(f(:,sel)) ;
% h2 = vl_plotframe(f(:,sel)) ;
% set(h1,'color','k','linewidth',3) ;
% set(h2,'color','y','linewidth',2) ;
% 
% % We can also overlay the descriptors
% h3 = vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ;
% set(h3,'color','g') ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% CORRESPONDANCE DES POINTS ENTRE 2 IMAGES %%%
Ia = I_input_1;
Ib = I_input_2;

% We extract and match the descriptors with vl_ubcmatch
[fa, da] = vl_sift(Ia) ;
[fb, db] = vl_sift(Ib) ;
[matches, scores] = vl_ubcmatch(da, db) ; %calcul distance avec L2 norm

%The index of the original match and the closest descriptor is stored in each column of matches 
%and the distance between the pair is stored in scores.

%3eme parametre possible for vl_ubcmatch = THRESHOLD
%A descriptor D1 is matched to a descriptor D2 
% only if the distance d(D1,D2) multiplied by THRESH is not greater than 
% the distance of D1 to all other descriptors. The DEFAULT value of THRESH is 1.5. 

% Afficher les appariements
% figure,plotmatches(Ia,Ib,fa,fb,matches);title('Mise en correspondance I1 I2'),drawnow;

%% RANSAC => https://fr.mathworks.com/matlabcentral/fileexchange/30809-ransac-algorithm-with-example-of-finding-homography

x = [ fa(1,matches(1,:)) ; fb(1,matches(2,:))];%matchs des X
y = [ fa(2,matches(1,:)) ; fb(2,matches(2,:))];%matchs des Y

matches_I1 = [x(1,:) ; y(1,:)]; %points de match de l'image 1
matches_I2 = [x(2,:) ; y(2,:)]; %points de match de l'image 2

%On commence par choper juste une correspondance avec les points associés
figure,plotmatches(Ia,Ib,fa,fb,matches(:,2));title('Juste 1 mise en correspondance'),drawnow;
% 2eme match = descripteur 13 I1 avec descripteur 14 I2
plot(matches_I1(1,2),matches_I1(2,2),'r*')
plot(matches_I2(1,2)+461,matches_I2(2,2),'r*') % 2 images côtes à côtes, on ajopute largeur




















