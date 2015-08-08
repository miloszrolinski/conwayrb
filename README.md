conwayrb
========

Overview
--------

This is a simple implementation of Conway's 'Game of life' in Ruby and GTK3.
Uses a square table of cells (for convenience, the implementation doesn't really care).
Basic functionality includes an 'Initial settings' window to give some starting 
properties to work with, running the simulation on a 'turn-by-turn' basis or in loop,
as well as resetting the whole thing.

Purpose
-------

None really, I just wanted to make a project that's more or less fully featured 
in terms of tools used (git, bundler, proper coding style).

Ideas for future versions
-------------------------

1. Add more error checking
2. Make the game run with non-square tables
3. Enable cell-by-cell manipulation (changing the state from dead to alive with a button click)
4. Make cell image size different (to fit various screens/cell numbers), possible to choose
5. Enable saving the state and settings(YAML), loading them the next time program starts

