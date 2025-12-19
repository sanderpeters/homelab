#!/usr/env/bin python

from cyclopts import App

app = App()

@app.command
def upgrade():
    print("We're upgrading!")

@app.default
def default_action():
    print("Hello world! This runs when no command is specified.")

app()