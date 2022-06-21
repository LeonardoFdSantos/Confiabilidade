% Prepara casos de contingência para o ANAREDE
cd('C:\dev\Confiabilidade_de_Sistemas_Eletricos_de_Potencia_PPGEE_UFSM\STB32')               %Colocar o diretório onde quer salvar o arquivo

%% Dados de linhas
%  DE PARA na sequência (L1, L2, ..., L10)
%  excluindo as contingência de L4, L10 e L12 que são cortes de 1ª ordem (provocam problemas de tensão e/ou carregamento)
% LT=[ 1     2
%      1     5
%      2     3
%      2     4
%      2     5
%      3     4
%      4     5
%      6    11
%      6    12
%      6    13
%      7     8
%      7     9
%      9    10
%      9    14
%     10    11
%     12    13
%     13    14];
    LT=[839 1047
        839 2458
        856 933
        856 1060
%         896 897
        933 895
        933 955
        933 959
        934 960
        934 1047
        938 946
        938 955
%         938 959
        947 939
        955 946
        955 964
%         955 979
        959 895
        960 1015
%         964 976
        965 1057
        976 979
        955 964
%         995 979
        995 1030
        955 1060
        999 896
        999 933
        999 1060
        1010 947
        1015 939
        1030 955
        1047 1069
        1057 1010
        1060 897
        1069 1041
        1041 963
        963 965];

%% Lista de Contingências
n=length(LT);
LC = nchoosek(1:n,2);    %Combinação dois a dois das linhas que não provocam problemas
m=length(LC);             % Quantidade de combinações para análise 

%% Escreve o PWF
%(Nc) O Pr (       IDENTIFICACAO DA CONTINGENCIA        )
%   1    1                                                          Cont.dupla L1 e L4
%(Tp) (El ) (Pa ) Nc (Ext) (DV1) (DV2) (DV3) (DV4) (DV5) (DV6) (DV7) Gr Und
%CIRD     1     2  1
%CIRD     3     4  1
%FCAS
fileID = fopen('STSB32_Cont_2ordem_Leonardo.pwf','wt');     % Batiza e abre o arquivo para escrita
fprintf(fileID,'DCTG\n');                                       % Comando para listar as contingências
for i=1:m
    fprintf(fileID,'%4u 0  2 Contigencia dupla de L%u e L%u\n',i+200,LC(i,1),LC(i,2));             % Descrição
    fprintf(fileID,'CIRD %4u  %4u   1\n',LT(LC(i,1),1),LT(LC(i,1),2));                                      % Linha A
    fprintf(fileID,'CIRD %4u  %4u   1\n',LT(LC(i,2),1),LT(LC(i,2),2));                                      % Linha B
    fprintf(fileID,'FCAS\n');                                                                                                           % Fim do Caso
end
fprintf(fileID,'99999\n');               % FIM do comando DCTG
fprintf(fileID,'FIM\n');                    % FIM do arquivo PWF
fclose(fileID);                              % Fecha o arquivo