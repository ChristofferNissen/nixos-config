# Project README

This project contains dotfiles for NixOS, a Linux distribution built on the Nix package manager. The dotfiles are used to customize the user's environment and provide a consistent setup across different machines.

Inspiration: https://github.com/kuznero/dotfiles

## Purpose

The purpose of this project is to simplify the management of dotfiles and configurations on NixOS. By centralizing all the dotfiles in one place, it becomes easier to version control, share, and replicate the desired environment on multiple machines.

## Getting Started

To use the dotfiles in this project, follow these steps:

1. Clone the repository to your local machine.
2. Navigate to the `flake.nix` file in the project directory.
3. Run the following command to build and activate the environment:

```bash
nix develop
```

This will set up the environment with the specified dotfiles and configurations.

## Contributing

Contributions to this project are welcome. If you have any improvements or suggestions, feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).
