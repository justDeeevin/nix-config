{
  programs.nixvim.plugins.harpoon = {
    enable = true;
    enableTelescope = true;
    keymaps = {
      addFile = "<leader>a";
      toggleQuickMenu = "<C-e>";
    };
  };
}
