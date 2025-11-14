return {
  'tpope/vim-rails',
  config = function()
    vim.g.rails_projections = {
      ["app/controllers/*_controller.rb"] = {
        test = { "spec/requests/{}_spec.rb" },
      },
      ["spec/requests/*_spec.rb"] = {
        alternate = { "app/controllers/{}_controller.rb" },
      },
      ["app/javascript/controllers/*.js"] = {
        alternate = { "spec/javascript/controllers/{}.spec.js" },
      },
      ["spec/javascript/controllers/*.spec.js"] = {
        alternate = { "app/javascript/controllers/{}.js" }
      },
      ["app/javascript/modules/*.js"] = {
        alternate = { "spec/javascript/modules/{}.spec.js" },
      },
      ["spec/javascript/modules/*.spec.js"] = {
        alternate = { "app/javascript/modules/{}.js" }
      }
    }
  end
}
