import urllib.request
import tarfile
import os.path
import shutil
import sys

home = os.path.expanduser("~")

def show_progress(count, blockSize, totalSize):
    progress = (int(count * blockSize * 100 / totalSize))
    sys.stdout.write("Download progress: %d%%   \r" % (progress) )
    sys.stdout.flush()

if os.path.exists(home + "/.julia/bin/julia"):
    if len(sys.argv) >= 2 and sys.argv[1]=="--force":
        shutil.rmtree(home + "/.julia/")
    else:
        print("Binaries exist already. Run again with --force to try again.")
        sys.exit()

tarball = urllib.request.URLopener()
tarball.retrieve("https://julialang.s3.amazonaws.com/bin/linux/x64/0.5/julia-0.5.2-linux-x86_64.tar.gz", home + "/julia.tar.gz", reporthook=show_progress)

extract = tarfile.open(name=home + "/julia.tar.gz")
extract.extractall(path=home)

shutil.move(home + "/julia-f4c6c9d4bb/", home + "/.julia/")

if not os.path.isdir(home + "/.julia/bin"):
    os.environ["PATH"] += os.pathsep + (home + "/.julia/bin")
    with open(home + "/.profile", "a") as profile:
        profile.write("#julia install\nexport PATH=$PATH:$HOME/.julia/bin\n")

os.remove(home + "/julia.tar.gz")

print("\n...done. Installed to " + home + "/.julia/")
