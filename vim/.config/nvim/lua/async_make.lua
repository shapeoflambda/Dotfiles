local M = {}

-- Parses the text and returns the command and args in a table
-- @param command_text string: command text, e.g: "ls -la"
-- @return table representing the command and args
local function parse_command_text(command_text)
    local command_with_args = {}
    for token in string.gmatch(command_text, "[^%s]+") do
        table.insert(command_with_args, vim.fn.expand(token))
    end

    local command = command_with_args[1]
    local args = { unpack(command_with_args, 2, #command_with_args) }

    local results = {}
    results["cmd"] = command
    results["args"] = args

    return results
end

local function setqflist(results, errorformat, title)
    vim.fn.setqflist({}, 'r', {title =title, lines = results, efm = errorformat})
    vim.api.nvim_command('Trouble quickfix')
    local count = #results
    for i=0, count do results[i]=nil end -- clear the table for next search
end

-- Executes the given command asynchronously and populates the
-- quickfix list if an error format is supplied
-- @param command_text string: command text, e.g: "ls -la"
-- @param errorformat string: errorformat to use for parsing command output
function M.make(command_text, errorformat)
    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)

    local parsed_command = parse_command_text(command_text)
    local command = parsed_command['cmd']
    local args = parsed_command['args']

    local stdout_to_return = {}
    local stderr_to_return = {}

    local _, _ = vim.loop.spawn(command, {
        stdio = {_, stdout, stderr},
        args = args
    },
    vim.schedule_wrap(function()
        setqflist(stdout_to_return, errorformat, 'Async_Make')
        setqflist(stderr_to_return, errorformat, 'Async_Make')
    end)
    )

    vim.loop.read_start(stdout, function(err, data)
        assert(not err, err)
        if data then
            local vals = vim.split(data, "\n")
            for _, d in pairs(vals) do
                if d == "" then goto continue end
                table.insert(stdout_to_return, d)
                ::continue::
            end
        end
    end)

    vim.loop.read_start(stderr, function(err, data)
        assert(not err, err)
        if data then
            print(data)
            local vals = vim.split(data, "\n")
            for _, d in pairs(vals) do
                if d == "" then goto continue end
                table.insert(stderr_to_return, d)
                ::continue::
            end
        end
    end)

end

return M
