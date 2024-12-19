### flake.nix
```nix
module = inputs.haumea.lib.load {
 src = ./modules/nixos;
 inputs = {
   inherit inputs;
   rself = self;
 };
 loader = inputs.haumea.lib.loaders.default lib;
 # transformer = inputs.haumea.lib.transformers.liftDefault;
};

```
