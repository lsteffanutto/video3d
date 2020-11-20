function [S] = sgm(unaryTerms, alpha);
%unaryterms on deja etait evaluer pour certaine 
% 1 canal unariterm =0 2 canal = disprite =2
Lrd=unaryTerms;
[w, h,r] = size(unaryTerms);
scanline = 2:r; %longueur d'une scanline

cost_sum_init = unaryTerms(1,1,1); %initialise le cout du premier pixel avec juste le unaryTerm
cost_sum=zeros(1,r); %scan line de longueur r pour un pixel

S = zeros(w,h);

for j = 1:h
    
    for i = 1:w
        
        d_p = unaryTerms(i,j,1);
        d_q = unaryTerms(i,j,1:r);
        
        
            
            for i_scan = 1:r %pour chaque pixel de la scan line
                
                if i_scan==1
            
                    cost_sum(1,i_scan) = cost_sum_init; %premier pixel de la scanline
        
                else
                    
                    cost_sum(1,i_scan) = unaryTerms(i,j,i_scan) + min(cost_sum(1,i_scan-1) + alpha * abs(d_p - d_q(i_scan-1)));
                
                end
                
            end
            
        end
        
        Lrd(i,j,:) = cost_sum(1,:);
        
    end
S = Lrd;
end
