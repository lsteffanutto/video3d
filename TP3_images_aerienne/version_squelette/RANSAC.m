function [res] = RANSAC(matches_I1,matches_I2,nb_iter)

azar = randperm(28)';

for 1:nb_iter
    
    A1 = [ matches_I1(1,azar();
%     A2 =
end

end

