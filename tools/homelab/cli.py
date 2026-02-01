from cyclopts import App
from plumbum import local, FG, BG
from rich.console import Console
from rich.spinner import Spinner
from rich.prompt import Confirm
from pathlib import Path
import json

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

    with local.cwd("infra/tofu"):
        with console.status("Creating plan…"):
            try:
                tofu("plan", "-out=tfplan")
            except Exception as e:
                console.print(f"[bold red]Tofu failed:[/] {e}")
                return

        plan = tofu("show", "tfplan")
        print(plan)

        if (Confirm.ask("Do you want to apply the changes?", default=True)):
            with console.status("Applying OpenTofu…"):
                tofu("apply", "tfplan")
        else:
            console.print("[yellow]❌ Deployment cancelled[/]")

    tfplan_path = Path("infra/tofu/tfplan")
    if tfplan_path.exists():
        tfplan_path.unlink()
        console.print("[dim]Removed temporary plan file[/]")


    console.rule("Helmfile Deployment")
    with console.status("Applying Helmfile…"):
        with local.cwd("infra"):
            try:
                output = helmfile("-q", "apply")
            except Exception as e:
                console.print(f"[bold red]Helmfile failed:[/] {e}")
                return
        print(output)

    console.rule("Deployment Summary")
    console.print("✅ Deployment Complete")
    console.print()

@app.default
def default_action():
    app.help_print()

app()
