function S = sgm(unaryTerms, alpha)

% on veut les memes dim pour Lr et UnaryTerms

Lrd = unaryTerms; % Lr pour r la direction d = la droite
Lrg = unaryTerms; % gauche
Lrh = unaryTerms; % haut
Lrb = unaryTerms; % bas


[H, W, nd] = size(unaryTerms);



% Lr pour r = gauche->droite
for y=1:H
    for x=2:W
        for d=1:nd

            % Constante/Pénalisation
            P1 = alpha*abs( unaryTerms(y,x-1,d)-unaryTerms(y,x,d) );
            
            % Termes du min
            Voisin1 = Lrd(y,x-1,d);
            if(d == 1)
                Voisin2 = Voisin1;
                Voisin3 = Lrd(y,x-1,d+1) + P1;
            elseif(d == nd)
                Voisin2 = Lrd(y,x-1,d-1) + P1;
                Voisin3 = Voisin1;
            else
                Voisin2 = Lrd(y,x-1,d-1) + P1;
                Voisin3 = Lrd(y,x-1,d+1) + P1;
            end
            
            Lrd(y,x,d) = unaryTerms(y,x,d) + min( [Voisin1 Voisin2 Voisin3] );
            
            
        end
    end
end


% Lrg pour r = droite->gauche
for y=1:H
    for x=W-1:1
        for d=1:nd

            % Constante/Pénalisation
            P1 = alpha*abs( unaryTerms(y,x+1,d)-unaryTerms(y,x,d) );
            
            % Termes du min
            Voisin1 = Lrg(y,x+1,d);
            if(d == 1)
                Voisin2 = Voisin1;
                Voisin3 = Lrg(y,x+1,d+1) + P1;
            elseif(d == nd)
                Voisin2 = Lrg(y,x+1,d-1) + P1;
                Voisin3 = Voisin1;
            else
                Voisin2 = Lrg(y,x+1,d-1) + P1;
                Voisin3 = Lrg(y,x+1,d+1) + P1;
            end
            
            Lrg(y,x,d) = unaryTerms(y,x,d) + min( [Voisin1 Voisin2 Voisin3] );
            
            
        end
    end
end


% Haut
for x=1:W
    for y=2:H
        for d=1:nd

            % Constante/Pénalisation
            P1 = alpha*abs( unaryTerms(y-1,x,d)-unaryTerms(y,x,d) );
            
            % Termes du min
            Voisin1 = Lrh(y-1,x,d);
            if(d == 1)
                Voisin2 = Voisin1;
                Voisin3 = Lrh(y-1,x,d+1) + P1;
            elseif(d == nd)
                Voisin2 = Lrh(y-1,x,d-1) + P1;
                Voisin3 = Voisin1;
            else
                Voisin2 = Lrh(y-1,x,d-1) + P1;
                Voisin3 = Lrh(y-1,x,d+1) + P1;
            end
            
            Lrh(y,x,d) = unaryTerms(y,x,d) + min( [Voisin1 Voisin2 Voisin3] );
            
            
        end
    end
end


% Bas
for x=1:W
    for y=H-1:1
        for d=1:nd

            % Constante/Pénalisation
            P1 = alpha*abs( unaryTerms(y+1,x,d)-unaryTerms(y,x,d) );
            
            % Termes du min
            Voisin1 = Lrb(y+1,x,d);
            if(d == 1)
                Voisin2 = Voisin1;
                Voisin3 = Lrb(y+1,x,d+1) + P1;
            elseif(d == nd)
                Voisin2 = Lrb(y+1,x,d-1) + P1;
                Voisin3 = Voisin1;
            else
                Voisin2 = Lrb(y+1,x,d-1) + P1;
                Voisin3 = Lrb(y+1,x,d+1) + P1;
            end
            
            Lrb(y,x,d) = unaryTerms(y,x,d) + min( [Voisin1 Voisin2 Voisin3] );
            
            
        end
    end
end



S = Lrd+Lrg+Lrh+Lrb;