% Algorithm of evaluation and subdivision presented in Section 4 of
 %E. Mainar, J.M. Pe\~na, B. Rubio, Evaluation and subdivision algorithms for general 
%classes of totally positive rational bases, Computer Aided Geometric Design, 
%Volume 81, 2020, 101900, ISNN 0167-8396.



function casteljau_type_weighted(f, g, P, a, b, t_0, t_range)

    styles;
    
    n=size(P,1);
    
    hold on;
    set(gca, 'XColor', 'none', 'YColor', 'none')
    style = plot(P(:,1),P(:,2));
    set(style, linea2.name, linea2.value);


    %Control Polyngon and Curve
    %---------------------------
    j=1;

    for t=t_range
        Q=P;
        for i=1:n-1
            Q = (a(i).*g(t))/(a(i).*g(t)+b(i).*f(t))*Q(1:n-i,:)+b(i).*f(t)/(a(i).*g(t)+b(i).*f(t))*Q(2:n-i+1,:);
        end
        x(j) = Q(1,1); y(j) = Q(1,2);
        j=j+1;
    end

    style = plot(x, y);
    set(style, linea2.name, linea2.value);

    % Corner Cutting algorithm
    % ------------------------
   Q=P;
     resultado = []; 
     for i=1:n-1
         Q = (a(i).*g(t_0))/(a(i).*(1-t_0)+b(i).*t_0)*Q(1:n-i,:)+b(i).*f(t_0)/(a(i).*(1-t_0)+b(i).*t_0)*Q(2:n-i+1,:);
         resultado = cat(1, resultado, Q);
         style = plot(Q(:,1),Q(:,2));
         set(style, linea2.name, linea2.value);
     end
 
     style = plot(P(:,1), P(:,2));
     set(style, punto_grande.name, punto_grande.value);
     style = plot(resultado(1:end-1,1),resultado(1:end-1,2));
     set(style, punto_chico.name, punto_chico.value);
     style = plot(resultado(end,1),resultado(end,2));
     set(style, punto_grande_gris.name, punto_grande_gris.value);
