function y = f(x)
    y = (70/9)*exp(-0.3*x) - (43/9)*exp(-1.2*x)
endfunction

function z = g(x,y)
    z = -1.2*y + 7*exp(-0.3*x);
endfunction

function [x,y] = eulerIteracao(x,y,h,n)
    for i = 1:n
        y = y + h*g(x,y);
        x = x + h
    end
endfunction

function [h] = eulerPasso(x,y,h,E)
    [x,yAtual] = eulerIteracao(x,y,h,1)
    [x,yNovo] = eulerIteracao(x,y,h/2,2)
    Erro = abs(yNovo - yAtual)
    if (Erro >=  E) then
        // diminue o passo
        h = h*(E/Erro)^0.25
    else
        // aumenta o passo
         h = h*(E/Erro)^0.2
    end
endfunction

function [x,y] = eulerAdaptativo(a,b,h,y0,E)
    x(1) = a
    y(1) = y0
    i = 1;
    while (%T)
        h = eulerPasso(x(i),y(i),h,E)    
        [x(i+1),y(i+1)] = eulerIteracao(x(i),y(i),h,1)
        if (x(i+1) > b)
            break;
        end
        i = i+1
    end

endfunction


// Resolução por Euler Adaptativo (azul)
[xEa,yEa] = eulerAdaptativo(0,3,1,3,10^(-3));
plot(xEa,yEa, 'b')

// Gráfico da solução Exata
a = 0:.01:3;
b = f(a);
plot(a,b,'r')

