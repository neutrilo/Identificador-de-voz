%fw0207
clear('modo');
md = inputdlg('Opciones validas: 1 y 2','Seleccione modo',1);
md=cell2mat(md);
if md=='1'
  modo=1;
  ch=1;
 uiwait(msgbox('Seleccionaste modo 1'))
elseif md=='2'
  modo=2;
  ch=1;
   uiwait(msgbox('Seleccionaste modo 2'))
else
   uiwait(msgbox('Ah, sos re troll, selecciona una opción válida'))
   return
end


if modo==1
clear; modo=1;
    %-------------------------------------------------------------------------------
    %----ANÁLISIS DE AUDIOS MASCULINOS----------------------------------------------
    %-------------------------------------------------------------------------------
    maudio=4;
    fmed=zeros(1,maudio);
    for i=1:maudio
      amname=strcat('vm',num2str(i),'.wav');
      [sm,fm]=audioread(amname);
      dur=max(size(sm))/fm;
      [med,var,des]=ana02(sm,dur,0);
      fmed(i)=med;
    endfor
    masmed=sum(fmed)/length(fmed);
    masdes=sqrt(sum((fmed-masmed).^2)/length(fmed));
    %-------------------------------------------------------------------------------
    %----ANALISIS DE AUDIOS FEMENINOS ----------------------------------------------
    %-------------------------------------------------------------------------------
    faudio=4;
    fmedf=zeros(1,faudio);
    for i=1:faudio
      amname=strcat('vf',num2str(i),'.wav');
      [sm,fm]=audioread(amname);
      dur=max(size(sm))/fm;
      [med,var,des]=ana02(sm,dur,0);
      fmedf(i)=med;
    endfor
    femmed=sum(fmedf)/length(fmedf);
    femdes=sqrt(sum((fmedf-femmed).^2)/length(fmedf));
    msgbox([['Frecuencia media masculina ',num2str(masmed),'Hz'];
      ['Frecuencia media femenina ', num2str(femmed),'Hz'];
      ['Desviación típica de las frecuencias medias mascullinas ', num2str(masdes),'Hz'];
      ['Desviación típica de las frecuencias medias femeninas ',num2str(femdes),'Hz']],...
      'Valores relevantes')
      
end
%-------------------------------------------------------------------------------
%----IDENTIFICACIÓN DE AUDIOS---------------------------------------------------
%-------------------------------------------------------------------------------
if modo==2
  ch = exist('sm');
  if ch ==1
      testaudioname = inputdlg('Ejemplo: vt1.wav','Indique el nombre del archivo de audio',1);
      testaudioname = cell2mat(testaudioname);
      if !isfile(testaudioname)
        msgbox(['No existe el archivo ','"',testaudioname,'"'], 'No existe al archivo de audio')
        return
      end
      ply = 1;
      [sm,fm] = audioread(testaudioname);
      dur = max(size(sm))/fm;
      [med,var,des]=ana02(sm,dur,0);
      masc = abs(med-masmed)/masdes;
      feme = abs(med-femmed)/femdes;
      if masc<feme
        msgbox('Audio masculino','Resultado');
      else
          msgbox('Audio femenino o infantil','Resultado');
      end
      if ply==1
         player = audioplayer (sm, fm);
         play (player);
      end

    else
      msgbox('Sebe ejecutarse el programa en modo 1 antes de ejecutarse en modo 2',...
      'Error de uso')
    end
end
  