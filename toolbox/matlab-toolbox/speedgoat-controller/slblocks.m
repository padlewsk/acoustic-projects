function blkStruct = slblocks
    % SLBLOCKS is needed for the slx library to appear in library browser
    Browser.Library = 'SG_library';
    Browser.Name = 'Custom Speedgoat implementations';
    blkStruct.Browser = Browser;
end
