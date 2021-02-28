% Algorithm of evaluation and subdivision presented in Section 4 of
 %E. Mainar, J.M. Pe\~na, B. Rubio, Evaluation and subdivision algorithms for general 
%classes of totally positive rational bases, Computer Aided Geometric Design, 
%Volume 81, 2020, 101900, ISNN 0167-8396.



function B_algoritmo_weighted(f, g, P, w, t_0, t_range)

styles;

m=length(P);
w1=w; 

%Inicializamos

d=w1;
Q=P;
Qizquierda=zeros(m-1,2);
id = m+1; 

hold on;
%axis equal;
set(gca, 'XColor', 'none', 'YColor', 'none') 

%Hallamos los puntos de control y el poligono de control

for i=1:m-1
    for j=1:m-i
        d(i+1,j)=g(t_0)*d(i,j)+f(t_0)*d(i,j+1);
        resp = id-(m+1-i);
        Q(id,1:2)=(g(t_0)*d(i,j)/d(i+1,j))*Q(resp,1:2)+(f(t_0)*d(i,j+1)/d(i+1,j))*Q(resp+1,1:2);
        id = id+1;
    end
    Qizquierda(i,1:2)=Q(resp-j+1,1:2);
end

prev = 1;
for i=m:-1:1
    id = prev-1+i;
    style = plot(Q(prev:id,1), Q(prev:id,2));
    set(style, linea2.name, linea2.value);
    prev = id+1;
end

puntos_Q = Q; 
Q=P;
curva=zeros(size(t_range, 2), 2);
s=1; 

%Hallamos la curva
for t = t_range  
    id = m+1;
    for i=1:m-1
        for j=1:m-i
            d(i+1,j)=g(t)*d(i,j)+f(t)*d(i,j+1);
            resp = id-(m+1-i);
            Q(id,1:2)=(g(t)*d(i,j)/d(i+1,j))*Q(resp,1:2)+(f(t)*d(i,j+1)/d(i+1,j))*Q(resp+1,1:2);
            id = id+1;
        end
    end
    curva(s,1) = Q(id-1, 1);
    curva(s,2) = Q(id-1, 2);
    s=s+1;
end

z=ones(1,size(curva,1))*-1;
z2=ones(1,m)*1;
z3=ones(1,size(puntos_Q,1)-m-1)*1;
style = plot3(curva(:,1), curva(:,2),z);
set(style, linea4.name, linea4.value);
style = plot3(puntos_Q(1:m,1), puntos_Q(1:m,2),z2);
set(style, punto_grande.name, punto_grande.value);
style = plot3(puntos_Q(m+1:end-1,1), puntos_Q(m+1:end-1,2),z3);
set(style, punto_chico.name, punto_chico.value);
style = plot3(puntos_Q(end,1), puntos_Q(end,2),1);
set(style, punto_grande_gris.name, punto_grande_gris.value);