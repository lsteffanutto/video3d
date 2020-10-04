function [XI,YI] = getInterpolationGrids(K_reel, k, K_ideal, h_ideal, w_ideal)
%outputs : XI,YI grids of size h_ideal x w_ideal
% I_corrige=I_ideale  et I_reel=I_distordu

XI = zeros(h_ideal,w_ideal); %stock coordonnes X
YI = zeros(h_ideal,w_ideal); %stock coordonnes Y

%parcourimage corrigé, p_ = coord pixel = [x;y;1] = coordonnés pixel image corrigé

for y = 1:h_ideal
    for x = 1:w_ideal
        
        p_ = [ x ; y ; 1];                        %tu prends l'image idéal ou y'a rien
        m_focal_ideal = K_ideal\p_; 
        p_d = K_reel* distortion(m_focal_ideal, k); %et tu regarde ce que ses points donnents en image reel distordu
        %mieux computing        %inv(A)*B = A\B 
        YI(y,x) = p_d(1);       % j'inverse le (x,y) ca tourne de 90�
        XI(y,x) = p_d(2);       %stock les coordonnées des points de l'image réelle distordu
        
        
        
    end
end


end

function m_focal_distordu = distortion(m_focal_ideal, k)
%inputs : m_focal_ideal (homogeneous point coordinates in ideal focal plane,  3xN matrix), k (model parameters)
%outputs : m_focal_distordu (homogeneous point coordinates in distorted focal plane,  3xN matrix)

kc = k{1};
xi = k{2};

X = (ones(2,1)*(1./(m_focal_ideal(3,:)+xi*sqrt(m_focal_ideal(1,:).^2+m_focal_ideal(2,:).^2+m_focal_ideal(3,:).^2)))).*m_focal_ideal(1:2,:);%space to nplane


k1 = kc(1);
k2 = kc(2);
k3 = kc(3);
k4 = kc(4);
k5 = kc(5);

nb=size(X);
nb=nb(2);

m_focal_distordu=zeros(3,nb);

for col=1:nb
    x=X(1,col);
    y=X(2,col);
    r2=x^2+y^2;
    radDist= 1 + k1*r2 + k2*r2^2 + k5*r2^3;
    m_focal_distordu(1,col)=x*radDist + 2*k3*x*y + k4*(r2+2*x^2);
    m_focal_distordu(2,col)=y*radDist + k3*(r2+2*y^2) + 2*k4*x*y;
    m_focal_distordu(3,col) = 1;
end

end