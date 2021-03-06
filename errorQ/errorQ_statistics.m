%%
% date: 2018.05.28
% author: huangjiao 
% 功能：统计predict_Q判断的导联的正异常情况与从diag解析的正异常情况 
%       input: 
%       output: 
%%
% function  acc_leads_matrix = errorQ_statistics(leads_vector, pre_leads_vector)
% 
% [h, w] = size(leads_vector);
% [ph, pw] = size(pre_leads_vector);
% if h~=ph || w~=pw
%     disp('there are something wrong , please check!')
% else
%     true_leads_matrix = zeros(1,w);
%     for ii = 1:h
%         for jj=1:w
%             if leads_vector(ii,jj)==pre_leads_vector(ii,jj)
%                 true_leads_matrix(1,jj) = true_leads_matrix(1,jj)+1;
%             end
%         end
%     end
% end
% acc_leads_matrix = (true_leads_matrix/h)*100;  

function  [Acc_matrix, Sen_matrix, Spe_matrix]= errorQ_statistics(leads_vector, pre_leads_vector)
Acc_matrix=[];  Sen_matrix=[];  Spe_matrix=[];
[h, w] = size(leads_vector);
[ph, pw] = size(pre_leads_vector);
if h~=ph || w~=pw
    disp('there are something wrong , please check!')
else
    for ii = 1:w
        truth = leads_vector(:,ii);
        predict = pre_leads_vector(:,ii);
        TP=0; FN=0; FP=0; TN=0;
        for jj = 1:h
            if truth(jj)==1 && predict(jj)==1
                TP = TP+1;
            end
            if truth(jj)==1 && predict(jj)==0
                FN = FN+1;
            end
            if truth(jj)==0 && predict(jj)==1
                FP = FP+1;
            end
            if truth(jj)==0 && predict(jj)==0
                TN = TN+1;
            end
        end
        Acc_matrix(:,ii) = 100*(TP+TN)/(TP+FN+FP+TN);
        Sen_matrix(:,ii) = 100*TP/(TP+FN);
        Spe_matrix(:,ii) = 100*TN/(TN+FP);
    end
end
end
    

