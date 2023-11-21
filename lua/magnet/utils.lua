local M = {}

function M.buf_vtext()
	local mode = vim.fn.mode()
	if mode ~= "v" and mode ~= "V" then
		return ""
	end

	local a_orig = vim.fn.getreg("a")
	vim.cmd([[silent! normal! "aygv]])
	local text = vim.fn.getreg("a")
	vim.fn.setreg("a", a_orig)

	return text
end

return M
