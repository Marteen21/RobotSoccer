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
D = Line2(Ap,Bp,Ap+Av.*T,Bp+Bv.*T,0,T);
ezplot (D.absequation,0,5)
grid on

D.TfromD(2)

n1 = [1,1];
n2 = [0,1];
n1 = n1/norm(n1);
e = [1,-1];
e = e/norm(e);
2*(dot(n1,e))*e-n1
2*(dot(n2,e))*e-n2