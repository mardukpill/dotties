_: {
  programs.nixvim.plugins = {
    mini = {
      enable = true;
      modules = {
        starter = {
          header = ''
                                                         iiii                            iiii                                                   d::::::d
                                                        i::::i                          i::::i                                                  d::::::d
                                                         iiii                            iiii                                                   d::::::d
                                                                                                                                                d:::::d 
            nnnn  nnnnnnnn    vvvvvvv           vvvvvvviiiiiii    mmmmmmm    mmmmmmm   iiiiiii zzzzzzzzzzzzzzzzz    eeeeeeeeeeee        ddddddddd:::::d 
            n:::nn::::::::nn   v:::::v         v:::::v i:::::i  mm:::::::m  m:::::::mm i:::::i z:::::::::::::::z  ee::::::::::::ee    dd::::::::::::::d 
            n::::::::::::::nn   v:::::v       v:::::v   i::::i m::::::::::mm::::::::::m i::::i z::::::::::::::z  e::::::eeeee:::::ee d::::::::::::::::d 
            nn:::::::::::::::n   v:::::v     v:::::v    i::::i m::::::::::::::::::::::m i::::i zzzzzzzz::::::z  e::::::e     e:::::ed:::::::ddddd:::::d 
              n:::::nnnn:::::n    v:::::v   v:::::v     i::::i m:::::mmm::::::mmm:::::m i::::i       z::::::z   e:::::::eeeee::::::ed::::::d    d:::::d 
              n::::n    n::::n     v:::::v v:::::v      i::::i m::::m   m::::m   m::::m i::::i      z::::::z    e:::::::::::::::::e d:::::d     d:::::d 
              n::::n    n::::n      v:::::v:::::v       i::::i m::::m   m::::m   m::::m i::::i     z::::::z     e::::::eeeeeeeeeee  d:::::d     d:::::d 
              n::::n    n::::n       v:::::::::v        i::::i m::::m   m::::m   m::::m i::::i    z::::::z      e:::::::e           d:::::d     d:::::d 
              n::::n    n::::n        v:::::::v        i::::::im::::m   m::::m   m::::mi::::::i  z::::::zzzzzzzze::::::::e          d::::::ddddd::::::dd
              n::::n    n::::n         v:::::v         i::::::im::::m   m::::m   m::::mi::::::i z::::::::::::::z e::::::::eeeeeeee   d:::::::::::::::::d
              n::::n    n::::n          v:::v          i::::::im::::m   m::::m   m::::mi::::::iz:::::::::::::::z  ee:::::::::::::e    d:::::::::ddd::::d
              nnnnnn    nnnnnn           vvv           iiiiiiiimmmmmm   mmmmmm   mmmmmmiiiiiiiizzzzzzzzzzzzzzzzz    eeeeeeeeeeeeee     ddddddddd   ddddd
          '';

          evaluate_single = true;
        };
      };
    };
  };
}
