%%      R2 calculates the correlation coefficient between two vector data sets, e.g., observed values ~ modeled values through regression
% y is the observed value and f is the model value
%%
function VALUE=R2(y,f)
    if (length(y)~=length(f))
        display('length of data is not equal')
        Stop();
    end
    
    MEAN_Y=mean(y);
    SS_TOTAL=0;
    SS_ERROR=0;
    for i=1:length(y);
        SS_TOTAL=SS_TOTAL+(y(i)-MEAN_Y)^2;
        SS_ERROR=SS_ERROR+(y(i)-f(i))^2;
    end
    
    VALUE=1-SS_ERROR/SS_TOTAL;    
end