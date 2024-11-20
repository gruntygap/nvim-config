local function starsetf(ft, opts)
  return {
    function(path, bufnr)
      -- Note: when `ft` is a function its return value may be nil.
      local f = type(ft) ~= 'function' and ft or ft(path, bufnr)
      if not vim.g.ft_ignore_pat then
        return f
      end

      local re = vim.regex(vim.g.ft_ignore_pat)
      if not re:match_str(path) then
        return f
      end
    end,
    {
      -- Starset matches should have lowest priority by default
      priority = (opts and opts.priority) or -math.huge,
    },
  }
end


-- filetype shtuff

-- Correct priority for dockerfiles that end in an existing extension
vim.filetype.add({
  pattern = {
    ['Dockerfile%..*'] = starsetf('dockerfile', { priority = math.huge })
  }
})

