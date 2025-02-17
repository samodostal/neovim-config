local M = {}

local function term_wrapper(command, file)
	vim.cmd "vnew"
	vim.cmd "vertical resize 70"
	vim.cmd("term " .. string.format(command, file))
	vim.cmd "silent! file CompileAndRun"
	vim.cmd "set nobuflisted"
	vim.cmd "setl nornu nonu nocul so=0 scl=no"
	vim.cmd "startinsert"
end

local function get_commands()
	return {
		c = { "gcc -std=c99 -pedantic -Wall -Wextra -o out %s && ./out" },
		cpp = {
			"g++ -std=c++20 -Wall -Wextra -o out %s && ./out",
			"clang++ -std=c++20 -Wall -Wextra -o out %s && ./out",
		},
		javascript = { "node %s" },
		java = {
			"cd src && find . -type f -name '*.class' -delete && javac gui/LoginScreen.java -Xlint:unchecked && java -cp . gui/LoginScreen",
		},
		go = { "go run %s" },
		python = {
			"python3 %s",
			"python3 %s --input " .. vim.fn.expand "%:p:h" .. "/input.txt",
		},
		haskell = { "runhaskell %s" },
		sh = { "%s" },
	}
end

M.compile_and_run = function(index)
	local filetype = vim.bo.filetype
	local cmd_list = get_commands()[filetype]

	if cmd_list then
		local command = cmd_list[math.max(1, index or 1)] -- Default to first command if index is nil
		if command then
			if filetype == "python" then
				vim.cmd("!" .. command:format(vim.fn.expand "%"))
			else
				term_wrapper(command, vim.fn.expand "%")
			end
		else
			print(string.format('Invalid index for filetype "%s".', filetype))
		end
	else
		print(string.format('Filetype "%s" is not yet supported.', filetype))
	end
end

return M
