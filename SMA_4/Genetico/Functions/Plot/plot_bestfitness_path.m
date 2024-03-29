%*********************************************************************************************
%                                   File: plot_bestfitness_path.m                                   
%
% FUNCTION FILE: Plot - população atual
%*********************************************************************************************

function [fig] = plot_bestfitness_path(X_pop,X_pop_old,pop_final)

if pop_final == 0
    plot([X_pop_old(1,1),X_pop(1,1)],[X_pop_old(1,2),X_pop(1,2)],'o-r');
    
else % última geração
    plot(X_pop(1,1),X_pop(1,2),'o-k',MarkerFaceColor='k');
end

drawnow