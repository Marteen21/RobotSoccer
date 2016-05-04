n = 12;
ok = true;
for i = 1:n
    p = rand(1);
    if (i == 1)
        P(i,i+1) = 1-p;
        P(i,n) = p;
    elseif (i == 12)
            P(i,1) = 1-p;
            P(i,n-1) = p;
    else
        P(i,i-1) = p;
        P(i,i+1) = 1-p;
    end
end
P               %P mátrix-hoz felírjuk a megfelelõ gráfot, amiben , ha
                %a_ij > 0 akkor i-bõl j-be el lehet jutni
                %a gráf felrajzolása után láthatjuk, hogy minden élbõl
                %mindenhova el tudok jutni, így P mátrix irreducibilis
                
sum = 0;
v = rand(1,n)
for i = 1:n
   sum = sum + v(i); 
end
v = v/sum;
sum = 0;
for i = 1:n
    sum = sum + v(i);
end
for i=1:999
    kaki = v*P^i
end
r = max(eig(P))
[p_root q] = perron(P,'left')

%------------MATHWORKS PERRON-----------------
[V D]=eig(P)
lambda = diag(D);
rho = max(lambda);
tol = 1e-10; % use some small tolerance
ind = find(lambda>=rho*(1-tol));
V = V(:,ind);
A = -V;
b = zeros(size(V,1),1);
sum = 0;
for i=1:n
   sum = sum + (V(i)); 
end
Aeq = sum;
 %Aeq = sum(V,2); %black magic line
beq = 1;
dummy = ones(size(V,2),1);
x = linprog(dummy, A, b, Aeq, beq);
pv = V*x
limit = v*((pv*transpose(q))/(transpose(q)*pv))
%---------------------------------------------