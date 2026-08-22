# Security policy

## Supported versions

Only the current `master` branch is supported. The image is rebuilt from the
latest patched packages rather than versioned, so "supported" means the most
recent build.

## Reporting a vulnerability

Report anything you find through
[GitHub security advisories](https://github.com/konstruktoid/container-ubuntu-build/security/advisories/new),
not as a public issue.

Please include what the issue is, how to reproduce it, and which image digest or
commit you saw it on.

## Scope

How this repository builds and configures the image is in scope: the
`Dockerfile`, the shipped configuration, the entry point scripts and the
GitHub Actions workflows.

A vulnerability in a package the image installs is in scope as a report as
well, even when the fix itself belongs to the distribution or to the upstream
project. The published image carries that package, and when the image is
rebuilt is decided here. Reports like that are triaged here and coordinated
upstream where the fix has to be made.
