function [K, Te, Tb] = paramCalc(SYS)

    [Y,time] = step(SYS);
    
    %Max amplitude
    K = Y(end);

    %find inflection point using 2nd derivative => '0'
    D = diff(Y)./diff(time);
    inflex = find(diff(D)./diff(time(1:end-1))<0,1);
    A = D(inflex)*time(inflex)-Y(inflex);
    
    %plots
    tangent = D(inflex)*time - A;
    step(SYS)
    hold on
    plot(time,tangent,'r')

    %find intersection points with y=0 and y=1
    index_0 =  find(tangent>=0, 1);
    index_1 =  find(tangent>=1, 1);
    Te = time(index_0);
    Tb = time(index_1) - Te;
    fprintf('K: %.3f \nTu: %.3f s \nTg: %.3f s\n', K, Te, Tb);
end