# Builder
Builder is a library to build instances in Roblox, similar to Roact and Fusion.

## Documentation
https://realethanplayzdev.github.io/Builder/About/

## Install Builder
- Install via Wally, add the following to your ``wally.toml`` file:
```
Builder = "realethanplayzdev/builder@0.1.4
```
- Get an rbxm from [GitHub Actions build](https://github.com/RealEthanPlayzDev/Builder/actions/workflows/build.yml) (latest commits, potentially unstable) (needs a GitHub account to download artifacts)
- Get an rbxm from [releases](https://github.com/RealEthanPlayzDev/Builder/releases)
- Copy the source tree directly into your project
- [Build manually](#building-builder)

## Building Builder
- On VSCode: Run the build task
- On a terminal:
```
rojo build default.project.json --output Builder.rbxm
```