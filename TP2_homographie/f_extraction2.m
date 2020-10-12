function [ extraction_finale ] = f_extraction2(I1,I2)
%ajouter le ginput apr�s

[h1 ,l1] = size(I1);
[h2 ,l2] = size(I2);

% figure, imshow(uint8(I1));
% title('I1 DP');
% [depart] = [ 317   250; 540   236; 560   467; 300   500];%homo de base
% [depart] = [ 317   250; 466   236; 462   365; 300   395];
depart = load('points_departs_photo_feuille.mat');

% DP1 = [depart(1,1) depart(1,2)]; %(x,y) %homo de base
% DP2 = [depart(2,1) depart(2,2)];
% DP3 = [depart(3,1) depart(3,2)];
% DP4 = [depart(4,1) depart(4,2)];

DP1 = [depart.depart(1,1) depart.depart(1,2)] %(x,y) les %p_c_i = points de l'image de la cam�ra
DP2 = [depart.depart(2,1) depart.depart(2,2)]
DP3 = [depart.depart(3,1) depart.depart(3,2)]
DP4 = [depart.depart(4,1) depart.depart(4,2)]




DPX_min_max = [ min([DP1(1,1) DP2(1,1) DP3(1,1) DP4(1,1)]) , max([DP1(1,1) DP2(1,1) DP3(1,1) DP4(1,1)]) ];
DPY_min_max = [ min([DP1(1,2) DP2(1,2) DP3(1,2) DP4(1,2)]) , max([DP1(1,2) DP2(1,2) DP3(1,2) DP4(1,2)]) ];

hold on;
plot(DP1(1,1),DP1(1,2),'r+','MarkerSize', 10, 'LineWidth', 3);
hold on;
plot(DP2(1,1),DP2(1,2),'b+','MarkerSize', 10, 'LineWidth', 3);
hold on;
plot(DP3(1,1),DP3(1,2),'g+','MarkerSize', 10, 'LineWidth', 3);
hold on;
plot(DP4(1,1),DP4(1,2),'y+','MarkerSize', 10, 'LineWidth', 3);

% hold on;
% plot(DPX_min_max(1,1),DPY_min_max(1,1),'r*','MarkerSize', 10, 'LineWidth', 1); %Point min
% hold on;
% plot(DPX_min_max(1,2),DPY_min_max(1,2),'g*','MarkerSize', 10, 'LineWidth', 1); %Point max

legend('DP1','DP2','DP3','DP4');

AR1 = [1 ,1];
AR2 = [l2 ,1];
AR3 = [l2 ,h2];
AR4 = [1 ,h2];

extraction_finale=zeros(h2,l2,3);

figure, imshow(uint8(extraction_finale));
title('Points arrivée');
drawnow;

hold on;
plot(AR1,'r*','MarkerSize', 10, 'LineWidth', 3);
hold on;
plot(AR2(1,1),AR2(1,2),'b*','MarkerSize', 10, 'LineWidth', 3);
hold on;
plot(AR3(1,1),AR3(1,2),'g*','MarkerSize', 10, 'LineWidth', 3);
hold on;
plot(AR4(1,1),AR4(1,2),'y*','MarkerSize', 10, 'LineWidth', 3);

legend('AR1','AR2','AR3','AR4');

%homographie H_img qui lie le quadrangle au rectangle
[HOMOG]=homographie(DP1,DP2,DP3,DP4,AR1,AR2,AR3,AR4);
H1=[HOMOG(1,1) HOMOG(2,1) HOMOG(3,1);HOMOG(4,1) HOMOG(5,1) HOMOG(6,1); HOMOG(7,1) HOMOG(8,1) 1];

%On doit regarde où est-ce que les points de depart sont dans le rectangle d'arrivée
%puis les print en homo inverse si ils y sont

for i=1:h2
    for j=1:l2
        a=inv(H1)*[j;i;1];   
        a(1,1)=a(1,1)/a(3,1); 
        a(2,1)=a(2,1)/a(3,1);
        
        if round(a(1,1))>0 && round(a(1,1))<l1 && round(a(2,1))>0 && round(a(2,1))<h1
            
            extraction_finale(i,j,:)=I1(round(a(2,1)),round(a(1,1)),:); % les points était les mêmes points mais de l'autre image falait leur appliquer l'homo
            
        else
            extraction_finale(i,j,:)=I1(i,j,:);
        end
        
    %a=zeros(3,1);
    end
end

% MaskARR = double(roipoly(I1,depart(:,1),depart(:,2)));

% figure, imshow(uint8(extraction_finale));
% title('Extraction finale');
% drawnow;
end

