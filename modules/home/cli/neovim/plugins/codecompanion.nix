{ ... }:
{
  programs.nixvim = {
    plugins = {
      codecompanion = {
        enable = true;
        settings = {
          agent.adapter = "ollama";
          chat.adapter = "ollama";
          inline.adapter = "ollama";
          adapters = {
            ollama = {
              __raw = # Lua
                ''
                  function()
                    return require('codecompanion.adapters').extend('ollama', {
                      env = {
                        url = "http://127.0.0.1:11434",
                      },
                      schema = {
                        model = {
                          default = 'deepseek-r1:8b',
                        },
                        num_ctx = {
                          default = 32768,
                        },
                      },
                    })
                  end
                '';
            };
          };
        };
      };
    };
  };
}
