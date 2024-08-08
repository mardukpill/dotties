<div align="center">
  <h1>
   <img src="https://nixos.org/logo/nixos-logo-only-hires.png" height="25" /> My NixOS Configuration </a>
  </h1>
</div>

<p align="center">
  <a href="https://github.com/snowfallorg/lib" target="_blank">
 <img alt="Built With Snowfall" src="https://img.shields.io/static/v1?logoColor=d8dee9&label=Built%20With&labelColor=5e81ac&message=Snowfall&color=d8dee9&style=for-the-badge">
</a>
 <a href="https://github.com/mardukpill/dotties/commits"><img src="https://img.shields.io/github/last-commit/mardukpill/dotties?colorA=363a4f&colorB=f5a97f&style=for-the-badge"></a>
  <a href="https://wiki.nixos.org/wiki/Flakes" target="_blank">
 <img alt="Nix Flakes Ready" src="https://img.shields.io/static/v1?logo=nixos&logoColor=d8dee9&label=Nix%20Flakes&labelColor=5e81ac&message=Ready&color=d8dee9&style=for-the-badge">
</a>
</p>


<h2 align="center">
  About
</h2>
Soon after starting my NixOS journey, it dawned on me that there is no standardized way of creating nix configurations, which is great for small projects, but can become a nightmare for larger ones. This is when I discovered Snowfall-lib. It provides a structured, but flexible way to create NixOS flakes that ensures my multi-system configuration stays (fairly) organized.

<p>

Snowfall-lib also automatically exports packages. You can try running a simple package from this repository on a Nix system using the following command.
  
 ```bash
nix run github:mardukpill/dotties#hi
```

<h2 align="center">
  Systems
</h2>

<div align="center">
  
| Host| CPU | GPU | RAM | STORAGE | 
| --------------- | --------------- | --------------- | --------------- | --------------- |
| blade | i7-12800h | RTX 3070Ti| 32GB DDR5 | 1+2TB |
| stirps | i5-10300h | GTX 1650 | 16GB DDR4 | 256+500GB |
| lantern | migration needed | -| - | - |
| jawbone | migration needed | -| - | - |
| splinter | planned | - | - | - |
| wsl | planned | - | - | - |

</div>

<h2 align="center">
  Structure
</h2>

```bash
.
├── homes
│   └── x86_64-linux
│       ├── mike@blade
│       └── mike@stirps
├── lib
│   ├── colorschemes
│   └── module
├── modules
│   ├── home
│   │   ├── apps
│   │   ├── cli
│   │   ├── services
│   │   ├── suites
│   │   ├── themes
│   │   ├── utility
│   │   └── wms
│   └── nixos
│       ├── apps
│       ├── cli
│       ├── dms
│       ├── hw
│       ├── system
│       ├── user
│       ├── utility
│       └── wms
├── overlays
├── packages
└── systems
    └── x86_64-linux
        ├── blade
        └── stirps
```

<h2 align="center">
  Screenshots
</h2>
 <img alt="neovim" src="https://ploop.city/rosecandy/rosecandy-neovim.png">
 <img alt="busy" src="https://ploop.city/rosecandy/rosecandy-busy.png">
 <img alt="anyrun" src="https://ploop.city/rosecandy/rosecandy-anyrun.png">

<h2 align="center">
  Planned
</h2>

- [ ] lantern system configuration for homelab
- [ ] wsl system configuration
- [ ] multiple rices (acrylic theme)
- [ ] templates for creating new projects
- [ ] sops-nix for managing secrets

<h2 align="center">
  Inspiration & Thanks
</h2>

- [ok-nick/dotfiles](https://github.com/ok-nick/dotfiles)
- [JakeHamilton/config](https://github.com/jakehamilton/config)
- [khaneliman/khanelinix](https://github.com/khaneliman/khanelinix)
