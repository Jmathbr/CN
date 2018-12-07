function z1 = gz1(t,L1,L2)
    z1 = L2
endfunction

function z2 = gz2(t,L1,L2)
    z2 = -10
endfunction 

function [t,y1,y2] = euler(a,b,h,l10,l20)
    t = a:h:b
    n = length(t)
    y1(1) = l10
    y2(1) = l20
    for i = 1:n-1
        k1e = gz1(t(i),y1(i),y2(i))
        k2e = gz2(t(i),y1(i),y2(i))
        y1(i+1) = y1(i)+k1e*h;
        y2(i+1) = y2(i)+k2e*h;
    end
endfunction

function [t,y1,y2] = heun(a,b,h,l10,l20)
    t = a:h:b
    n = length(t)
    y1(1) = l10
    y2(1) = l20
    for i = 1:n-1
        k11h = gz1(t(i),y1(i),y2(i))
        k21h = gz2(t(i),y1(i),y2(i))
        
        k12h = gz1(t(i)+h,y1(i)+h*k11h,y2(i)+h*k21h)
        k22h = gz2(t(i)+h,y1(i)+h*k11h,y2(i)+h*k21h)
        
        k1h = (k11h + k12h)/2
        k2h = (k21h + k22h)/2
        
        y1(i+1) = y1(i)+k1h*h;
        y2(i+1) = y2(i)+k2h*h;
    end
endfunction

function [t,y1,y2] = PontoMedio(a,b,h,l10,l20)
    t = a:h:b
    n = length(t)
    y1(1) = l10
    y2(1) = l20
    
    for i = 1:n-1
        k1s = gz1(t(i),y1(i),y2(i));
        k1v = gz2(t(i),y1(i),y2(i));
        
        k2s = gz1(t(i)+h*0.5,y1(i)+k1s*h*0.5,y2(i)+k1v*h*0.5);
        k2v = gz2(t(i)+h*0.5,y1(i)+k1s*h*0.5,y2(i)+k1v*h*0.5);
        
        y1(i+1) = y1(i)+k2s*h;
        y2(i+1) = y2(i)+k2v*h;
    end
endfunction

function [t,y1,y2] = rk4(a,b,h,l10,l20)
    t = a:h:b
    n = length(t)
    y1(1) = l10
    y2(1) = l20
    
    for i = 1:n-1
        k1s = gz1(t(i),y1(i),y2(i));
        k1v = gz2(t(i),y1(i),y2(i));
        
        k2s = gz1(t(i)+h*0.5,y1(i)+k1s*h*0.5,y2(i)+k1v*h*0.5);
        k2v = gz2(t(i)+h*0.5,y1(i)+k1s*h*0.5,y2(i)+k1v*h*0.5);
        
        k3s = gz1(t(i)+h*0.5,y1(i)+k2s*h*0.5,y2(i)+k2v*h*0.5);
        k3v = gz2(t(i)+h*0.5,y1(i)+k2s*h*0.5,y2(i)+k2v*h*0.5);
        
        k4s = gz1(t(i)+h,y1(i)+k3s*h,y2(i)+k3v*h);
        k4v = gz2(t(i)+h,y1(i)+k3s*h,y2(i)+k3v*h);
        
        ks = (k1s+(2*k2s)+(2*k3s)+k4s)/6
        kv = (k1v+(2*k2v)+(2*k3v)+k4v)/6
        
        y1(i+1) = y1(i)+ks*h;
        y2(i+1) = y2(i)+kv*h;
    end
endfunction
xgrid()

[te,y1e,y2e]= euler(0,2,0.2,1.8,12)
plot(te',y1e,"o")
plot(te',y2e,"o")

[th,y1h,y2h]= heun(0,2,0.2,1.8,12)
plot(th',y1h,"^")
plot(th',y2h,"^")

[tp,y1p,y2p]= PontoMedio(0,2,0.2,1.8,12)
plot(tp',y1p,"O")
plot(tp',y2p,"+")

[tr,y1r,y2r]= rk4(0,2,0.2,1.8,12)
plot(tr',y1r,"-")
plot(tr',y2r,"-")
