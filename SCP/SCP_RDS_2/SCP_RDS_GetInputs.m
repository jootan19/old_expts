function [QuitSignal,subNo, runNo, practice] =  SCP_RDS_GetInputs(debugmode)
fprintf('%s\n',mfilename())
QuitSignal = 0;
subNo      = 99;
runNo      = 99;
practice   = 1;

if ~exist('debugmode', 'var'),    debugmode = 0;    end
try
    if ~debugmode
        prompt    = {'Subject num', 'Run num', 'Behav. practice? [1=behav, 0=fmri]' };
        outputReq = {'subNo', 'runNo', 'practice'};
        for x = 1 : length(prompt)
            for y = 1:5
                checked = 1;
                tempinput = input([prompt{x} ': ' ]);
                if strcmpi(tempinput , 'q')
                    disp('Giving up now...')
                    QuitSignal = 1; break
                end
                
                if length(tempinput)~=1 || ~isnumeric(tempinput)
                    disp('Incorrect inputs, try again or ''q'' to quit');
                    checked = 0;
                end
                
                if x == 3
                    if ~ismember(tempinput,[1 0])
                        disp('Only 2 options available')
                        checked = 0;
                    end
                end
                
                if checked
                    eval(sprintf('%s = tempinput;', outputReq{x}))
                    break
                end
            end
            
            if QuitSignal==1
                break
            end
        end
        
    end
    
catch err
    sca;
    ShowCursor;
    home;
    error('Error getting inputs')
    rethrow(err)
end

fprintf('%s DONE \n',mfilename())




