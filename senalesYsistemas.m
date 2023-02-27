function varargout = senalesYsistemas(varargin)
% SENALESYSISTEMAS MATLAB code for senalesYsistemas.fig
%      SENALESYSISTEMAS, by itself, creates a new SENALESYSISTEMAS or raises the existing
%      singleton*.
%
%      H = SENALESYSISTEMAS returns the handle to a new SENALESYSISTEMAS or the handle to
%      the existing singleton*.
%
%      SENALESYSISTEMAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SENALESYSISTEMAS.M with the given input arguments.
%
%      SENALESYSISTEMAS('Property','Value',...) creates a new SENALESYSISTEMAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before senalesYsistemas_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to senalesYsistemas_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help senalesYsistemas

% Last Modified by GUIDE v2.5 26-Feb-2023 11:07:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @senalesYsistemas_OpeningFcn, ...
                   'gui_OutputFcn',  @senalesYsistemas_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before senalesYsistemas is made visible.
function senalesYsistemas_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to senalesYsistemas (see VARARGIN)

% Choose default command line output for senalesYsistemas
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes senalesYsistemas wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = senalesYsistemas_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%https://www.youtube.com/watch?v=xzQlTnL-0sQ&ab_channel=MundoTecnol%C3%B3gico
%https://www.youtube.com/watch?v=5uuEgTmu7hg&ab_channel=OLVERAONLINE
%https://www.youtube.com/watch?v=Ta1uhGEJFBE&ab_channel=MATLAB

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
%A=str2double(get(hObject,'String'));
%A=handles.Amp1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%parámetros que se pueden modificar en las 5 funciones iniciales
    
ET=str2double(get(handles.et,'String'))
    if isnan(ET)
        errordlg('El valor de Escalamiento en el tiempo debe ser numérico','ERROR')
        ET=1;
    end
EA=str2double(get(handles.ea,'String'))
    if isnan(EA)
        errordlg('El valor de Escalamiento en amplitud debe ser numérico','ERROR')
        EA=1;
    end
 DT=str2double(get(handles.dt,'String'))
    if isnan(DT)
        errordlg('El valor de Desplazamiento en el tiempo debe ser numérico','ERROR')
        DT=1;
    end   
  DV=str2double(get(handles.dv,'String'))
    if isnan(DV)
        errordlg('El valor de Desplazamiento vertical debe ser numérico','ERROR')
        DV=1;
    end      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%parámetros que se pueden modificar en las dos funciones finales
A=str2double(get(handles.Amp1,'String'))
    if isnan(A)
        errordlg('El valor de Amplitud  debe ser numerico','ERROR')
        A=1;
    end

F=str2double(get(handles.frec1,'String'))
    if isnan(F)
        errordlg('El valor de Frecuencia debe ser numérico','ERROR')
        F=1;
    end



%inf=get(hObject,'Value');
inf=get(handles.listbox1,'Value');

syms t positive
tn = 0:0.001:10;

switch inf
    % escalon unitario
    % https://la.mathworks.com/help/signal/gs/impulse-step-and-ramp-functions.html
    %http://blog.espol.edu.ec/telg1001/senales-operaciones-en-tiempo/#:~:text=La%20compresi%C3%B3n%20o%20expansi%C3%B3n%20de,por%20un%20factor%20de%202.
    case 1       

    tn = -1-ET:0.001:1+ET;
    yn=EA.*heaviside(tn+DT)+DV;
  
    y = (EA+ET).*(t/t+DT)+DV; 
    Fl=laplace(y);
    Fls=string(Fl);
    set(handles.transf1,'String',Fls);
    
    
    % signo    
    % https://la.mathworks.com/help/matlab/ref/sign.html
    case 2
    tn = [-1*(1+ET)+DT -eps(1) 0 eps(1) 1*(1+ET)+DT];    
    yn = EA.*sign(tn)+DV; 
    y= EA.*sign(t)+DV;
    Fl=laplace(y);
    Fls=string(Fl);
    set(handles.transf1,'String',Fls);
    
    % Rampa Unitaria 
    case 3
    tn = (0-DT:0.01:1-DT)';
   
    yn=(EA+ET).*(tn+DT)+DV;
    
    y= (EA+ET).*(t+DT)+DV;
    Fl=laplace(y);
    Fls=string(Fl);
    set(handles.transf1,'String',Fls);
        
    % Pulso Rectangular   
    %https://la.mathworks.com/help/signal/ref/rectpuls.html
    case 4
    fs = 10e3;
    tn = -0.1:1/fs:0.1;
    w = 20e-3;
    
    yn = EA.*rectpuls(tn+DT,w+ET)+DV;
    Fl=laplace(EA.*heaviside(t+0.1+DT+ET)-EA.*heaviside(t-0.1+DT+ET)+DV)
    Fls=string(Fl)
    set(handles.transf1,'String',Fls);


        
    % Pulso Triangular   
    %https://la.mathworks.com/help/signal/ref/tripuls.html
    case 5
    fs = 10e3;
    tn = -0.1:1/fs:0.1;
    w = 40e-3;
    yn = EA.*tripuls(tn+DT,w+ET)+DV;
    
    Fl=laplace(t*EA.*heaviside(t+0.1+DT+ET)-t*EA.*heaviside(t-0.1+DT+ET)+DV)
    Fls=string(Fl)
    set(handles.transf1,'String',Fls);

    
    % Seno   
    case 6  
    yn = A*sin(2*pi*tn*F);
    y = A*sin(2*pi*t*F); 

    Fl=laplace(y);
    Fls=string(Fl);
    set(handles.transf1,'String',Fls);
    
    
    % Coseno
    case 7
    yn =  A*cos(2*pi*tn*F);
     y = A*cos(2*pi*t*F);

    Fl=laplace(y);
    Fls=string(Fl)
    set(handles.transf1,'String',Fls);
     
