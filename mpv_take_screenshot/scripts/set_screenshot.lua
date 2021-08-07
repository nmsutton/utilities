local utils = require("mp.utils")
local basedir = mp.get_property("options/screenshot-directory")
mp.register_event("file-loaded", function()
    local filedir = mp.get_property("filename/no-ext")
    local new_name = filedir .. "_%n"
    mp.set_property("options/screenshot-template", new_name)
    
    local file_name = mp.get_property("filename")
    local file_path = mp.get_property("path")
    local file_name_adj = file_name:gsub(("[-_.+=%(%)%*%&%^%$%#%@%!%~%`%[%]%{%}%,%:%;]"), "%%" .. "%1")
    local file_path2 = file_path:gsub(file_name_adj, "")
    mp.set_property("options/screenshot-directory", file_path2)   
end)
