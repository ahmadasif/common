function startTime = progress(currentItem,currentIndex,finalIndex,beginTime);

if currentIndex == 0   
    fprintf('Beginning Loop...\n')
    startTime = now;
    return;
end


completedPercentage = currentIndex / finalIndex * 100;
elapsedTime = (now - beginTime) * 86400;
elapsedTimeVector = datevec(elapsedTime/86400);
averageTime = elapsedTime / currentIndex;
remainingTime = averageTime * (finalIndex - currentIndex);
completionTime = datevec(now+remainingTime/86400);
currentTime = datevec(now);


formatSpec1 = '%u of %u (%3.1f%%) - ETC %02u:%02u (Avg=%3.2fs) - %s\n';
formatSpec2 = '%u of %u (%3.1f%%) - ETC %02u:%02u (%s %u) (Avg=%3.2fs) - %s\n';
formatSpec3 = 'ETC%02u%02u%s%u~%u-%u-%upct~avg=%ds';
formatSpec4 = 'Completed %u at %02u%02u on %s %u ~ elapsed time - %02u:%02u:%02u ~ avg=%ds';
if currentTime(3) == completionTime(3)
    fprintf(formatSpec1,currentIndex,finalIndex,completedPercentage,completionTime(4),completionTime(5),averageTime,currentItem);
else
    fprintf(formatSpec2,currentIndex,finalIndex,completedPercentage,completionTime(4),completionTime(5),datestr(completionTime,'mmm'),completionTime(3),averageTime,currentItem);
end

    delete(fullfile('/run/shm','ETC*'))
    logFileName = fullfile('/run/shm',sprintf(formatSpec3,completionTime(4),completionTime(5),...
            datestr(completionTime,'mmm'),completionTime(3),currentIndex,finalIndex,completedPercentage,floor(averageTime+0.5)));
    logFileID = fopen(logFileName,'w');
    fclose(logFileID);   



% logFileName = fullfile('/run/shm',sprintf(formatSpec4,currentIndex,finalIndex,completionTime(4),completionTime(5),...
%         datestr(completionTime,'mmm'),completionTime(3),elapsedTimeVector(4),elapsedTimeVector(5),floor(elapsedTimeVector(6)),averageTime))
% 
% logFileID = fopen(fullfile('/run/shm',logFileName,'.q'),'w');
% fclose(logFileID);   
% elapsedTimeVector(5),floor(elapsedTimeVector(6)),averageTime)



% logFileName = fullfile('/run/shm',sprintf(formatSpec3,finalIndex,completionTime(4),completionTime(5),...
%         datestr(completionTime,'mmm'),completionTime(3),elapsedTimeVector(4),elapsedTimeVector(5),floor(elapsedTimeVector(6)),averageTime));
% delete(fullfile('/run/shm','*.q'))
% logFileID = fopen(fullfile('/run/shm',logfileName,'.q'),'w');
% fclose(logFileID);   

if currentIndex == finalIndex
    fprintf('Elapsed time = %02u:%02u:%02u \n',elapsedTimeVector(4),elapsedTimeVector(5),floor(elapsedTimeVector(6)))
    
%     logFileName = fullfile('/run/shm',sprintf(formatSpec3,finalIndex,completionTime(4),completionTime(5),...
%         datestr(completionTime,'mmm'),completionTime(3),elapsedTimeVector(4),elapsedTimeVector(5),floor(elapsedTimeVector(6)),averageTime));
% 
%     logFileID = fopen(fullfile('/run/shm',logFileName,'.q'),'w');
%     fclose(logFileID);   
end
    

end
