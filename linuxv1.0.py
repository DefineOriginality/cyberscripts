import subprocess, os

"""
content covered:
- ufw, lock root
- passwords
- services
"""

def cmd(parts):
  return subprocess.run(parts,
    capture_output=True,
    text=True,
    check=True).stdout
def confirm(prompt="continue?"):
  return (input(f"{prompt} (y/n) ").lower() == "y")

print("\n== running jeffrey's v1.0 script ==\n")

# firewall
if "Firewall is active" in cmd(["sudo", "ufw", "enable"]):
  print("firewall enabled\n")
else:
  quit("error when enabling ufw")

# lock root
cmd(["sudo", "passwd", "-ld", "root"])
print("root has been locked\n")

# change passwords
weak_users = [] # can be preset
if len(weak_users) == 0 and confirm("no users set, add your own?"):
  ans = "null"
  while ans != "":
    ans = input("enter a username, blank to confirm: ").lower()
    weak_users.append(ans)
  weak_users.pop()

new = "qwertyuiopASDFGHJKL123$$$"
for user in weak_users:
  print(f"changing password for user {user}")
  cmd(["echo", f"\"{user}:{new}\"", "|", "sudo", "chpasswd"])
print("passwords finished\n")

# services
bad_services = ["dsniff","hydra","aircrack-ng","wireshark",
"knocker","nmap","zenmap","kismet","medusa","ophcrack",
"4g8","ettercap*","p0f","john","nikto"]
services = cmd(["sudo", "apt-mark", "showmanual"]).split("\n")

found = []
for bad in bad_services:
  if bad in services:
    print(f"found service {bad}")
    if confirm(f"delete {bad}?"):
      subprocess.run(["sudo", "apt", "purge", bad])
      print(f"deleted {bad}")

if len(found) == 0:
  print("no confirmed bad services found")
else:
  print(f"found services: {found}")
print("services finished\n")

# login.defs here
if confirm("set login.defs? only run in a vm!"):
  print("i can't do that yet.\n")
else:
  print("login.defs skipped\n")

print("== script finished ==\n")