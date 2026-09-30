local function create_tinymist_command(command_name, client, bufnr)
  local export_type = command_name:match 'tinymist%.export(%w+)'
  local info_type = command_name:match 'tinymist%.(%w+)'
  
  -- Cleanly format the command names (handles get, pin, and start)
  local cmd_display = export_type or info_type:gsub('^get', 'Get'):gsub('^pin', 'Pin'):gsub('^start', 'Start')
  
  local function run_tinymist_command()
    local arguments = { vim.api.nvim_buf_get_name(bufnr) }
    local title_str = export_type and ('Export ' .. cmd_display) or cmd_display
    
    local function handler(err, res)
      if err then
        return vim.notify(err.code .. ': ' .. err.message, vim.log.levels.ERROR)
      end
      -- Suppress success notifications for automated PDF exports to keep the command line clean
      if command_name ~= 'tinymist.exportPdf' then
        vim.notify(vim.inspect(res), vim.log.levels.INFO)
      end
    end
    
    return client:exec_cmd({
      title = title_str,
      command = command_name,
      arguments = arguments,
    }, { bufnr = bufnr }, handler)
  end
  
  -- Construct a readable command name and description
  local cmd_name = export_type and ('TinymistExport' .. cmd_display) or ('Tinymist' .. cmd_display) ---@type string
  local cmd_desc = export_type and ('Export to ' .. cmd_display) or ('Get ' .. cmd_display) ---@type string
  
  return run_tinymist_command, cmd_name, cmd_desc
end

return {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  root_markers = { 'typst.toml', '.git' },
  
  -- Use "onSave" to ensure the PDF is fully written before Skim tries to read it
  settings = {
    exportPdf = "onSave",
    formatterMode = "typstyle",
  },

  on_attach = function(client, bufnr)
    -- Generate native Neovim user commands for all Tinymist actions
    for _, command in ipairs {
      'tinymist.exportSvg',
      'tinymist.exportPng',
      'tinymist.exportPdf',
      'tinymist.exportMarkdown',
      'tinymist.exportText',
      'tinymist.exportQuery',
      'tinymist.exportAnsiHighlight',
      'tinymist.getServerInfo',
      'tinymist.getDocumentTrace',
      'tinymist.getWorkspaceLabels',
      'tinymist.getDocumentMetrics',
      'tinymist.pinMain',
      'tinymist.startDefaultPreview'
    } do
      local cmd_func, cmd_name, cmd_desc = create_tinymist_command(command, client, bufnr)
      vim.api.nvim_buf_create_user_command(bufnr, 'Lsp' .. cmd_name, cmd_func, { nargs = 0, desc = cmd_desc })
    end

    -- Map \ll to open the compiled PDF in Skim asynchronously
    vim.keymap.set('n', '\\ll', function()
      local filepath = vim.api.nvim_buf_get_name(bufnr)
      if filepath == "" then return end
      
      -- Swap the .typ extension for .pdf
      local pdf_path = vim.fn.fnamemodify(filepath, ':r') .. '.pdf'
      
      -- Launch Skim via macOS shell without blocking Neovim
      vim.fn.jobstart({ "open", "-a", "Skim", pdf_path }, { detach = true })
      vim.notify("Opened " .. pdf_path .. " in Skim", vim.log.levels.INFO)
    end, { buffer = bufnr, silent = true, desc = 'Open Typst PDF in Skim' })
  end,
}
