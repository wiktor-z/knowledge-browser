"""CLI entrypoint for offline worker tasks."""

import typer

app = typer.Typer(no_args_is_help=True, help="Knowledge Browser worker CLI")


@app.callback()
def command_group() -> None:
    """Define the root command group for worker subcommands."""


@app.command()
def ping() -> None:
    """Return a deterministic readiness response."""

    typer.echo("ok")


def main() -> None:
    """Run the Typer application."""

    app()


if __name__ == "__main__":
    main()
