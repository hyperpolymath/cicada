# CIcaDA - Palimpsest Crypto Identity

## Project Overview

CIcaDA (Palimpsest Crypto Identity) is a Julia-based cryptographic identity management system focused on quantum-resistant SSH key generation and advanced security protocols.

**Project Name**: PalimpsestCryptoIdentity
**Language**: Julia 1.9+
**License**: Palimpsest License v0.4
**UUID**: 449d71e4-0569-4032-8a3c-f519b3386ebb

## Core Features

- 🌐 Quantum-Resistant SSH Key Generation
- 🔑 Multi-Factor Authentication
- 🛡️ Advanced Security Protocols
- 🖥️ Cross-Platform Support
- 🔍 Integrated Malware Scanner (submodule)

## Project Structure

```
CIcaDA/
├── src/
│   └── main.jl              # Main entry point and module definition
├── malware-scanner/         # Git submodule for malware scanning functionality
├── Project.toml             # Julia project dependencies and metadata
├── README.md                # User-facing documentation
├── LICENSE                  # Palimpsest License v0.4
└── CLAUDE.md               # This file
```

## Dependencies

Current dependencies (from Project.toml):
- **ArgParse** (v1.1+): Command-line argument parsing
- **Logging**: Built-in Julia logging functionality

## Development Guidelines

### Running the Project

```bash
# Install dependencies
julia --project=. -e 'using Pkg; Pkg.instantiate()'

# Run the main application
julia --project=. src/main.jl

# Generate SSH key (planned feature)
julia --project=. src/main.jl generate-key --email you@example.com
```

### Code Organization

- **Module Structure**: Code is organized in the `PalimpsestCryptoIdentity` module
- **Entry Point**: `src/main.jl` contains the main() function that serves as the application entry point
- **Script Mode**: The file can be run both as a module and as a standalone script

### Current Implementation Status

The project is in early development:
- ✅ Basic project structure established
- ✅ Module and entry point created
- ✅ Dependencies configured
- 🚧 Core cryptographic functionality (planned)
- 🚧 SSH key generation (planned)
- 🚧 Multi-factor authentication (planned)

## Git Submodules

This project uses git submodules:
- **malware-scanner**: Located at `https://github.com/hyperpolymath/malware-scanner.git`

When working with this repo, remember to initialize and update submodules:
```bash
git submodule update --init --recursive
```

## Architecture Notes

### Security Focus
This project deals with cryptographic operations and identity management. When making changes:
- Prioritize security best practices
- Use established cryptographic libraries
- Validate all inputs
- Follow Julia security guidelines for handling sensitive data
- Consider quantum-resistance in cryptographic choices

### Julia Specific Considerations
- Use Julia 1.9+ features
- Follow Julia style guide conventions
- Leverage multiple dispatch for clean API design
- Use type stability for performance
- Add docstrings to all public functions

## Testing

Currently no test suite is present. When implementing tests:
- Create a `test/` directory with `runtests.jl`
- Use Julia's built-in `Test` module
- Test cryptographic operations thoroughly
- Include security-focused test cases

## Future Development Areas

Based on the README and current structure, planned features include:
1. Quantum-resistant key generation algorithms
2. SSH key management utilities
3. Multi-factor authentication integration
4. GitHub integration with Personal Access Tokens
5. Cross-platform compatibility layer
6. Comprehensive documentation in `docs/`

## Working with Claude Code

When implementing features:
- Read relevant Julia documentation for cryptographic operations
- Check for existing Julia packages that provide quantum-resistant algorithms
- Consider using established libraries like `Nettle.jl`, `LibSodium.jl`, or similar
- Ensure all cryptographic operations follow current best practices
- Add appropriate logging using the Logging module
- Update this CLAUDE.md as the project evolves

## References

- Julia Documentation: https://docs.julialang.org/
- Quantum-Resistant Cryptography: NIST Post-Quantum Cryptography Project
- SSH Protocol: RFC 4251-4254
