local gl = require('galaxyline')
local fileinfo = require('galaxyline.provider_fileinfo')

local downcase = function(fn)
    return function()
        return string.lower(fn())
    end
end

local colors = {
    bg = '#3E4452',
    yellow = '#DCDCAA',
    dark_yellow = '#E5C07B',
    cyan = '#4EC9B0',
    green = '#98C379',
    light_green = '#B5CEA8',
    string_orange = '#CE9178',
    orange = '#FF8800',
    purple = '#C678DD',
    magenta = '#D16D9E',
    grey = '#ABB2BF',
    blue = '#61AFEF',
    vivid_blue = '#4FC1FF',
    light_blue = '#9CDCFE',
    red = '#E06C75',
    error_red = '#F44747',
    info_yellow = '#FFCC66'
}

local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer'}

table.insert(gls.left, {
    ViMode = {
        provider = function()
            -- auto change color according the vim mode
            local mode_color = {
                n = colors.blue,
                i = colors.green,
                v = colors.purple,
                [''] = colors.purple,
                V = colors.purple,
                c = colors.magenta,
                no = colors.blue,
                s = colors.orange,
                S = colors.orange,
                [''] = colors.orange,
                ic = colors.yellow,
                R = colors.red,
                Rv = colors.red,
                cv = colors.blue,
                ce = colors.blue,
                r = colors.cyan,
                rm = colors.cyan,
                ['r?'] = colors.cyan,
                ['!'] = colors.blue,
                t = colors.blue
            }
            vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()])
            return '▊ '
        end,
        highlight = {colors.red, colors.bg}
    }
})
print(vim.fn.getbufvar(0, 'ts'))
vim.fn.getbufvar(0, 'ts')

table.insert(gls.left, {
    FileIcon = {
        provider = 'FileIcon',
        condition = buffer_not_empty,
        highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg},
    }
})

table.insert(gls.left, {
    FileName = {
        provider = {'FileName'},
        condition = buffer_not_empty,
        separator = ' ',
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.grey, colors.bg}
    }
})

table.insert(gls.left, {
    GitIcon = {
        provider = function()
            return '  '
        end,
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.orange, colors.bg}
    }
})

table.insert(gls.left, {
    GitBranch = {
        provider = 'GitBranch',
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.grey, colors.bg}
    }
})

table.insert(gls.left, {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.green, colors.bg}
    }
})

table.insert(gls.left, {
    DiffModified = {
        provider = 'DiffModified',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.blue, colors.bg}
    }
})

table.insert(gls.left, {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.red, colors.bg}
    }
})


table.insert(gls.right, {
    DiagnosticError = {provider = 'DiagnosticError', icon = '  ', highlight = {colors.error_red, colors.bg}}
})
table.insert(gls.right, {DiagnosticWarn = {provider = 'DiagnosticWarn', icon = '  ', highlight = {colors.orange, colors.bg}}})

table.insert(gls.right, {
    DiagnosticHint = {provider = 'DiagnosticHint', icon = '  ', highlight = {colors.vivid_blue, colors.bg}}
})

table.insert(gls.right, {DiagnosticInfo = {provider = 'DiagnosticInfo', icon = '  ', highlight = {colors.info_yellow, colors.bg}}})

table.insert(gls.right, {
    ShowLspClient = {
        provider = 'GetLspClient',
        condition = function()
            local tbl = {['dashboard'] = true, [' '] = true}
            if tbl[vim.bo.filetype] then return false end
            return true
        end,
        icon = ' ',
        highlight = {colors.grey, colors.bg},
        separator = '  ',
        separator_highlight = {colors.bg, colors.bg},
    }
})

table.insert(gls.right, {
    ShowEditorConfigApplied = {
        provider = function()
            if vim.b.editorconfig_applied == 1 then
                return "Active:"..vim.api.nvim_buf_get_option(0, "shiftwidth")
            else
                return vim.api.nvim_buf_get_option(0, "shiftwidth")
            end
        end,
        condition = buffer_not_empty,
        icon = ' ',
        highlight = {colors.grey, colors.bg},
        separator = '  ',
        separator_highlight = {colors.bg, colors.bg},
    }
})

table.insert(gls.right, {
    Space = {
        provider = function()
            return '  '
        end,
        separator = ' ',
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.orange, colors.bg}
    }
})

table.insert(gls.right, {
    BufferType = {
        provider = 'FileTypeName',
        condition = condition.hide_in_width,
        separator = '  ',
        separator_highlight = {colors.grey, colors.bg},
        highlight = {colors.grey, colors.bg}
    }
})

table.insert(gls.right, {
    FileEncode = {
        provider = downcase(fileinfo.get_file_encode),
        condition = condition.hide_in_width,
        separator = '  ',
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.grey, colors.bg}
    }
})

table.insert(gls.right, {
    PerCent = {
        provider = {'LineColumn','LinePercent'},
        separator = ' ',
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.grey, colors.bg}
    }
})


table.insert(gls.short_line_left, {
    BufferType = {
        provider = 'FileTypeName',
        separator = ' ',
        separator_highlight = {colors.grey, colors.bg},
        highlight = {colors.grey, colors.bg}
    }
})

table.insert(gls.short_line_left, {
    SFileName = {
        provider = 'SFileName',
        condition = condition.buffer_not_empty,
        highlight = {colors.grey, colors.bg}
    }
})

return statusline
