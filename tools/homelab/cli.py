from cyclopts import App
from plumbum import local, FG, BG
from rich.console import Console
from rich.spinner import Spinner
from rich.prompt import Confirm
from pathlib import Path
import json

tofu = local["tofu"]
helmfile = local["helmfile"]
galaxy = local["ansible-galaxy"]
playbook = local["ansible-playbook"]

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

    with local.cwd("infra/ansible"):
        galaxy("collection", "install", "-r", "collections/requirements.yml")

@app.command
def deploy():
    """
    Deploys all OpenTofu and Helm charts, with a summary of changes.
    """
    console.rule("Ansible Deployment")

    with local.cwd("infra/ansible"):
        with console.status("Upgrading archlinux node…"):
            try:
                output = playbook("-i", "inventory.ini", "upgrade.yml")
            except Exception as e:
                console.print(f"[bold red]Ansible failed:[/] {e}")
                return
        print(output)

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

        if Confirm.ask("Do you want to apply the changes?", default=True):
            with console.status("Applying OpenTofu…"):
                tofu("apply", "tfplan")
        else:
            console.print("[bold red]Deployment cancelled[/]")

    tfplan_path = Path("infra/tofu/tfplan")
    if tfplan_path.exists():
        tfplan_path.unlink()
        console.print("[dim]Removed temporary plan file[/]")


    console.rule("Helmfile Deployment")
    with console.status("Applying Helmfile…"):
        with local.cwd("infra"):
            try:
                output = helmfile("-q", "apply", "--skip-deps", "--skip-refresh")
            except Exception as e:
                console.print(f"[bold red]Helmfile failed:[/] {e}")
                return
        print(output)

    console.rule("Deployment Summary")
    console.print("[bold green]Deployment complete[/]")
    console.print()

@app.default
def default_action():
    app.help_print()

app()
