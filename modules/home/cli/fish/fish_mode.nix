_: {
  body = # fish
    ''
      # Do nothing if not in vi mode
      if test "$fish_key_bindings" = fish_vi_key_bindings
      or test "$fish_key_bindings" = fish_hybrid_key_bindings
      switch $fish_bind_mode
        case default
          echo (set_color --bold grey)\[(set_color red)N(set_color grey)\](set_color normal)
        case insert
          echo (set_color --bold grey)\[(set_color blue)I(set_color grey)\](set_color normal)
        case replace_one
          echo (set_color --bold grey)\[(set_color green)R(set_color grey)\](set_color normal)
        case replace
          echo (set_color --bold grey)\[(set_color cyan)R(set_color grey)\](set_color normal)
        case visual
          echo (set_color --bold grey)\[(set_color magenta)V(set_color grey)\](set_color normal)
      end
      set_color normal
      echo -n -s
      end
    '';
}
