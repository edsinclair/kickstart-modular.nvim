return {
  'tpope/vim-rails',
  config = function()
    vim.g.rails_projections = {
      ["app/controllers/*_controller.rb"] = {
        test = { "spec/requests/{}_spec.rb" },
      },
      ["spec/requests/*_spec.rb"] = {
        alternate = { "app/controllers/{}_controller.rb" },
      }
    }
  end
}
