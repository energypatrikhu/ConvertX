# ConvertX with NVIDIA Support

A Docker image based on [ConvertX](https://github.com/C4illin/ConvertX) **built with NVIDIA GPU support** for hardware-accelerated media conversion.

## Key Features

- **NVIDIA GPU Acceleration**: Built with NVIDIA CUDA toolkit and FFmpeg NVENC support for hardware-accelerated video encoding/decoding
- **Automatic Updates**: Monitors upstream ConvertX releases and automatically builds new versions
- Based on the latest ConvertX release

## Prerequisites

- Docker installed
- NVIDIA GPU
- NVIDIA Container Toolkit installed on the host system

## What's Included

This image extends the base ConvertX image with:

- NVIDIA CUDA Toolkit
- FFmpeg NVENC development libraries
- Debian non-free repositories for additional codec support

## Automatic Updates

The repository includes an automated script that:

1. Checks for new ConvertX releases
2. Automatically builds and publishes updated Docker images
3. Tags images with version numbers and `latest`
4. Commits version changes to the repository

## License

This project follows the same license as the upstream ConvertX project.

## Links

- [ConvertX Repository](https://github.com/C4illin/ConvertX)
