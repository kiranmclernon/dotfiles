import subprocess
from datetime import datetime
from typing import cast
import sys
import os
import signal

def run_command():
    swift_pid = int(sys.argv[1])
    find_command= [
        "find",
        "/Applications",
        "/System/Applications",
        "/System/Applications/Utilities",
        "-maxdepth", "1",
        "-name", "*.app"
    ]

    sed_command = ["sed", 's/.*/"&"/']
    xargs_command = ["xargs", "mdls"]


    find_commands_command = [
        "find",
        os.path.expanduser("~/.config/.commands/commands"),
        "-maxdepth", "1",
        "-type", "f",
        "-exec", "basename", "{}", "+"
    ]

    find_commands_result = subprocess.run(find_commands_command, capture_output=True, text=True)

    if find_commands_result.returncode != 0:
        print(f"erorr finding commands: {find_commands_result.stderr}")
        return


    find_result = subprocess.run(find_command, capture_output=True, text=True)

    if find_result.returncode != 0:
        print(f"Error running find: {find_result.stderr}")
        return

    sed_result = subprocess.run(sed_command, input=find_result.stdout, capture_output=True, text=True)

    if sed_result.returncode != 0:
        print(f"Error running sed: {sed_result.stderr}")
        return

    xargs_result = subprocess.run(xargs_command, input=sed_result.stdout, capture_output=True, text=True)

    if xargs_result.returncode != 0:
        print(f"Error running xargs: {xargs_result.stderr}")
        return

    results: list[tuple[str, str] | tuple[str]] = []
    output_lines = xargs_result.stdout.splitlines()
    for line in output_lines:
        if line.startswith("_kMDItemDisplayNameWithExtension"):
            if len(results) > 0 and len(results[-1]) == 1:
                results[-1] = (results[-1][0], "1970-01-01 00:00:00 +0000")
            results.append((line.split("=")[1].strip().strip('"').split(".")[0],))
        if len(results) > 0 and line.startswith("kMDItemLastUsedDate") and len(results[-1]) == 1:
            results[-1] = (results[-1][0], line.split("=")[1].strip().strip('"'))

    if len(results) > 0 and len(results[-1]) == 1:
        results[-1] = (results[-1][0], "1970-01-01 00:00:00 +0000")

    sorted_results = [x[0] for x in (sorted(
        cast(tuple[str, str], cast(object, results)),
        key=lambda x: datetime.strptime(x[1], "%Y-%m-%d %H:%M:%S %z"),
        reverse=True
    ))]


    apps = set(sorted_results)

    fzf_input = "\n".join(find_commands_result.stdout.splitlines() + sorted_results)


    fzf_command = ["fzf", "--tiebreak", "index"]
    os.kill(swift_pid, signal.SIGUSR1)
    fzf_result = subprocess.run(fzf_command, input=fzf_input, capture_output=True, text=True)

    if fzf_result.returncode != 0:
        print(f"Error running fzf: {fzf_result.stderr}")
    else:
        result = fzf_result.stdout.strip()
        if result in apps:
            find_command= [
                "find",
                "/Applications",
                "/System/Applications",
                "/System/Applications/Utilities",
                "-maxdepth", "1",
                "-name", f"*{result}*",
            ]
            find_result = subprocess.run(find_command, capture_output=True, text=True)

            if find_result.returncode != 0:
                print(f"Error running find: {find_result.stderr}")
                return

            open_command = [
                "open",
                str(find_result.stdout.splitlines()[0])
            ]

            open_result = subprocess.run(open_command, capture_output=True, text=True)
            if open_result.returncode != 0:
                print(f"error running open: {open_result.stderr}")
            else:
                return
        else:
            command_path = os.path.expanduser("~/.config/.commands/commands") + "/" + result
            command_result = subprocess.run([command_path])
            if(command_result.returncode != 0):
                print(f"command erorred: {command_result.stderr}")
            else:
                return

if __name__ == "__main__":
    run_command()
