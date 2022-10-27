local function rpad(s, l, c)
    return s .. string.rep(c or ' ', l - #s)
end

local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

return {
    rpad = rpad,
    file_exists = file_exists,
    lines_from = lines_from,
}
