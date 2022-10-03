local function rpad(s, l, c)
    return s .. string.rep(c or ' ', l - #s)
end

return {
    rpad = rpad
}
