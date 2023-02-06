local function rpad(s, l, c) return s .. string.rep(c or ' ', l - #s) end

local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do lines[#lines + 1] = line end
  return lines
end

local function find_dotfiles()
  local dotbare = io.popen("hash dotbare 2>&1 || echo ::ERROR::", "r")
  local dotfiles = {}
  if dotbare and not dotbare:read('*a'):find('::ERROR::') then
    local dotbarefiles = io.popen('dotbare ls-tree -r main --name-only')
    if dotbarefiles ~= nil then
      for s in dotbarefiles:read('*a'):gmatch("[^\r\n]+") do
        table.insert(dotfiles, s)
      end
    end
  else
    table.insert(dotfiles, '~')
  end
  require('telescope.builtin').find_files({ hidden=true, search_dirs=dotfiles })
end

return {
  rpad = rpad,
  file_exists = file_exists,
  lines_from = lines_from,
  find_dotfiles = find_dotfiles
}
