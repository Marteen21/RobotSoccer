clear all
close all
T=1;
Ap = Vector2(0,0);
Bp = Vector2(5,0);
Av = Vector2(1,1);
Bv = Vector2(-1,1);
M=[-1,-1,-5;-1,1,0];
M = [Av.D2NVector().RowForm(),dot(Av.D2NVector().RowForm(),Ap.RowForm());
    Bv.D2NVector().RowForm(),dot(Bv.D2NVector().RowForm(),Bp.RowForm())]

%%

% b0 = 0;
% b1 = -1;
% c0 = 5;
% c1 = 1;
% f = @(x) b0-b1*x;
% f2 = @(x) c0-c1*x;
% d0 = 2;
% d1 = 5/2;
% f3 = @(x) -2*x+8;
% %%
% % ezplot( f, 0, 5 )
% % hold on
% % ezplot ( f2, 0, 5)
% % ezplot (f3,0,5)
% % grid on
% % ezplot (@(x) 0,0,5)
% % 
% % %%2 2d shit
% 
% x0a=0;
% vxa=1;
% x0b=5;
% vxb=-1;
% 
% Ax = Line2(vxa,x0a);
% Bx = Line2(vxb,x0b);
% Cx = Ax-Bx;
% 
% y0a=0;
% vya=1;
% y0b=0;
% vyb=1;
% 
% Ay = Line2(vya,y0a);
% By = Line2(vyb,y0b);
% Cy = Ay-By;
% temp = (Ap+Av.*T);

D = Line2(Ap,Bp,Ap+Av.*T,Bp+Bv.*T,0,T);
% ezplot (Cx.Lequ,0,5)

% ezplot (Cy.Lequ,0,5)
ezplot (D.absequation,0,5)
grid on

D.TfromD(2)
