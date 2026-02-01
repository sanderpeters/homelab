from cyclopts import App
from plumbum import local, FG
from rich.console import Console
from rich.spinner import Spinner

tofu = local["tofu"]
helmfile = local["helmfile"]
kubectl = local["kubectl"]

console = Console()

app = App(
    name="homelab"
)

@app.command
def init():
    """
    Initializes the homelab workspace
    """
    with local.cwd("infra/tofu"):
        tofu("init")

@app.command
def deploy():
    """
    Deploys all OpenTofu and Helm charts, with a summary of changes.
    """
    console.rule("OpenTofu Deployment")
    with console.status("[bold green]Applying OpenTofu…[/]") as status:
        with local.cwd("infra/tofu"):
            try:
                tofu("apply", "-auto-approve", "-json")
            except Exception as e:
                console.print(f"[bold red]Tofu failed:[/] {e}")
                return

    console.rule("Helmfile Deployment")
    with console.status("[bold blue]Applying Helmfile…[/]") as status:
        with local.cwd("infra"):
            try:
                helmfile("apply")
            except Exception as e:
                console.print(f"[bold red]Helmfile failed:[/] {e}")
                return

    console.rule("Deployment Summary")
    console.print("✅ Deployment Complete")

@app.default
def default_action():
    app.help_print()

app()
