function updatePercentage = updatePercentage(value)
    value = int16(value);
    if value<11
        fprintf('\b\b\b  %d',value);
    elseif value<101
        fprintf('\b\b\b %d',value);
    else
        fprintf('\b\b\b%d',value);
    end
end
