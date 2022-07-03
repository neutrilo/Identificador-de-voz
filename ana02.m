function [med,var,des]=ana02(y,t=1,plt=0)
  if max(size(y))<8000*t
    msgbox ('Frecuencia de sampling muy baja, minimo 8000Hz','Error fatal')
  end
  
  if min(size(y))>1
    if size(y)(1)>size(y)(2)
      y=sum(y,2)/size(y)(2);
    end
    if size(y)(2)>size(y)(1)
      y=sum(y,1)/size(y)(1);
    end
  end

    
  if size(y)(1)>1 %forzamos que el vector sea fila.
    y=y';
  endif
  
  f=abs(fft(y)); 
  n=floor(4000*t);%No tomamos la transformada para todas las 
                      %frecuencias porque sabemos que las voz humana
                      %está restringida a cierto rango.
  f=f(1:n);
  a=(0:n-1)/t;
  med=sum(a.*f)/sum(f);
  v=(a-med).^2;
  var=sum(v.*f)/sum(f);
  des=sqrt(var);
  if plt==1 %ploteo del espectro.
    figure
    plot(a,f)
    xlabel('Frecuencia (Hz)')
    ylabel('Coeficiente de Fourier')
    grid on
  endif
    
endfunction
