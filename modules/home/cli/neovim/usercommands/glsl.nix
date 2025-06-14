{
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  home.packages = with pkgs; [
  ];
  programs.nixvim = {
    userCommands = {
      PreviewGLSL = {
        command.__raw = ''
          function(args)
            local current_file = vim.fn.expand('%:p')
            
            -- Check if the file exists
            if vim.fn.filereadable(current_file) == 0 then
              vim.notify("Current buffer must be saved first", vim.log.levels.ERROR)
              return
            end
            
            -- Check if file is a valid GLSL shader
            local ext = vim.fn.expand('%:e')
            local valid_exts = {glsl = true, frag = true, vert = true, fs = true, vs = true}
            
            if not valid_exts[ext] then
              vim.notify("File doesn't seem to be a GLSL shader", vim.log.levels.WARN)
              -- Continue anyway as user might want to preview it regardless
            end
            
            -- Build the command
            local cmd = "env DISPLAY:=0 glslviewer " .. vim.fn.shellescape(current_file) .. " -w &"
            
            -- Run the command
            vim.fn.system(cmd)
            vim.notify("GLSL Viewer started for " .. current_file, vim.log.levels.INFO)
          end
        '';
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>pv";
        action = "<cmd>PreviewGLSL<CR>";
        options = {
          silent = true;
          desc = "Live preview current GLSL shader.";
        };
      }
    ];
  };
}
