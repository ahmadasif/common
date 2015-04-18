function pathout=dropboxPath(varargin)

if nargin>0
    appendpath=strjoin(varargin,filesep);
else
    appendpath='';
end

if isunix
    hostdb=fullfile('~','.dropbox','host.db');
else
    hostdb=fullfile(getenv('APPDATA'),'Dropbox','host.db');
end

assert(logical(exist(hostdb,'file')),'DROPBOXPATH:hostdb:NotFound','The Dropbox host.db file could not be found at %s',hostdb)
    
fid=fopen(hostdb,'r');
fgetl(fid); % skip first line
tline = fgetl(fid); % this line has path, in base64
fclose(fid);

dbpath = char(typecast(org.apache.commons.codec.binary.Base64.decodeBase64(uint8(tline)), 'uint8')');
pathout=fullfile(dbpath,appendpath,filesep);