end    

axes(handles.axes1)
plot (tn,yn,'r','LineWidth',1); grid on

        
        
       


% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-----------------------------------------------------------------------------------








% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)

inf=get(hObject,'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%parámetros que se pueden modificar en las 5 funciones iniciales
    
ET=str2double(get(handles.et,'String'))
    if isnan(ET)
        errordlg('El valor de Escalamiento en el tiempo debe ser numérico','ERROR')
        ET=1;
    end
EA=str2double(get(handles.ea,'String'))
    if isnan(EA)
        errordlg('El valor de Escalamiento en amplitud debe ser numérico','ERROR')
        EA=1;
    end
 DT=str2double(get(handles.dt,'String'))
    if isnan(DT)
        errordlg('El valor de Desplazamiento en el tiempo debe ser numérico','ERROR')
        DT=1;
    end   
  DV=str2double(get(handles.dv,'String'))
    if isnan(DV)
        errordlg('El valor de Desplazamiento vertical debe ser numérico','ERROR')
        DV=1;
    end  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%parámetros que se pueden modificar en las dos funciones finales
A=str2double(get(handles.Amp1,'String'))
    if isnan(A)
        errordlg('El valor de Amplitud  debe ser numerico','ERROR')
        A=1;
    end

F=str2double(get(handles.frec1,'String'))
    if isnan(F)
        errordlg('El valor de Frecuencia debe ser numérico','ERROR')
        F=1;
    end

tn = 0:0.001:10;
syms t positive
switch inf
    % escalon unitario
    % https://la.mathworks.com/help/signal/gs/impulse-step-and-ramp-functions.html
    %http://blog.espol.edu.ec/telg1001/senales-operaciones-en-tiempo/#:~:text=La%20compresi%C3%B3n%20o%20expansi%C3%B3n%20de,por%20un%20factor%20de%202.
    case 1       

        
    tn = -1-ET:0.001:1+ET;
    yn=EA.*heaviside(tn+DT)+DV;
    y = (EA+ET).*(t/t+DT)+DV; 
    Fl=laplace(y);
    Fls=string(Fl);
    
    
  
    % signo    
    % https://la.mathworks.com/help/matlab/ref/sign.html
    case 2

    tn = [-1*(1+ET)+DT -eps(1) 0 eps(1) 1*(1+ET)+DT];    
    yn = EA.*sign(tn)+DV; 
    y= EA.*sign(t)+DV;
    Fl=laplace(y);
    Fls=string(Fl);
   
    
    % Rampa Unitaria 
    case 3
    tn = (0-DT:0.01:1-DT)';  
    yn=(EA+ET).*(tn+DT)+DV;
    y= (EA+ET).*(t+DT)+DV;
    Fl=laplace(y);
    Fls=string(Fl);
    
    
    % Pulso Rectangular   
    %https://la.mathworks.com/help/signal/ref/rectpuls.html
    case 4
    fs = 10e3;
    tn = -0.1:1/fs:0.1;
    w = 20e-3;
    
    yn = EA.*rectpuls(tn+DT,w+ET)+DV;
    Fl=laplace(EA.*heaviside(t+0.1+DT+ET)-EA.*heaviside(t-0.1+DT+ET)+DV)
    Fls=string(Fl)

    
        % Pulso Triangular   
    %https://la.mathworks.com/help/signal/ref/tripuls.html
    case 5
    fs = 10e3;
    tn = -0.1:1/fs:0.1;
    w = 40e-3;
    yn = EA.*tripuls(tn+DT,w+ET)+DV;
    
    Fl=laplace(t*EA.*heaviside(t+0.1+DT+ET)-t*EA.*heaviside(t-0.1+DT+ET)+DV)
    Fls=string(Fl)
    
    
 
    % Seno   
    case 6  
    yn = A*sin(2*pi*tn*F);
    y = A*sin(2*pi*t*F); 
    Fl=laplace(y);
    Fls=string(Fl);
    % Coseno
    case 7
    yn =  A*cos(2*pi*tn*F);
    y = A*cos(2*pi*t*F); 
    Fl=laplace(y);
    Fls=string(Fl);
end    
 set(handles.transf2,'String',Fls);
axes(handles.axes2)
plot (tn,yn,'g','LineWidth',2); grid on
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1



function Amp2_Callback(hObject, eventdata, handles)
% hObject    handle to Amp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Amp2 as text
%        str2double(get(hObject,'String')) returns contents of Amp2 as a double


% --- Executes during object creation, after setting all properties.
function Amp2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Amp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Frec2_Callback(hObject, eventdata, handles)
% hObject    handle to Frec2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Frec2 as text
%        str2double(get(hObject,'String')) returns contents of Frec2 as a double


% --- Executes during object creation, after setting all properties.
function Frec2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Frec2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Amp1_Callback(hObject, eventdata, handles)
% hObject    handle to Amp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Amp1 as text
%        str2double(get(hObject,'String')) returns contents of Amp1 as a double


% --- Executes during object creation, after setting all properties.
function Amp1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Amp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frec1_Callback(hObject, eventdata, handles)
% hObject    handle to frec1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frec1 as text
%        str2double(get(hObject,'String')) returns contents of frec1 as a double


% --- Executes during object creation, after setting all properties.
function frec1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frec1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in calcular.
function calcular_Callback(hObject, eventdata, handles)

 
A=str2double(get(handles.Amp1,'String'))
    if isnan(A)
        errordlg('El valor de Amplitud  debe ser numerico','ERROR')
        A=1;
    end

F=str2double(get(handles.frec1,'String'))
    if isnan(F)
        errordlg('El valor de Frecuencia debe ser numérico','ERROR')
        F=1;
    end

    
inf1=get(handles.listbox1,'Value');
inf2=get(handles.listbox2,'Value');
tn = 0:0.001:10;  

switch inf1
    % escalon unitario
    case 1
              
        yn1 = tn/tn; 
    case 2
        
      
        yn1= sign(tn);
    case 3
         yn1= tn;    
    case 4
    fs = 10e3;
    tn = 0:1/fs:1;
    w = 20e-3;
    
    yn1 = rectpuls(tn,w);
    
    
    case 5
        
    fs = 10e3;
    tn = 0:1/fs:1;
    w = 40e-3;
    yn1 = tripuls(tn,w);
    
        
    case 6
         
         yn1 = A*sin(2*pi*tn*F)
    case 7
         
         yn1 = A*cos(2*pi*tn*F);
end    

switch inf2
    % escalon unitario
    case 1
            
        yn2 = tn/tn; 
    case 2
       
        yn2= sign(tn);
         
    case 3
        yn2= tn;
    case 4
        fs = 10e3;
        tn = 0:1/fs:1;
        w = 20e-3;
        yn2 = rectpuls(tn,w);
    case 5
        fs = 10e3;
        tn = 0:1/fs:1;
        w = 40e-3;
        yn2 = tripuls(tn,w);
    case 6
        
         yn2 = A*sin(2*pi*tn*F);
    case 7
        
         yn2 = A*cos(2*pi*tn*F);
end 


    
sum1=yn1+yn2;
res1=yn1-yn2;
mul1=yn1.*yn2;


    
%set(handles.text3,'String',sum1);

axes(handles.sum)
plot (tn,sum1,'r','LineWidth',2); grid on

axes(handles.res)
plot (tn,res1,'r','LineWidth',2); grid on

axes(handles.mul)
plot (tn,mul1,'r','LineWidth',2); grid on

% syms t positive
% tn = 1:0.001:100;
% tn1 = [-5 -eps(1) 0 eps(1) 5];    
% a = sign(tn1);
%  
% 
%     
% b = cos(pi*tn1);
%  yn=a-b;
%   %  f=4*cos(2*t);



% hObject    handle to calcular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function et_Callback(hObject, eventdata, handles)
% hObject    handle to et (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et as text
%        str2double(get(hObject,'String')) returns contents of et as a double


% --- Executes during object creation, after setting all properties.
function et_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ea_Callback(hObject, eventdata, handles)
% hObject    handle to ea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ea as text
%        str2double(get(hObject,'String')) returns contents of ea as a double


% --- Executes during object creation, after setting all properties.
function ea_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dt_Callback(hObject, eventdata, handles)
% hObject    handle to dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dt as text
%        str2double(get(hObject,'String')) returns contents of dt as a double


% --- Executes during object creation, after setting all properties.
function dt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dv_Callback(hObject, eventdata, handles)
% hObject    handle to dv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dv as text
%        str2double(get(hObject,'String')) returns contents of dv as a double


% --- Executes during object creation, after setting all properties.
function dv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
