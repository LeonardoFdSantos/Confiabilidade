% Incremento de Confiabilidade e Importância Estrutural

% Exemplo de sistemas em ponte

P=[.95;.98;.93;.97;.92];%ones(5,1)*.9;%
Q=1-P;
n=length(P);
h1=zeros(n,1);
h0=h1;
DR=h1;

%% Cortes Mínimos

Rs='(1-Q(1)*Q(3))*(1-Q(2)*Q(4))*(1-Q(1)*Q(4)*Q(5))*(1-Q(2)*Q(3)*Q(5))';
Rs0=eval(Rs);
%% IST
for i=1:n
    Q(i)=0;
    h1(i)=eval(Rs);
    Q(i)=1;
    h0(i)=eval(Rs);
    Q=1-P;
end
ISTs=h1-h0

%% Incremento de Confiabilidade
for i=1:n
    Q(i)=Q(i)^2;
    DR(i)=(eval(Rs)/Rs0-1)*100;
    Q=1-P;
end
DR
    