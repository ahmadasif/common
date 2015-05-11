function startTime = progress(currentItem,currentIndex,finalIndex,beginTime);

logFileDir = '~';
logFile2Name = fullfile(logFileDir,'logfile.txt');

if currentIndex == 0
    delete(fullfile(logFileDir,'ETC*'))
    fprintf('Beginning Loop...\n\n')
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
formatSpec3 = 'ETC%02u%02u%s%u~%u-%u-%upct~avg=%3.2fs';
formatSpec4 = '%u/%u~%3.1f%%~Avg %3.2fs~ETC %02u:%02u(%s %u)';
formatSpec5 = ...
    '\nCompleted %u at %02u:%02u on %s %u ~ elapsed time - %02u:%02u:%02u ~ avg=%3.1fs';
formatSpec6 = 'Completed %u ~ Avg %3.2fs ~ at %02u:%02u(%s %u)';
formatSpec7 = 'ETCompleted%u~Avg=%3.2fs~%02u%02u(%s%u)';
if currentTime(3) == completionTime(3)
    fprintf(formatSpec1,currentIndex,finalIndex,completedPercentage...
        ,completionTime(4),completionTime(5),averageTime,currentItem);
else
    fprintf(formatSpec2,currentIndex,finalIndex,completedPercentage...
        ,completionTime(4),completionTime(5),datestr(completionTime,'mmm')...
        ,completionTime(3),averageTime,currentItem);
end

    

previousCompletedPercentage = (currentIndex - 1) / finalIndex * 100;
if floor(completedPercentage) > floor(previousCompletedPercentage)
    delete(fullfile(logFileDir,'ETC*'));
    logFile1Name = fullfile(logFileDir,sprintf(formatSpec3,completionTime(4)...
        ,completionTime(5),datestr(completionTime,'mmm'),completionTime(3)...
        ,currentIndex,finalIndex,floor(completedPercentage+0.5),averageTime));
    logFile1ID = fopen(logFile1Name,'w');
    fclose(logFile1ID);
    logFile2ID = fopen(logFile2Name,'w');
    fprintf(logFile2ID,formatSpec4,currentIndex,finalIndex,completedPercentage...
        ,averageTime,completionTime(4),completionTime(5)...
        ,datestr(completionTime,'mmm'),completionTime(3));
    fclose(logFile2ID);
end
    
    

if currentIndex == finalIndex
    fprintf(formatSpec5,finalIndex,completionTime(4),completionTime(5)...
        ,datestr(completionTime,'mmm'),completionTime(3),elapsedTimeVector(4)...
        ,elapsedTimeVector(5),floor(elapsedTimeVector(6)),averageTime);
    logFile2ID = fopen(logFile2Name,'w');
    fprintf(logFile2ID,formatSpec6,finalIndex...
        ,averageTime,completionTime(4),completionTime(5)...
        ,datestr(completionTime,'mmm'),completionTime(3));
    fclose(logFile2ID);
    delete(fullfile(logFileDir,'ETC*'));
    logFile1Name = fullfile(logFileDir,sprintf(formatSpec7,finalIndex...
        ,averageTime,completionTime(4),completionTime(5)...
        ,datestr(completionTime,'mmm'),completionTime(3)));
    logFile1ID = fopen(logFile1Name,'w');
    fclose(logFile1ID);
end
    

end
