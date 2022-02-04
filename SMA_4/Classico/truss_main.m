%*********************************************************************************************
%                                     File: truss_main.m
%
% Main script file
% CALLS: truss_data, truss_plot, truss_plotpath, truss_plot_struct, truss_plot_struct_current,
% auglag, auglag_min, truss_KKT_function, truss_limits_met3
%*********************************************************************************************
addpath([pwd,'\Functions';],[pwd,'\Functions\SDM'],[pwd,'\Functions\Plot']);
clear
clc
close all
tic 

f = 2; % Selecionar a função objetivo: 1(f1), 2(f2), 3(f3)
method = 3; % Selecionar método de verificação das restrições geométricas: 1("armijo"), 2("restrições extra") or 3("impor valor das variáveis")
searchd = 1; % Selecionar método da direção de pesquisa: 1("Gradiente"), 2("Gradiente Conjugado"), 3("Quasi-Newton") or 4("Newton")

% Inicializar dados
truss_data

% Plot - função objetivo
truss_plot(f,f1_x1x2);

% Plot - estrutura
last=0;
xCenter = truss_plot_struct(X);

% Ciclo de pesquisa
lambda=zeros(n,1);
epsilon = 2;
xx = zeros(kmax,2); % vetor de armazenamento da sequência de pontos

while k<kmax && k3<2
    
    k = k + 1;

    % Guardar ponto
    xx(k,:)=X;
    fobj=f1_x1x2(X(1),X(2));

    % Guardar contadores do nº de iterações na minimizçaõ da função lagrangeana
    if searchd == 2 % método da direção de pesquisa
        counters(k,:)=[countert,counterg];
    elseif searchd == 4 % método da direção de pesquisa
        counters(k,:)=[countert,counterg];
    else
        counters(k)=countert;
    end
    
    % Definição da função Lagrangiana
    [La, grad_La, hessian_La] = auglag(f1,c,Max,lambda,epsilon,searchd);

    % Minimização da função Lagrangiana
    [X,countert,counterg] = auglag_min(X,xx(k,:)',H,La,grad_La,hessian_La,method,searchd,lb,ub,kmax,k3max);
    
    % Restrições geométricas - métodos 1
    if method == 3
        truss_limits_met3
    end
    
    % Condições Karush-Kuhn-Tucker
    [KKT, KKT_norm,flag]=KKT_fun(X,lambda,difx1_f1,difx2_f1,difx1_c,difx2_c,c_x1x2);
    
    if flag
        break
    end

    if xx(k,:)' == X
        k3=k3+1;
    end
    
    % Atualizar mutiplicadores
    lambda = max(0, lambda + 2/epsilon*c_x1x2(X(1),X(2)));
    epsilon = epsilon*0.9;
    
    % Plot - direção de pesquisa atual
    truss_plotpath(X,xx(k,:)',f1_x1x2);

    % Plot - estrutura atual
    truss_plot_struct_current(X,xCenter,last);

end

% Plot - estrutura final 
last=1;
truss_plot_struct_current(X,xCenter,last);

% Tabela de Iterações
xx(1+k,:)=X;
if searchd == 4 || searchd == 2 % método da direção de pesquisa
    counters(1+k,:)=[countert,counterg];
else
    counters(1+k,:)=countert;
end

xx=xx(1:k+1,:);
counters=counters(1:k+1,:);
Iterations = 0:k;

if searchd == 2 % método da direção de pesquisa
    T = table(Iterations.',xx(:,1),xx(:,2),counters(:,1),counters(:,2));
    T.Properties.VariableNames={'Iterações','x1','x2','Iterações Total','Reset Direções'};
elseif searchd == 4 % método da direção de pesquisa
    T = table(Iterations.',xx(:,1),xx(:,2),counters(:,1),counters(:,2));
    T.Properties.VariableNames={'Iterações','x1','x2','Iterações Total','Iterações Gradiente'};
else
    T = table(Iterations.',xx(:,1),xx(:,2),counters(:));
    T.Properties.VariableNames={'Iterações','x1','x2','Iterações Total'};
end
disp(T)
writetable(T,'results.xlsx');

% Resultados
if k==kmax
    message5 = ['número máximo de iterações foi alcançado'];
elseif flag
    message5 = ['as condições de KKT foram verificadas'];
else
    message5 = ['a convergência estagnou'];
end

if f==1
fprintf([ ...
         'Número de iterações: %d\n\n', ...
         'Ponto Mínimo: [%.5f , %.5f]\n\n', ...
         'Valor da função objetivo após otimização: %.4f kg \n\n', ...
         'Critério de paragem: %s. \n \n'], ...
         k,X(1),X(2),fobj,message5)

elseif f==2
    fprintf([ ...
         'Número de iterações: %d\n\n', ...
         'Ponto Mínimo: [%.5f , %.5f]\n\n', ...
         'Valor da função objetivo após otimização: %.4fE-4 m \n\n', ...
         'Critério de paragem: %s. \n \n'], ...
         k,X(1),X(2),fobj*10,message5)
else
fprintf([ ...
         'Número de iterações: %d\n\n', ...
         'Ponto Mínimo: [%.5f , %.5f]\n\n', ...
         'Valor da função objetivo 1 após otimização: %.4f kg \n\n', ...
         'Valor da função objetivo 2 após otimização: %.4fE-4 m \n\n', ...
         'Critério de paragem: %s. \n \n'], ...
         k,X(1),X(2),double(f11(X(1),X(2))),double(f22(X(1),X(2)))*10^4,message5)
end

toc
