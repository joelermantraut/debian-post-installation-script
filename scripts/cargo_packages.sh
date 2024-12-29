#!/bin/bash

echo "Installing Rust and Cargo packages..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y || echo "Failed to install Rust."

cargo install --locked yazi-fm || echo "Failed to install yazi-fm."
