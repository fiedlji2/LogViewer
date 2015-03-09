function clearData(filename,splitChar)
% Clears wrong lines from the datafile and saves to file with "_clr" suffix
% call: clearData(filename)  
% e.g.  clearData('let11.txt') produces file let11_clr.txt
% warning: Function assumes that the second line in the data file is valid,
%          if not the clearing will not work correctly!

%author: Vaclav Endrych
%date:   2013-12-06


f_in = fopen(filename);
if(f_in < 0) 
    error(['File "' filename '" not found!']) 
end
filename_out = strrep(filename, '.', '_clr.');
f_out= fopen(filename_out,'w');

fgetl(f_in); % drop first line (head)
tline = fgetl(f_in);

splitOK =   size(strfind(tline,splitChar),2);

l = 0; rm = 1;
while ischar(tline)
    l = l + 1;
    splitN = size(strfind(tline,splitChar),2);
    if isequal(splitN,splitOK)
        fprintf(f_out,'%s\r\n',tline);
    else
        rm = rm + 1;
    end
    tline = fgetl(f_in);
end
fclose(f_in);
fclose(f_out);

percent = (rm/l)*100;
disp(['total lines:   ' num2str(l)])
disp(['removed lines: ' num2str(rm) ' (' num2str(percent,'%3.2f') '%)'])
disp(['saved to file: ' filename_out])
disp('[done]')