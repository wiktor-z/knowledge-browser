from typer.testing import CliRunner

from kb_worker.cli import app

runner = CliRunner()


def test_cli_help() -> None:
    result = runner.invoke(app, ["--help"])

    assert result.exit_code == 0
    assert "Usage" in result.stdout


def test_cli_ping() -> None:
    result = runner.invoke(app, ["ping"])

    assert result.exit_code == 0
    assert result.stdout.strip() == "ok"
