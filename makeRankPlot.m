function makeRankPlot(scores, t, playerNames, nPlayers)
    %makeRankPlot  Make a plot of the changes in ranked positions
    %   makeRankPlot(scores, t, playerNames, nPlayers)
    
    if nargin<4
        nPlayers = size(scores,2);
    end
    
    scores = scores(:,1:nPlayers);
    playerNames = playerNames(1:nPlayers);
    
    % r is the rank matrix
    r = zeros(size(scores));
    for i = 1:length(t)
        [ss,ix] = sort(scores(i,:),'descend');
        rr = (1:nPlayers) - sum(isnan(ss));
        rr(rr<1) = NaN;
        r(i,ix) = rr;
    end
    
    % De-dupe the rows (this causes problems if there are no changes in
    % rank throughout the entire score matrix)
    keep = true(size(r,1),1);
    for i = 2:size(r,1)
        if isequaln(r(i,:),r(i-1,:))
            keep(i) = false;
        end
    end
    if sum(keep) > 1
        r = r(keep,:);
    end
    
    % And plot
    clf
    h = zeros(nPlayers,1);
    for i = nPlayers:-1:1
        x1 = 1:size(r,1);
        rr = r(:,i);
        rr(isnan(r(:,i))) = [];
        x1(isnan(r(:,i))) = [];
        x2 = x1(1):0.01:x1(end);
        hold all
        if length(x2)>1
            r2 = pchip(x1,rr,x2);
            plot(x2,r2,'Color','white','LineWidth',5)
            h(i) = plot(x2,r2,'LineWidth',3);
        else
            h(i) = plot(x1(1),rr(1),'LineWidth',3);    
        end
        plot(x1([1 end]),rr([1 end]),'LineStyle','none', ...
            'Marker','.','MarkerSize',22, ...
            'Color',get(h(i),'Color'))
    end
    hold off
    legend(h,playerNames,"Location","eastoutside")
    set(gca,'YDir','reverse')
    set(gca,'XTick',[])
    set(gca,'XColor','none')
    ylabel('Rank')
    ylim([1 size(r,2)])
    set(gca,'YTick',1:2:size(r,2))
    title('Changes in Position')
    grid on
    
end